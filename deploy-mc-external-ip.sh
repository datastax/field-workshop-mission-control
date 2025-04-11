#!/bin/bash

# Step 1: Apply the YAML
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: mission-control-ui-external
  namespace: mission-control
  labels:
    created-by: automation-script
spec:
  selector:
    app: mission-control-ui
  sessionAffinity: None
  type: LoadBalancer
  ports:
  - protocol: TCP
    name: http
    port: 443
    targetPort: 8080
EOF

# Step 2: Wait for EXTERNAL-IP to be assigned
echo "Waiting for external IP..."
while true; do
  IP=$(kubectl get svc mission-control-ui-external \
        -n mission-control \
        -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
  
  if [[ -n "$IP" ]]; then
    break
  fi

  # Optional: support for hostnames (some cloud providers use DNS instead of raw IP)
  HOSTNAME=$(kubectl get svc mission-control-ui-external \
             -n mission-control \
             -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
  if [[ -n "$HOSTNAME" ]]; then
    IP=$HOSTNAME
    break
  fi

  sleep 2
done

# Step 3: Print the HTTPS link
echo "Service is available at: https://$IP"
