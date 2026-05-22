set allow-duplicate-recipes
set allow-duplicate-variables
import? 'snaps.just'

[private]
@default:
  just --list
  echo ""
  echo "For help with a specific recipe, run: just --usage <recipe>"

# Update the snap to the latest upstream version (grafana-agent-specific: updates source-tag)
# NOTE: This recipe only updates the `latest/` folder. The `0.44-classic/` folder must be
# updated manually because the track name (`0.44-classic`) doesn't match the version pattern
# (`0.44.x`). Since grafana-agent is in maintenance mode, this is acceptable.
[arg("source_repo", help="Repository of the upstream project in 'org/repo' form")]
[group("maintenance")]
update source_repo:
  #!/usr/bin/env bash
  set -e

  latest_release="$(gh release list --repo {{source_repo}} --exclude-pre-releases --limit=1 --json tagName --jq '.[0].tagName')"
  echo "Latest release for {{source_repo}} is $latest_release"

  # Parse full semver (X.Y.Z) and major.minor (X.Y)
  full_version="${latest_release#v}"
  major_minor="$(echo "$full_version" | grep -oP '^\d+\.\d+')"
  if [[ -z "$major_minor" ]]; then
    echo "× Error: could not parse version from '$latest_release'"
    exit 1
  fi

  # Get current version from latest/ folder
  if [[ ! -f "latest/snap/snapcraft.yaml" ]]; then
    echo "× Error: latest/snap/snapcraft.yaml not found"
    exit 1
  fi
  current_version="$(yq -r '.version' latest/snap/snapcraft.yaml)"

  # Compare versions using sort -V (version sort)
  newer_version="$(printf '%s\n%s' "$current_version" "$full_version" | sort -V | tail -n1)"
  if [[ "$newer_version" == "$current_version" && "$full_version" != "$current_version" ]]; then
    echo "Current version ($current_version) is newer than or equal to upstream ($full_version), nothing to do"
    exit 0
  fi
  if [[ "$full_version" == "$current_version" ]]; then
    echo "Already at version $full_version, nothing to do"
    exit 0
  fi

  # Update the latest/ folder only
  # The 0.44-classic/ folder is NOT auto-updated because:
  # 1. The track name (0.44-classic) doesn't match the version pattern (0.44.x)
  # 2. grafana-agent is in maintenance mode - manual updates are acceptable
  echo "Updating latest/ folder to version $full_version ..."
  snapcraft_file="latest/snap/snapcraft.yaml"
  full_version="$full_version" yq -i '.version = strenv(full_version)' "$snapcraft_file"
  full_version="$full_version" yq -i '.parts.grafana-agent["source-tag"] = "v" + strenv(full_version)' "$snapcraft_file"
  echo "✓ Updated latest/ to $full_version"

  echo ""
  echo "⚠ NOTE: 0.44-classic/ was NOT updated automatically."
  echo "  To update it manually, run:"
  echo "    yq -i '.version = \"$full_version\"' 0.44-classic/snap/snapcraft.yaml"
  echo "    yq -i '.parts.grafana-agent[\"source-tag\"] = \"v$full_version\"' 0.44-classic/snap/snapcraft.yaml"

  echo ""
  echo "updated_folders=latest"
  echo "new_version=$full_version"
