set -e

printf "\033[1;31mRUNNING IN PRODUCTION\033[0m\n" && read -p "CONFIRM (Y) ..." -n 1 -r && if [[ ! $REPLY =~ ^[Yy]$ ]]; then exit 1; fi

(cd ./charts/ethernity/istio && ./istio-init-production.sh)

export SKAFFOLD_DEFAULT_REPO=docker.io/ethernitymobile

#skaffold run -p run-migrations,add-artifacts,production --tail
skaffold run -p remove-tags,add-artifacts,production --tail
