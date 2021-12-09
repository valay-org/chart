set -e

if [[ $(kubectl config current-context) == minikube ]]; then
  CONTEXT=minikube
  ADDITIONAL_PROFILE=",minikube"
  unset SKAFFOLD_DEFAULT_REPO
elif [[ $(kubectl config current-context) == kubernetes-admin@kubernetes ]]; then
  CONTEXT=kubernetes-admin@kubernetes
  ADDITIONAL_PROFILE=",vagrant"
  export SKAFFOLD_DEFAULT_REPO=docker.io/ethernitymobile
else
  CONTEXT=docker-desktop
  unset SKAFFOLD_DEFAULT_REPO
fi

kubectl apply -k namespaces --context=${CONTEXT}

if [[ $(kubectl config current-context) == minikube ]]; then
  (cd ./charts/ethernity/istio && ./istio-init.sh)
elif [[ $(kubectl config current-context) == kubernetes-admin@kubernetes ]]; then
  (cd ./charts/ethernity/istio && ./istio-init-dev-vagrant.sh)
else
  (cd ./charts/ethernity/istio && ./istio-init.sh)
fi

#skaffold run -p run-delete,add-artifacts${ADDITIONAL_PROFILE} --tail --port-forward=user
skaffold run -p run-migrations,add-artifacts${ADDITIONAL_PROFILE} --tail --port-forward=user
skaffold dev -p remove-tags,add-artifacts${ADDITIONAL_PROFILE} --cleanup=false
