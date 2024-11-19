#!/bin/sh

sed -i 's/confinement: strict/confinement: classic/g' snap/snapcraft.yaml
yq -i 'del(.apps.grafana-agent.plugs) | del(.plugs)' snap/snapcraft.yaml
sed -i 's/agent-wrapper.strict/agent-wrapper.classic/g' snap/snapcraft.yaml

# With the classic snap we need to patchelf for the core22 snap to run on a 20.04 charm,
# because of the libc6 dependency, otherwise the app will fail to start, complaining
# about needing glibc 2.32+.
yq -i '.parts.grafana-agent."build-attributes" += ["enable-patchelf"]' snap/snapcraft.yaml
