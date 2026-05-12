#!/bin/sh

sudo snap connect grafana-agent:hardware-observe
sudo snap connect grafana-agent:mount-observe
sudo snap connect grafana-agent:network-bind
sudo snap connect grafana-agent:network-observe
sudo snap connect grafana-agent:config-file
sudo snap connect grafana-agent:telemetry
sudo snap connect grafana-agent:system-observe
sudo snap connect grafana-agent:time-control
