set -e

(cd ./charts/ethernity/istio && ./istio-init-test.sh)

export SKAFFOLD_DEFAULT_REPO=docker.io/ethernitymobile

#skaffold run -p run-delete,add-artifacts,test --tail
skaffold run -p run-migrations,add-artifacts,test --tail
skaffold run -p remove-tags,add-artifacts,test --tail
