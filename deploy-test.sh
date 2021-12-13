set -e

export SKAFFOLD_DEFAULT_REPO=docker.io/valayorg

skaffold deploy -p test --skip-render
