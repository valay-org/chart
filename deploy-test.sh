set -e

(cd ./charts/ethernity/istio && ./istio-init-test.sh)

export SKAFFOLD_DEFAULT_REPO=docker.io/ethernitymobile

skaffold deploy -p test --skip-render
