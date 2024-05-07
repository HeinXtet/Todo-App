package main

import (
	Configs "dee.todoapp/src/configs"
	Routes "dee.todoapp/src/routes"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

var (
	db *gorm.DB = Configs.ConnectDatabase()
)

func main() {
	SetupServer()
}

func SetupServer() {
	defer Configs.DisconnectDB(db)
	route := gin.Default()

	Routes.SetupTodoRoute(route)
	Routes.SetupUserRoute(route)
	route.Run()
}
