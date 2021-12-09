set -e
shopt -s expand_aliases

ISTIO_VERSION=1.10.2
alias istioctl=./charts/ethernity/istio/istio-${ISTIO_VERSION}/bin/istioctl

CONTEXT=gke_ethy-mobile_us-central1-a_ethernity

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
