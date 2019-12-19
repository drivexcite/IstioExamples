git clone https://github.com/istio/istio
kubectl apply -f .\platform\kube\bookinfo.yaml
kubectl apply -f .\networking\bookinfo-gateway.yaml
kubectl get pods --namespace istio-system
# kiali-7dd44f7696-klf6j
kubectl --namespace istio-system port-forward kiali-7dd44f7696-klf6j 20001:20001

# It maybe necessary to restart kiali to allow for the secret to take effect
kubectl scale deployment kiali --replicas=0 --namespace istio-system
kubectl scale deployment kiali --replicas=1 --namespace istio-system