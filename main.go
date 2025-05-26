package main

import (
	"encoding/json"
	"fmt"
	"log"
	"strconv"

	fastlauncer_model "github.com/probeldev/fastlauncher/model"
	niriwindows "github.com/probeldev/niri-float-sticky/niri-windows"
)

func main() {
	fn := "main"
	windows, err := niriwindows.GetWindowsList()
	if err != nil {
		log.Panic(fn, err)
	}

	apps := []fastlauncer_model.App{}

	for _, w := range windows {
		apps = append(apps, fastlauncer_model.App{
			Title:   w.AppID + "(" + w.Title + ")",
			Command: "niri msg action focus-window --id " + strconv.Itoa(w.ID),
		})
	}

	jq, err := json.Marshal(apps)
	if err != nil {
		log.Panic(fn, err)
	}

	fmt.Println(string(jq))

}
