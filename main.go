package main

import (
	"encoding/json"
	"fmt"
	"os"
)

type GoTestMsg struct {
	Msg string `json:"msg"`
}

func main() {
	var x GoTestMsg
	if err := json.NewDecoder(os.Stdin).Decode(&x); err != nil {
		fmt.Fprintf(os.Stderr, "Error reading/decoding from os.Stdin: %v\n", err)
		fmt.Fprintf(os.Stdout, "Error reading/decoding from os.Stdin: %v\n", err)
		panic(err)
	} else {
		fmt.Fprintf(os.Stderr, "msg decoded: '%#v'\n", x)
		fmt.Fprintf(os.Stdout, "msg decoded: '%#v'\n", x)
	}
}
