package main

import (
	"log"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"

	"zadanie4/controllers"
	"zadanie4/models"
	"zadanie4/services"
)

func main() {
	const preloadedSource = "Preloaded from initial list (DB)"

	// GORM i SQLite
	db, err := gorm.Open(sqlite.Open("weather_db.sqlite"), &gorm.Config{})
	if err != nil {
		log.Fatalf("Błąd wczytywania DB: %v", err)
	}

	db.AutoMigrate(&models.Weather{})

	var count int64
	db.Model(&models.Weather{}).Count(&count)
	if count == 0 {
		initialData := []models.Weather{
			{Location: "Warsaw", Temperature: 10.2, Condition: "Cloudy", Source: preloadedSource},
			{Location: "Krakow", Temperature: 14.5, Condition: "Sunny", Source: preloadedSource},
			{Location: "Gdansk", Temperature: 11.0, Condition: "Rain", Source: preloadedSource},
		}
		db.Create(&initialData)
		log.Println("Początkowe dane z listy zostały pomyślnie załadowane do bazy danych.")
	} else {
		log.Println("Baza danych zawiera stare dane.")
	}

	externalService := &services.ExternalWeatherService{}
	weatherProxy := &services.WeatherProxy{
		DB:              db,
		ExternalService: externalService,
	}

	weatherController := &controllers.WeatherController{
		Proxy: weatherProxy,
	}

	e := echo.New()
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/weather", weatherController.GetWeather)

	log.Println("Serwer uruchomiony na porcie 8081.")
	e.Logger.Fatal(e.Start(":8081"))
}
