package main

import (
	"html/template"
	"net/http"
)

func main() {
	tmpl := template.Must(template.ParseFiles("compiled/index.html"))

	mux := http.NewServeMux()
	mux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		if err := tmpl.Execute(w, "world"); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	})
	(&http.Server{
		Addr:    ":3000",
		Handler: mux,
	}).ListenAndServe()
}
