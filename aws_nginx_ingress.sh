kubectl apply -f nginx-ingress.yaml

sleep 30;

kubectl patch deployment -n ingress-nginx nginx-ingress-controller --type='json' \
  --patch="[{'op': 'replace', 'path': '/spec/template/spec/containers/0/args', 'value':['/nginx-ingress-controller','--default-backend-service=$(POD_NAMESPACE)/default-http-backend','--configmap=$(POD_NAMESPACE)/nginx-configuration','--tcp-services-configmap=$(POD_NAMESPACE)/tcp-services','--udp-services-configmap=$(POD_NAMESPACE)/udp-services','--annotations-prefix=nginx.ingress.kubernetes.io','--publish-service=$(POD_NAMESPACE)/ingress-nginx']}]"

kubectl apply -f service-l4.yaml
kubectl apply -f patch-configmap-l4.yaml

kubectl apply -f patch-service-with-rbac.yaml

echo "Ingress LB is $(k get svc ingress-nginx -n ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')";

