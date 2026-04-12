package models

import "gorm.io/gorm"

type Weather struct {
	gorm.Model  `json:"-"`
	Location    string  `json:"location" gorm:"uniqueIndex"`
	Temperature float64 `json:"temperature"`
	Condition   string  `json:"condition"`
	Source      string  `json:"source"`
}
