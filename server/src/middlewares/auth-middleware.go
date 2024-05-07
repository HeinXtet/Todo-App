package middlewares

import (
	"fmt"
	"net/http"
	"os"
	"time"

	"dee.todoapp/src/configs"
	"dee.todoapp/src/models"
	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt/v5"
	"gorm.io/gorm"
)

var db *gorm.DB = configs.ConnectDatabase()

func RequireAuth(context *gin.Context) {
	tokenString := context.GetHeader("Authorization")
	println("Token", tokenString)

	if tokenString == "" {
		context.JSON(http.StatusUnauthorized, gin.H{
			"error": "UnAuthorized",
		})
		context.AbortWithStatus(http.StatusUnauthorized)
	}

	token, _ := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
		// Don't forget to validate the alg is what you expect:
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("unexpected signing method: %v", token.Header["alg"])
		}

		// hmacSampleSecret is a []byte containing your secret, e.g. []byte("my_secret_key")
		return []byte(os.Getenv("SECRET")), nil
	})

	if claims, ok := token.Claims.(jwt.MapClaims); ok && token.Valid {
		// Check the expiry date
		if float64(time.Now().Unix()) > claims["exp"].(float64) {
			context.AbortWithStatus(http.StatusUnauthorized)
		}
		// Find the user with token Subject
		var user models.User
		db.First(&user, claims["sub"])

		if user.ID == 0 {
			context.AbortWithStatus(http.StatusUnauthorized)
		}
		// Attach the request
		context.Set("user", user)

		//Continue
		context.Next()
	} else {
		context.AbortWithStatus(http.StatusUnauthorized)
	}

}
