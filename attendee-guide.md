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


## 1 - Exploring Mission Control

Access the Mission Control web-UI using the URL provided by your host.

Login using the following static credentials:
- Email: `admin@example.com`
- Password: `password`

Mission Control is designed with a hierarchical structure in place.  
- One or more projects exist within Mission Control.  Each project is represented as its own namespace in the underlying Kubernetes cluster
  - Each project contains or more more clusters - Apache Cassandra, DataStax Enterprise (DSE), or HCD 


## 2 - Deploy Single Datacenter Clusters


## 3 - Expand Cluster to Multi-datacenters


## 4 - Cluster Scaling


## 5 - Upgrading Clusters


## 6 - Cluster Maintenance


## 7 - Data Maintenance


## 8 - Exploring Telemetry



