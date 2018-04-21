/*
 * Simple Storage Server
 *
 * A Simple Storage Server API
 *
 * API version: 1.0.0
 * Generated by: Swagger Codegen (https://github.com/swagger-api/swagger-codegen.git)
 */

package swagger

import (
	"fmt"
	"net/http"
	"strings"

	"github.com/gorilla/mux"
)

type Route struct {
	Name        string
	Method      string
	Pattern     string
	HandlerFunc http.HandlerFunc
}

type Routes []Route

func NewRouter() *mux.Router {
	router := mux.NewRouter().StrictSlash(true)
	for _, route := range routes {
		var handler http.Handler
		handler = route.HandlerFunc
		handler = Logger(handler, route.Name)

		router.
			Methods(route.Method).
			Path(route.Pattern).
			Name(route.Name).
			Handler(handler)
	}

	return router
}

func Index(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello World!")
}

var routes = Routes{
	Route{
		"Index",
		"GET",
		"/v1/",
		Index,
	},

	Route{
		"DeleteFile",
		strings.ToUpper("Delete"),
		"/v1/files/{filename}",
		DeleteFile,
	},

	Route{
		"GetFileByName",
		strings.ToUpper("Get"),
		"/v1/files/{filename}",
		GetFileByName,
	},

	Route{
		"ListUserFiles",
		strings.ToUpper("Get"),
		"/v1/files",
		ListUserFiles,
	},

	Route{
		"UploadFile",
		strings.ToUpper("Post"),
		"/v1/files/{filename}",
		UploadFile,
	},

	Route{
		"CreateUser",
		strings.ToUpper("Post"),
		"/v1/register",
		CreateUser,
	},

	Route{
		"LoginUser",
		strings.ToUpper("Get"),
		"/v1/login",
		LoginUser,
	},
}