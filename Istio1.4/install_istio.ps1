# Install the bookinfo example (notice the single version of reviews)
kubectl apply -f 00.bookinfo.kubernetes.yaml

# Install the NGINX based Ingress Controller for Plain Kubernetes
kubectl apply -f 01.nginx-ingress.yaml

# Add an ingress resource for the bookinfo example
kubectl apply -f 02.bookinfo.ingress.yaml

# Notice how many containers are executing in each pood!
# Notice the out-of-the-box observability of a Kubernetes Cluster!

# Delete all resources
kubectl delete -f 02.bookinfo.ingress.yaml
kubectl delete -f 01.nginx-ingress.yaml
kubectl delete -f 00.bookinfo.kubernetes.yaml

# Generate YAML with the exact installation parameters
istioctl manifest generate --set profile=demo > 04.istio-installation.yaml

# In order to access the mesh visualization tool, create a default password
kubectl apply -f 03.kiali.secret.yaml

# Apply the Istio resources to the cluster
kubectl apply -f 04.istio-installation.yaml

# Check status of Istio pods
kubectl get pods -n istio-system

# Retrieve the public IP adress of the Ingress Gateway
kubectl get svc istio-ingressgateway -n istio-system

# Label default namespace so that resources deployed in it get Envoy proxies automatically injected
kubectl label namespace default istio-injection=enabled

# Install the bookinfo example, for Istio (notice the 3 versions of reviews)
kubectl apply -f 05.bookinfo.istio.yaml

# Check status of the pods in the default namespace and notice the number of containers.
# Describe the pods to see the sidecar proxy.
kubectl get pods

# Install an HTTP Rule for the Gateway.
kubectl apply -f 06.bookinfo.gateway.yaml

# Install the Destination Rules.
kubectl apply -f 07.bookinfo.destination-rules.yaml

# Install the Virtual Services, with the default routing.
kubectl apply -f 08.bookinfo.virtual-services.yaml

# Apply the different Traffic Routing Scenarios
kubectl apply -f 09.bookinfo.reviews.canary-deployments.yaml
kubectl apply -f 10.bookinfo.reviews.abtesting.yaml
kubectl apply -f 11.bookinfo.reviews.fault-injection.yaml
kubectl apply -f 12.bookinfo.reviews.qualified-fault-injection.yaml
kubectl apply -f 13.bookinfo.reviews.fault-injection-delay.yaml

# To dump the pod metadata in a json file
kubectl get pods -n istio-system --output json > pods.json

# Inspect the topology of the service mesh in Kiali
$kialiPod = kubectl get pods -n istio-system -o jsonpath="{.items[*].metadata.name}" -l app=kiali
kubectl port-forward $kialiPod --address 0.0.0.0 20001:20001 -n istio-system

# To visualize the telemetry and health of the Mesh
$grafanaPod = kubectl get pods -n istio-system -o jsonpath="{.items[*].metadata.name}" -l app=grafana
kubectl port-forward $grafanaPod --address 0.0.0.0 3000:3000 -n istio-system

# To inspect and query the metrics of the Mesh
$prometheusPod = kubectl get pods -n istio-system -o jsonpath="{.items[*].metadata.name}" -l app=prometheus
kubectl port-forward $prometheusPod --address 0.0.0.0 9090:9090 -n istio-system