package main

import (
	"fmt"
	"io"
	"net/http"
)

// RootHandler is the entry point for this fission function
func RootHandlerv2(w http.ResponseWriter, r *http.Request) {
	fmt.Println("entering v2 root handler")
	user := r.Header.Get("X-Fission-Params-User")
	//user := r.URL.Query().Get("user")
	if user != "" {
		io.WriteString(w, fmt.Sprintf("hello [%s]\n", user))
	} else {
		io.WriteString(w, "hello [stranger]\n")
	}
	io.WriteString(w, "===================Details of the http request header:============\n")
	for k, v := range r.Header {
		io.WriteString(w, fmt.Sprintf("%s=%s\n", k, v))
	}
}
