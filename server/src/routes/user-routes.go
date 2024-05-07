package routes

import (
	controllers "dee.todoapp/src/controllers"
	middlewares "dee.todoapp/src/middlewares"
	"github.com/gin-gonic/gin"
)

func SetupUserRoute(route *gin.Engine) {
	route.POST("/user/signup", controllers.SignUp)
	route.POST("/user/login", controllers.Login)
	route.GET("/user/validate", middlewares.RequireAuth, controllers.Validate)
}
