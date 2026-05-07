package services

import (
	"encoding/json"
	"fmt"
	"net/http"
	"net/url"
	"strings"
	"time"

	"golang.org/x/text/cases"
	"golang.org/x/text/language"
	"gorm.io/gorm"
	"zadanie4/models"
)

var titleCaser = cases.Title(language.English)

func toTitleCase(s string) string {
	return titleCaser.String(strings.ToLower(s))
}

type WeatherProvider interface {
	GetWeather(location string) (*models.Weather, error)
}

type ExternalWeatherService struct{}

func (s *ExternalWeatherService) GetWeather(location string) (*models.Weather, error) {
	apiURL := fmt.Sprintf("https://wttr.in/%s?format=j1", url.PathEscape(location))
	client := http.Client{Timeout: 5 * time.Second}
	resp, err := client.Get(apiURL)

	if resp != nil {
		defer resp.Body.Close()
	}

	if err != nil || resp.StatusCode != http.StatusOK {
		// Fallback
		return &models.Weather{
			Location:    toTitleCase(location),
			Temperature: 0,
			Condition:   "API unavailable - Fallback",
			Source:      "External Mock API",
		}, nil
	}

	var result struct {
		CurrentCondition []struct {
			TempC       string `json:"temp_C"`
			WeatherDesc []struct {
				Value string `json:"value"`
			} `json:"weatherDesc"`
		} `json:"current_condition"`
	}

	if err := json.NewDecoder(resp.Body).Decode(&result); err != nil || len(result.CurrentCondition) == 0 {
		return nil, fmt.Errorf("błąd parsujący odpowiedź wttr.in")
	}

	temp := 0.0
	fmt.Sscanf(result.CurrentCondition[0].TempC, "%f", &temp)
	cond := ""
	if len(result.CurrentCondition[0].WeatherDesc) > 0 {
		cond = result.CurrentCondition[0].WeatherDesc[0].Value
	}

	return &models.Weather{
		Location:    toTitleCase(location),
		Temperature: temp,
		Condition:   cond,
		Source:      "External API (wttr.in)",
	}, nil
}

// WeatherProxy
type WeatherProxy struct {
	DB              *gorm.DB
	ExternalService WeatherProvider
}

func (p *WeatherProxy) GetWeather(location string) (*models.Weather, error) {
	normalizedLoc := toTitleCase(location)
	var weather models.Weather

	err := p.DB.Where("location = ?", normalizedLoc).First(&weather).Error
	if err == nil {
		weather.Source += " (Cache DB)"
		return &weather, nil
	}

	extWeather, err := p.ExternalService.GetWeather(normalizedLoc)
	if err != nil {
		return nil, err
	}

	p.DB.Create(extWeather)

	return extWeather, nil
}
