package main

import (
	"bytes"
	"log"
	"net/http"
	"os/exec"
	"strconv"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		testUrl := r.URL.Query().Get("test-url")
		if testUrl == "" {
			http.Error(w, "You need provide a test-url parameter you fool.", http.StatusBadRequest)
			return
		}
		iterations:= r.URL.Query().Get("iterations")
		if iterations == "" {
			http.Error(w, "You need provide an iterations  parameter you fool.", http.StatusBadRequest)
			return
		}

		concurrencyStr:= r.URL.Query().Get("concurrency")
		if concurrencyStr == "" {
			http.Error(w, "You need provide a concurrency parameter you fool.", http.StatusBadRequest)
			return
		}
		concurrency, err := strconv.Atoi(concurrencyStr)

		if err != nil {
			http.Error(w, "concurrency parameter is not an integer you fool."+err.Error(), http.StatusBadRequest)
			return
 		}

// This will be in loop. do cmd.Output()
		for i:=0; i< concurrency; i++ {
			go func() {
				log.Printf("Running go cmd!")
				cmd := exec.Command("xvfb-run", "-a", "ruby", "headless.rb", testUrl, iterations)
				var out bytes.Buffer
				cmd.Stdout = &out
				err := cmd.Run()
				log.Printf("testing url %s with iterations %s %s\n", testUrl, iterations, out.String())
				if err != nil {
				  log.Printf("Smells like somebody died.")
				//	log.Fatal(err)
				}
			}()
		}
// End of loop.

	})

	log.Println("Server starting up on port 80")
	if err := http.ListenAndServe(":80", nil); err != nil {
		log.Fatalf("Failed to serve: %v", err)
	}
}
