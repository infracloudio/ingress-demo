kubectl apply -f nginx-ingress.yaml

sleep 30;
kubectl apply -f service-l4.yaml

echo "Ingress LB is $(k get svc ingress-nginx -n ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')";

# Now manually make an entry in R53 hosted zone for subdomains and then run:
# kubectl apply -f ingress-demo.yaml