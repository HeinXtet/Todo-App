package controllers

import (
	"fmt"
	"net/http"

	config "dee.todoapp/src/configs"
	models "dee.todoapp/src/models"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

var db *gorm.DB = config.ConnectDatabase()

type TodoRequest struct {
	Name        string `json:"name"`
	Description string `json:"description"`
	IsDone      bool   `json:"is_done"`
}

// Create new todo
func CreateTodo(context *gin.Context) {
	user, _ := context.Get("user")

	var todoRequest struct {
		Name        string `json:"name"`
		Description string `json:"description"`
		IsDone      bool   `json:"is_done"`
	}

	if err := context.ShouldBindJSON(&todoRequest); err != nil {
		context.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	todo := models.Todo{Name: todoRequest.Name, Description: todoRequest.Description, UserID: user.(models.User).ID}
	result := db.Create(&todo)

	if result.Error != nil {
		context.JSON(http.StatusBadRequest, gin.H{"error": "Error getting data"})
		return
	}
	context.JSON(http.StatusOK, gin.H{
		"status":  "200",
		"data":    todo,
		"message": "Todo Created Successfully",
	})

	fmt.Println("Todo request ", todoRequest)
}

// Get all Todos
func GetAllTodos(context *gin.Context) {

	user, _ := context.Get("user")

	userId := user.(models.User).ID

	var todos []models.Todo

	fmt.Println("UserId ", userId)

	result := db.Order("created_at").Find(&todos, "user_id = ?", userId)

	if result.Error != nil {
		context.JSON(http.StatusBadRequest, gin.H{"error": "Error getting data " + result.Error.Error()})
		return
	}
	context.JSON(http.StatusOK, gin.H{
		"status":  "200",
		"message": "Success",
		"data":    todos,
	})
}

// Delete Todos
func DeleteTodo(context *gin.Context) {
	id := context.Param("id")

	// check existing Todo
	var todo models.Todo
	db.Find(&todo, id)
	if id != fmt.Sprint(todo.ID) {
		context.JSON(http.StatusBadRequest, gin.H{"error": "Can't find todo."})
		return
	}
	result := db.Delete(&models.Todo{}, id)
	if result.Error != nil {
		context.JSON(http.StatusBadRequest, gin.H{"error": "Error getting data " + result.Error.Error()})
	}
	context.JSON(http.StatusOK, gin.H{
		"status":  "200",
		"message": "Todo deleted",
		"data":    id,
	})
}

// update field in todo
func UpdateTodo(context *gin.Context) {

	var data TodoRequest

	if err := context.ShouldBindJSON(&data); err != nil {
		context.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	id := context.Param("id")

	if id == "" {
		context.JSON(http.StatusBadRequest, gin.H{"error": "ID shouldn't empty"})
		return
	}

	var todo models.Todo
	db.Find(&todo, id)

	if id != fmt.Sprint(todo.ID) {
		context.JSON(http.StatusBadRequest, gin.H{"error": "Can't found Todo"})
		return
	}

	todo.Name = data.Name
	todo.Description = data.Description
	todo.IsDone = data.IsDone
	result := db.Save(todo)

	if result.Error != nil {
		context.JSON(http.StatusBadRequest, gin.H{"error": result.Error.Error()})
		return
	}
	context.JSON(http.StatusOK, gin.H{
		"status":  "200",
		"message": "Todo Updated Successful",
		"data":    todo,
	})

}
