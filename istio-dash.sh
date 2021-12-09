set -e
shopt -s expand_aliases

ISTIO_VERSION=1.10.2
alias istioctl=./charts/ethernity/istio/istio-${ISTIO_VERSION}/bin/istioctl

if [[ $(kubectl config current-context) == minikube ]]; then
	CONTEXT=minikube
elif [[ $(kubectl config current-context) == kubernetes-admin@kubernetes ]]; then
  CONTEXT=kubernetes-admin@kubernetes
else
	CONTEXT=docker-desktop
fi

case "${1}" in
"controlz")
	if [ -z "${2}" ]; then
		echo "ERROR pass <pod-name[.namespace]> [flags]"
	else
		istioctl dash controlz ${2} ${3} --address 0.0.0.0 --context=${CONTEXT}
	fi
	;;
"envoy")
	if [ -z "${2}" ]; then
		echo "ERROR pass <pod-name[.namespace]> [flags]"
	else
		istioctl dash envoy ${2} ${3} --address 0.0.0.0 --context=${CONTEXT}
	fi
	;;
"grafana")
	echo WARNING set data source as BROWSER or NOT pointing to localhost or 127.0.0.1
	istioctl dash grafana --address 0.0.0.0 --context=${CONTEXT}
	;;
"prometheus")
	istioctl dash prometheus --address 0.0.0.0 --context=${CONTEXT}
	;;
"jaeger")
	istioctl dash jaeger --address 0.0.0.0 --context=${CONTEXT}
	;;
*)
	echo "ERROR not found"
	;;
esac
