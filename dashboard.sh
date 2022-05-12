kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.1/aio/deploy/recommended.yaml
kubectl apply -f admin-kube-dashboard.yaml

#PATCH='[{"op":"add", "path":"/spec/template/spec/tolerations/-", "value":{"key":"app/app-reserved","effect":"NoSchedule","operator":"Exists"}}]'
#kubectl patch deployment kubernetes-dashboard --patch "${PATCH}" --type json -n kubernetes-dashboard
#kubectl patch deployment dashboard-metrics-scraper --patch "${PATCH}" --type json -n kubernetes-dashboard

echo

echo COPY TOKEN
kubectl -n kubernetes-dashboard create token admin-user

echo opening...
sleep 5
echo
URL=http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/overview?namespace=_all
echo OPEN ${URL} && open ${URL}
kubectl proxy
