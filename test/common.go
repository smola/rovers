package test

import (
	"io/ioutil"
	"os"
	"path/filepath"
	"strings"

	. "gopkg.in/check.v1"
	"gopkg.in/jarcoal/httpmock.v1"
)

func LoadAsset(baseURL string, assetPath string, c *C) {
	err := filepath.Walk(assetPath, func(p string, info os.FileInfo, err error) error {
		if info.IsDir() {
			return nil
		}

		responder := ResponderByFile(c, p)
		p, err := filepath.Rel(assetPath, p)
		if err != nil {
			return err
		}

		url := baseURL + filepath.ToSlash(rel)
		httpmock.RegisterResponder(
			"GET",
			url,
			responder,
		)

		if strings.HasSuffix(p, "index.html") {
			url = baseURL + filepath.ToSlash(filepath.Dir(p))

			httpmock.RegisterResponder(
				"GET",
				url,
				responder,
			)

			if !strings.HasSuffix(url, "/") {
				url = url + "/"

				httpmock.RegisterResponder(
					"GET",
					url,
					responder,
				)
			}
		}

		return nil
	})

	if err != nil {
		panic(err)
	}
}

func ResponderByFile(c *C, file string) httpmock.Responder {
	return ResponderByFileAndStatus(c, file, 200)
}

func ResponderByFileAndStatus(c *C, file string, status int) httpmock.Responder {
	f, err := os.Open(file)
	c.Assert(err, IsNil)
	data, err := ioutil.ReadAll(f)
	c.Assert(err, IsNil)

	res := httpmock.NewBytesResponse(status, data)
	return httpmock.ResponderFromResponse(res)
}
