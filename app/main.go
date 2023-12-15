package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

const defaultTextColor = "pink"

func main() {
	// Create a new Gin router
	router := gin.Default()
	router.LoadHTMLGlob("*.html")

	// Define a route that returns HTML with dynamic text color
	router.GET("/", func(c *gin.Context) {

		// Render HTML with dynamic text color
		c.HTML(http.StatusOK, "index.html", gin.H{
			"title":     "Hello from Velocity!",
			"textColor": defaultTextColor,
		})
	})

	// Run the application on port 8080
	router.Run(":8080")
}
