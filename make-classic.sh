#!/bin/sh

# The classic snap needs to be built on core20 because of libc6 dependency:
# A core22 snap needs glibc 2.32+, but in a 20.04 charm we have glibc 2.31.
sed -i 's/base: core22/base: core20/g' snap/snapcraft.yaml
sed -i 's/confinement: strict/confinement: classic/g' snap/snapcraft.yaml
sed -i 's/CRAFT_PART_INSTALL/SNAPCRAFT_PART_INSTALL/g' snap/snapcraft.yaml
sed -i '/libbpfcc/d' snap/snapcraft.yaml
sed -i '/bpfcc-tools/d' snap/snapcraft.yaml
yq -i 'del(.apps.grafana-agent.plugs) | del(.plugs)' snap/snapcraft.yaml
sed -i 's/agent-wrapper.strict/agent-wrapper.classic/g' snap/snapcraft.yaml
