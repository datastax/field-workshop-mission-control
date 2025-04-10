#
# Explainer doc
#
https://docs.google.com/document/d/1DkOahu2cc8pO4A7h7u1ZaPhW7ixnF4CZWM5PSumiOok/edit?tab=t.0


#
# Build k8s cluster
#
gcloud auth application-default login

terraform init
terraform plan
terraform apply -auto-approve

#
# Get credentials
#
gcloud container clusters get-credentials kresar-mc-demo-mc-control-plane --zone us-central1-c --project gcp-lcm-project
kubectl config current-context


#
# Pre-reqs
#
kubectl krew install minio
kubectl krew install preflight
kubectl krew install support-bundle
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.13.3 --set installCRDs=true



#
# Install MC
#
kubectl kots install mission-control
kubectl kots admin-console --namespace mission-control
# -> Access console at: http://localhost:8800
# Static password: $2y$10$zJ07097PQFhfRH9ZBJvfgemYkrOlb8opIe7A5T3de4wxHmDXNs5ZO


#
# Access MC
#
kubectl port-forward svc/mission-control-ui -n mission-control 8080
# -> https://localhost:8080/


#
# Cleanup
#
terraform apply -destroy -auto-approve 


