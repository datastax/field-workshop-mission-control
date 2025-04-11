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

✅ **Login using the following static credentials:**
- Email: `admin@example.com`
- Password: `password`

Mission Control is designed with a hierarchical structure in place.  
- One or more projects exist within Mission Control.  Each project is represented as its own namespace in the underlying Kubernetes cluster
  - Each project contains or more more clusters - Apache Cassandra, DataStax Enterprise (DSE), or HCD 

✅ **Create a new project tagged with your name.**
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

✅ **Navigate to the project you created and click the "Create Cluster" button**
<img width="1379" alt="image" src="https://github.com/user-attachments/assets/357f3b9a-8a24-495d-b976-aaf0f1d6ea30" />

✅ **Fill in the following basic information to deploy a single node Apache Cassandra cluster**
- Cluster Name: `cassandra-demo`
- Type: Apache Cassandra
- Server Version: `4.1.7`
- Datacenter Name: `dc-1`
- Rack Name: `r1`
- Storage Class: `standard` (scroll a ways down the form to find this)
- Click the "Create Cluster" button

![image](https://github.com/user-attachments/assets/4df06fd6-1dce-4518-a988-d195c2ada707)

Your cluster is now visible as a tile on your screen.
<img width="1379" alt="image" src="https://github.com/user-attachments/assets/bd9581d3-8656-4a6c-abf8-ec9e5f4c36ed" />

✅ **Click the tile for your `cassandra-demo` cluster and briefly explore the tabs**.  
<img width="1335" alt="image" src="https://github.com/user-attachments/assets/275fedd8-f808-4dc7-89ef-4d6f84f7153d" />

Clusters can also be provisioned by code, either using the Web-UI or with `kubectl`.  You can expose expert mode by clicking the "Modify Cluster" button then clicking on the "Expert" button.  You can also get this from `kubectl` by looking at the `MissionControlCluster` resource type:

```
apiVersion: missioncontrol.datastax.com/v1beta2
kind: MissionControlCluster
metadata:
  name: cassandra-demo
  namespace: myname-demo-098464zq
  resourceVersion: '196784'
spec:
  createIssuer: true
  dataApi: {}
  encryption:
    internodeEncryption:
      certs:
        createCerts: true
      enabled: true
  k8ssandra:
    auth: true
    cassandra:
      config:
        cassandraYaml: {}
        dseYaml: {}
        jvmOptions:
          gc: G1GC
          heapSize: 1Gi
      datacenters:
        - config:
            cassandraYaml: {}
            dseYaml: {}
          datacenterName: dc-1
          dseWorkloads: {}
          metadata:
            name: cassandra-demo-dc-1
            pods: {}
            services:
              additionalSeedService: {}
              allPodsService: {}
              dcService: {}
              nodePortService: {}
              seedService: {}
          networking: {}
          perNodeConfigMapRef: {}
          racks:
            - name: r1
              nodeAffinityLabels: {}
          size: 1
      resources:
        requests:
          cpu: 1000m
          memory: 4Gi
      serverType: dse
      serverVersion: 6.9.4
      storageConfig:
        cassandraDataVolumeClaimSpec:
          accessModes:
            - ReadWriteOnce
          resources:
            requests:
              storage: 2Gi
          storageClassName: standard
      superuserSecretRef:
        name: cassandra-demo-superuser
```

Learn more about the cluster provisioning lifecycle from the [Provision a cluster](https://docs.datastax.com/en/mission-control/administration/control-plane/add-db-cluster.html) documentation.


## 4 - Multi-Datacenter Clusters

Mission Control managed Apache Cassandra, DSE, and HCD clusters all use the same CRD and Web-UI for deployment and management.  Let's create a more advanced cluster configuration.

✅ **Navigate to the project you created and click the "Create Cluster" button**

✅ **Fill in the following basic information to deploy a two datacenter / 6 node DSE cluster**
- Cluster Name: `dse-demo`
- Type: Apache DataStax Enterprise (DSE)
- Version: `6.9.0`
- Datacenter Name: `dc-1`
- Rack Name: `r1`, name click the "Add Rack": button twice.  Name the new racks `r2` and `r3`
- Click the "Add Datacenter" button, and repeat the above - datacenter name `dc-2` and add three racks: `r1`, `r2`, `r3`.

Explore the tunables within the datacenter topology box.  
- Custom `cassandra.yaml` settings
- Custom `dse.yaml` settings
- Rack-level node affinity labels to enforce AZ alignment for racks

✅ **Complete the following and deploy the new DSE cluster**
- Storage Class: `standard` (scroll a ways down the form to find this)
- Deselect "Require authentication to access cluster"
- Click the "Create Cluster" button

Observe the cluster topology and deployment status.  It will take a few minutes for the pods hosting the cluster nodes to fully deploy.
<img width="1379" alt="image" src="https://github.com/user-attachments/assets/d43dacd3-2320-4200-9925-0d022924590c" />


## 5 - Cluster Scaling

Mission Control supports the entire cluster lifecyle, not just provisioning.   Return to your `cassandra-demo` cluster so we can modify its configuration.

✅ **Navigate to the `cassandra-demo` tile then cick the "Modify Cluster" button**

Notice that some elements are read-only - those are mutable prior to initial provisioning.

✅ **Scroll to the bottom of the topology box and increase "Nodes Per Rack" to 2 then cick the "Modify Cluster" button**
<img width="1379" alt="image" src="https://github.com/user-attachments/assets/6b983843-3bef-466b-9361-efdf3ca7d19f" />

Observe the lifecycle as the newly added node is created and joined to the cluster.

This same task can be done via `kubectl` directly with a patch like this:

```
kubectl patch MissionControlCluster cassandra-demo \
  -n myname-demo-098464zq \
  --type=merge \
  -p '{"spec":{"k8ssandra":{"cassandra":{"datacenters":[{"datacenterName":"dc-1","size":2}]}}}}'
```


## 6 - Upgrading Clusters

Cluster upgrades are managed using the same lifecycle process as other modifications to the cluster - changes are rolled out to one pod at a time.

✅ **Navigate to the `dse-demo` tile then cick the "Modify Cluster" button**

✅ **Complete the following and modify the new `dse-demo` cluster**
- Server Version: `6.9.4` (previously was a lower version like `6.9`)
- Click the "Modify Cluster" button

Observe the rolling upgrade process with the Web-UI as each node / pod is lifecycled and moved to the specified version.
<img width="1379" alt="image" src="https://github.com/user-attachments/assets/19276115-d90e-4b6d-b9b5-5d1365114205" />


This can also be accomplished vie `kubectl` with a Gitops pattern by modifying the `MissionControlCluster` resource.

```
apiVersion: missioncontrol.datastax.com/v1beta2
kind: MissionControlCluster
metadata:
  name: dse-demo
spec:
  k8ssandra:
    cassandra:
      serverVersion: 6.9.4
...
```

Learn more about the non-disruptive in-place cluster upgrades from the [Upgrade a DSE cluster](https://docs.datastax.com/en/mission-control/administration/control-plane/upgrade-dse-cluster.html) documentation.


## 7 - Cluster Migration

Using the same pattern as with in-place upgrades, you can also perform an in-place migration to a new cluster type (where compatible).

✅ **Navigate to the `cassandra-demo` tile then cick the "Modify Cluster" button**

✅ **Complete the following and modify the `cassandra-demo` cluster**
- Type: Hyper Converged Database (HCD)
- Click the "Modify Cluster" button



## 8 - Cluster Maintenance


## 9 - Data Maintenance


## 10 - Exploring Telemetry

✅ **Navigate to the "Observability" tab in one of your cluster and explore the "Health Metrics".  Modify the datacenter filter, and time period.**
<img width="1379" alt="image" src="https://github.com/user-attachments/assets/95a85aa8-1a26-4ed6-a32e-832ffee878d0" />

✅ **Navigate back to the `dse-demo` cluster then click on of the the nodes to view node specific metrics.**
Observe the capatured infrastructure and C* level detail.
<img width="1379" alt="image" src="https://github.com/user-attachments/assets/3fd1c11f-0e61-4637-8bcc-00a1f7fb1c01" />

Mission Control leverages [Vector](https://vector.dev/) (by Datadog) to power the observability pipeline.  It comes with pre-configured sinks for Prometheus, and supports all of the native sinks that ship with Vector.

Learn more about observability from the [Metrics](https://docs.datastax.com/en/mission-control/administration/observability/metrics.html), [Alerts](https://docs.datastax.com/en/mission-control/administration/observability/alerts.html), and [Export metrics and logs](https://docs.datastax.com/en/mission-control/administration/observability/external-metrics-logs.html) documentation.



