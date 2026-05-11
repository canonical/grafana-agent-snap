set allow-duplicate-recipes
set allow-duplicate-variables
import? 'snaps.just'

[private]
@default:
  just --list
  echo ""
  echo "For help with a specific recipe, run: just --usage <recipe>"

# Generate a snap for the latest version of the upstream project
[arg("source_repo", help="Repository of the upstream project in 'org/repo' form")]
[group("maintenance")]
update source_repo:
  #!/usr/bin/env bash
  set -e
  latest_release="$(gh release list --repo {{source_repo}} --exclude-pre-releases --limit=1 --json tagName --jq '.[0].tagName')"
  echo "Latest release for {{source_repo}} is $latest_release"
  full_version="${latest_release#v}"
  version="$(echo "$full_version" | grep -oP '^\d+\.\d+')"
  if [[ -z "$version" ]]; then
    echo "× Error: could not parse major.minor version from '$latest_release'"
    exit 1
  fi
  # If the version already exists, exit here
  if [[ -d "$version" ]]; then echo "Folder $version already exists, nothing to do" && exit 0; fi
  # Create the folder for the new version
  latest_version="$(just --justfile snaps.just latest-version)"
  cp -r "$latest_version" "$version"
  # Update the version and source-tag in snapcraft.yaml
  snapcraft_file="./$version/snap/snapcraft.yaml"
  source_tag="v${full_version}" version="$full_version" yq -i \
    '.version = strenv(version) | .parts.grafana-agent["source-tag"] = strenv(source_tag)' \
    "$snapcraft_file"
  echo "✓ Created snap for version $version (source-tag: v${full_version})"
