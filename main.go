package main

import (
	"fmt"
	"log"
	"net/http"
	"runtime"

	"github.com/peterj/semver/version"
)

func main() {
	port := ":8080"
	fmt.Printf(`running on %s:
		version     : %s
		git hash    : %s
		go version  : %s
		go compiler : %s
		platform    : %s/%s
	   `, port, version.VERSION, version.GITCOMMIT,
		runtime.Version(), runtime.Compiler, runtime.GOOS, runtime.GOARCH)

	router := NewRouter()
	log.Fatal(http.ListenAndServe(port, router))
}
