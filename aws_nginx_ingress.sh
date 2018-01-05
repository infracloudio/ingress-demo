kubectl apply -f nginx-ingress.yaml

kubectl apply -f service-l4.yaml

sleep 30;

echo "Ingress LB is $(kubectl get svc ingress-nginx -n ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')";

# Now manually make an entry in R53 hosted zone for subdomains and then run:
# kubectl apply -f ingress-demo.yaml
