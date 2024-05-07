package routes

import (
	controllers "dee.todoapp/src/controllers"
	"dee.todoapp/src/middlewares"
	"github.com/gin-gonic/gin"
)

func SetupTodoRoute(route *gin.Engine) {
	route.POST("/todo", middlewares.RequireAuth, controllers.CreateTodo)
	route.GET("/todo", middlewares.RequireAuth, controllers.GetAllTodos)
	route.DELETE("/todo/:id", middlewares.RequireAuth, controllers.DeleteTodo)
	route.PUT("/todo/:id", middlewares.RequireAuth, controllers.UpdateTodo)
}
