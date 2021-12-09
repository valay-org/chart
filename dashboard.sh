kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml
kubectl apply -f admin-kube-dashboard.yaml

PATCH='[{"op":"add", "path":"/spec/template/spec/tolerations/-", "value":{"key":"app/app-reserved","effect":"NoSchedule","operator":"Exists"}}]'
kubectl patch deployment kubernetes-dashboard --patch "${PATCH}" --type json -n kubernetes-dashboard
kubectl patch deployment dashboard-metrics-scraper --patch "${PATCH}" --type json -n kubernetes-dashboard

echo

echo COPY TOKEN
kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"

echo
echo
URL=http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/overview?namespace=_all
echo OPEN ${URL} && open ${URL}
kubectl proxy
