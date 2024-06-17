package main

import (
	"github.com/grafana/grafana-plugin-sdk-go/backend/datasource"
	"github.com/grafana/grafana-plugin-sdk-go/backend/log"
	"os"
	// window timezone issue #101
	_ "time/tzdata"
)

func main() {
	if err := datasource.Manage(
		"blackcowmoo-googleanalytics-datasource",
		NewDataSource,
		datasource.ManageOpts{}); err != nil {
		log.DefaultLogger.Error(err.Error())
		os.Exit(1)
	}
}
