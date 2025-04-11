# Mission Control Workshop Attendee Guide

Mission Control is the next generation operations platform for DataStax products. It simplifies management of all Hyper-Converged Database (HCD), DataStax Enterprise (DSE), and Apache Cassandra® operations across an array of hosting options from the cloud to on-premises and everything in-between. Manage HCD, DSE, and Cassandra environments on bare-metal or virtual machines (VMs). Powered by the advanced automation running DataStax Astra DB, Mission Control provides 24/7 automated operations of DSE clusters, datacenters, and nodes

The DataStax Mission Control Workshop is a hands-on experience to gain familiarity with its major lifecycle management capabilities, including:

- Deploying the Mission Control software suite
- Deploying Apache Cassandra, DataStax Enterprise (DSE), and HCD clusters through Mission Control’s WUI
- Performing operations on existing clusters including upgrades, scaling, and data management


## 1 - Deploying Mission Control on a Kubernetes Cluster

Follow along with the host as a Mission Control instance is deployed on an existing Kubernetes cluster.  

- **Instantiating Kubernetes KOTS**.  The deploy makes use of the Kubernetes KOTS (Kubernetes Off-The-Shelf) framework for packaging, deploying, and managing third-party applications in Kubernetes clusters with a focus on simplified admin experiences
- **License File**.
- **Installation Options**.  Both local registries and public Internet connected registries are supported
- **WUI Driven Configuration**.  Visually explore all installation / configuration tunables
- **Fool-proof deploy**.  Pre-flight checks of underlying infrastructure and configuration prior to deploy
- **Support Bundles**.  Generate and upload redacted support bundles
- **Versioned Configuration**.  Modify, verify, deploy, and roll-back versioned configurations
- **Gitops Management**.  All WUI driven configuration can also be done via yaml for repeatability and to support Gitops workflows


## 2 - Exploring Mission Control

Access the Mission Control web-UI using the URL provided by your host.

<img width="1379" alt="image" src="https://github.com/user-attachments/assets/ca4d219a-e284-4ae4-8b77-f0ee2a65c561" />

Login using the following static credentials:
- Email: `admin@example.com`
- Password: `password`

Mission Control is designed with a hierarchical structure in place.  
- One or more projects exist within Mission Control.  Each project is represented as its own namespace in the underlying Kubernetes cluster
  - Each project contains or more more clusters - Apache Cassandra, DataStax Enterprise (DSE), or HCD 

Create a new project tagged with your name.
<img width="1379" alt="image" src="https://github.com/user-attachments/assets/0a42d8e1-a34e-4d07-a192-365d9f7a7ff9" />
<img width="1379" alt="image" src="https://github.com/user-attachments/assets/3f297103-821f-46bf-9dda-99ef2dc8e6da" />

K8s will represent that as a namespace.

```
 % kubectl get ns
NAME                          STATUS   AGE
mission-control               Active   4h13m
myname-demo-098464zq          Active   35s

% kubectl describe ns myname-demo-098464zq
Name:         myname-demo-098464zq
Labels:       kubernetes.io/metadata.name=myname-demo-098464zq
              mission-control.datastax.com/is-project=true
Annotations:  mission-control.datastax.com/project-name: myname-demo
Status:       Active

No resource quota.
No LimitRange resource.
```

Projects can be managed directly via `kubectl` as well.  Here is an example definition:

```
apiVersion: v1
kind: Namespace
metadata:
  name: PROJECT_NAME
  labels:
    mission-control.datastax.com/is-project: "true"
  annotations:
    mission-control.datastax.com/project-name: "PROJECT_NAME"
```


## 3 - Deploy Single Datacenter Clusters

Create a new project tagged with your name.


## 4 - Expand Cluster to Multi-datacenters


## 5 - Cluster Scaling


## 6 - Upgrading Clusters


## 7 - Cluster Maintenance


## 8 - Data Maintenance


## 9 - Exploring Telemetry



