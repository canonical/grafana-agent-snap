#!/bin/sh

sed -i 's/base: core22/base: core20/g' snap/snapcraft.yaml
sed -i 's/confinement: strict/confinement: classic/g' snap/snapcraft.yaml
sed -i 's/CRAFT_PART_INSTALL/SNAPCRAFT_PART_INSTALL/g' snap/snapcraft.yaml
sed -i '/libbpfcc/d' snap/snapcraft.yaml
sed -i '/bpfcc-tools/d' snap/snapcraft.yaml
yq -i 'del(.apps.grafana-agent.plugs) | del(.plugs)' snap/snapcraft.yaml
