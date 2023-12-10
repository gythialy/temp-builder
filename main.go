package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"

	"github.com/hashicorp/go-version"
)

const (
	url              = "https://go.dev/dl/?mode=json&include=all"
	maxVersionString = "1.21.5"
	minVersionString = "1.18.2"
)

type Data struct {
	Version string `json:"version"`
	Stable  bool   `json:"stable"`
	Files   []File `json:"files"`
}

type File struct {
	Filename string `json:"filename"`
	OS       string `json:"os"`
	Arch     string `json:"arch"`
	Size     int    `json:"size"`
	Sha256   string `json:"sha256"`
	Version  string `json:"version"`
}

func main() {
	// 发送 HTTP GET 请求
	resp, err := http.Get(url)
	if err != nil {
		fmt.Println("请求失败:", err)
		return
	}
	defer resp.Body.Close()

	// 解析 JSON 响应
	var data []Data
	err = json.NewDecoder(resp.Body).Decode(&data)
	if err != nil {
		fmt.Println("解析 JSON 失败:", err)
		return
	}
	var versions []string
	var hashes []string
	maxVersion, _ := version.NewVersion("1.21.5")
	minVersion, _ := version.NewVersion("1.18.2")

	for _, d := range data {
		if !d.Stable {
			continue
		}
		for _, f := range d.Files {
			v := f.Version
			v1, _ := version.NewVersion(strings.TrimPrefix(v, "go"))
			if v1.LessThan(maxVersion) && v1.GreaterThan(minVersion) && f.OS == "linux" && f.Arch == "amd64" {
				versions = append(versions, v)
				hashes = append(hashes, f.Sha256)
			}
		}
	}

	fmt.Printf("(%s)\n", strings.Join(versions, " "))
	fmt.Printf("(%s)\n", strings.Join(hashes, " "))
}
