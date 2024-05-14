package controllers

import (
	"fmt"
	"net/http"
	"os"
	"time"

	"dee.todoapp/src/models"
	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt/v5"
	"golang.org/x/crypto/bcrypt"
)

func SetupAuthMiddleware(c *gin.Context) {
	token := c.GetHeader("Authorization")
	if token == "" {
		c.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{
			"error": "UnAuthorized",
		})
	}
}

func SignUp(context *gin.Context) {

	var body struct {
		Email    string
		Password string
	}
	if err := context.ShouldBindJSON(&body); err != nil {
		context.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(body.Password), 10)
	if err != nil {
		context.JSON(http.StatusBadRequest, gin.H{
			"error": "Failed to hash password.",
		})
		return
	}

	newUser := models.User{Email: body.Email, Password: string(hashedPassword)}

	result := db.Create(&newUser)

	if result.Error != nil {
		context.JSON(http.StatusBadRequest, gin.H{"error": result.Error.Error()})
		return
	}

	context.JSON(http.StatusOK, gin.H{
		"message": "New user successfully created",
		"status":  "200",
		"data":    newUser,
	})

}
func Login(context *gin.Context) {

	var body struct {
		Email    string
		Password string
	}

	if err := context.Bind(&body); err != nil {
		fmt.Println("BODY ", body)
		context.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	var user models.User

	db.Find(&user, "email = ?", body.Email)

	if user.ID == 0 {
		context.JSON(http.StatusBadRequest, gin.H{
			"error": "Invalid email or password",
		})
		return
	}

	err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(body.Password))

	if err != nil {
		context.JSON(http.StatusBadRequest, gin.H{
			"error": "Invalid email or password",
		})
		return
	}

	//generate jwt token
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"sub": user.ID,
		"exp": time.Now().Add(time.Hour * 24 * 30).Unix(),
	})

	// Sign and get the complete encoded token as a string using the secret
	tokenString, err := token.SignedString([]byte(os.Getenv("SECRET")))
	if err != nil {
		context.JSON(http.StatusBadRequest, gin.H{
			"error": "Failed to create token",
		})
		return
	}

	fmt.Println("TOKEN ", tokenString)
	loginResponse := gin.H{
		"email": user.Email,
		"token": tokenString,
	}
	context.JSON(http.StatusOK, gin.H{
		"message": "login Successfully",
		"status":  "200",
		"data":    loginResponse,
	})

}
func Validate(c *gin.Context) {
	user, _ := c.Get("user")

	// user.(models.User).Email    -->   to access specific data

	c.JSON(http.StatusOK, gin.H{
		"message": "Validate Success",
		"data":    user,
		"status":  "200",
	})
}
