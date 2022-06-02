set -e

export SKAFFOLD_DEFAULT_REPO=docker.io/valayorg

skaffold run -p run-migrations,add-artifacts,test --tail
skaffold run -p remove-tags,add-artifacts,test --tail
