#!/bin/sh

sed -i 's/confinement: strict/confinement: classic/g' snap/snapcraft.yaml
yq -i 'del(.apps.grafana-agent.plugs) | del(.plugs)' snap/snapcraft.yaml
sed -i 's/agent-wrapper.strict/agent-wrapper.classic/g' snap/snapcraft.yaml
