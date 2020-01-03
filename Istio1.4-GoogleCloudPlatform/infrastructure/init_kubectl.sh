
gcloud init --skip-diagnostics
gcloud config set project gcp-kubernetes-cluster
gcloud config set compute/zone us-west1-a
gcloud container clusters get-credentials istioexamplecluster