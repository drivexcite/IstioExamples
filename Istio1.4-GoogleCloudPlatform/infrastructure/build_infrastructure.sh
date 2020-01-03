
gcloud init --skip-diagnostics
gcloud config set project gcp-kubernetes-cluster
gcloud config set compute/zone us-west1-a
# Before creating the cluster, visit this page and enable the Kubernetes Engine API: https://console.cloud.google.com/apis/library/container.googleapis.com?project=gcp-kubernetes-cluster
gcloud container clusters create istioexamplecluster --zone us-west1-a --num-nodes=4
gcloud container clusters get-credentials istioexamplecluster