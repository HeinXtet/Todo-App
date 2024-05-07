package models

import "gorm.io/gorm"

type User struct {
	gorm.Model
	ID       int64  `gorm:"column:id"`
	Email    string `gorm:"unique"`
	Password string
	Todo     []Todo
}
