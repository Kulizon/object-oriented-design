package controllers

import (
	"net/http"
	"strings"

	"github.com/labstack/echo/v4"
	"zadanie4/models"
	"zadanie4/services"
)

type WeatherController struct {
	Proxy services.WeatherProvider
}

func (wc *WeatherController) GetWeather(c echo.Context) error {
	locationsParam := c.QueryParam("locations")
	if locationsParam == "" {
		return c.JSON(http.StatusBadRequest, map[string]string{"error": "Podaj parametr np: /weather?locations=Tokyo,Berlin"})
	}

	locations := strings.Split(locationsParam, ",")
	var results []models.Weather

	for _, loc := range locations {
		locStr := strings.TrimSpace(loc)
		if locStr == "" {
			continue
		}

		weather, err := wc.Proxy.GetWeather(locStr)
		if err == nil && weather != nil {
			results = append(results, *weather)
		}
	}

	return c.JSON(http.StatusOK, results)
}
