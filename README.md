<h1 align="center">
  <img src="logo.svg?raw=true" alt="Grafana Agent">
  <br />
  Grafana Agent
</h1>

<p align="center"><a href="https://github.com/canonical/grafana-agent-snap/actions/workflows/release-snap.yaml"><img src="https://github.com/canonical/grafana-agent-snap/actions/workflows/release-snap.yaml/badge.svg"></a></p>

<p align="center"><b>This is the snap for Grafana Agent</b>, <i>“Grafana Agent is a telemetry collector for sending metrics, logs, and trace data to the opinionated Grafana observability stack”</i>. It works on Ubuntu, Fedora, Debian, and other major Linux
distributions.</p>

<p align="center"><a href="https://snapcraft.io/grafana-agent"><img src="https://snapcraft.io/grafana-agent/badge.svg" alt="grafana-agent badge"/><a/></p>

<p align="center">Published for <img src="https://raw.githubusercontent.com/anythingcodes/slack-emoji-for-techies/gh-pages/emoji/tux.png" align="top" width="24" /> with 💝 by Snapcrafters</p>

## Install

```
sudo snap install grafana-agent
```

<!-- Uncomment and modify this when your snap is available on the store
[![Get it from the Snap Store](https://snapcraft.io/static/images/badges/en/snap-store-white.svg)](https://snapcraft.io/grafana-agent)
-->

([Don't have snapd installed?](https://snapcraft.io/docs/core/install))

## Configuration

Once installed, a default configuration file will be created at `/etc/grafana-agent.yaml`. Before starting the agent, make sure to update this configuration file to suit you needs, consulting the [official documentation](https://grafana.com/docs/agent/latest/configuration/). 
