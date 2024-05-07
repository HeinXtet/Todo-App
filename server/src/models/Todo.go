package models

import "gorm.io/gorm"

type Todo struct {
	gorm.Model
	ID          int64 `gorm:"column:id"`
	Name        string
	Description string
	IsDone      bool `gorm:"column:is_done"`
	UserID      int64
}
