#!/usr/bin/bash

sed -i 's/base: core22/base: core20/g' snap/snapcraft.yaml
sed -i 's/confinement: strict/confinement: classic/g' snap/snapcraft.yaml
sed -i 's/CRAFT_PART_INSTALL/SNAPCRAFT_PART_INSTALL/g' snap/snapcraft.yaml
sed -i 's/architectures/platforms/g' snap/snapcraft.yaml
sed -i -E 's/- (build-on: (\w+))/\2:\n    \1/g' snap/snapcraft.yaml    
sed -i '/libbpfcc/d' snap/snapcraft.yaml
sed -i '/bpfcc-tools/d' snap/snapcraft.yaml
