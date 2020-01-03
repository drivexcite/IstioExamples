# Istio on Kubernetes - Traffic Management

This repository contains a working example of the Traffic Management and Fault Injection features of the Istio Service Mesh on Kubernetes.

The repository is intended to show the features in an incremental fashion:
1.  The first part (scripts 00 to 02) is about installing the Istio Bookinfo Sample Application in plain Kubernetes and show out of the box the limited capabilities of observability and routing native to Kubernetes (essentially limited to the Ingress resource).
2.  The second part (sripts 03 to 04) is about installing Istio and inspect all the different components that get installed out of the box to help with the Visualization of a dynamically discovered and periodically updated Microservice Graph using Kiali and the different built-in Dashboards offered by Istio in Grafana.
3.  The third part (script 05) is about installing the Bookinfo Sample Application and realizing how one of Istio components, the Sidecar Injector, automatically adds an Envoy proxy that sits right in front of every Kubernetes Deployment to provide the Service Mesh features.
4.  The fourt part (scripts 06 to 08) is about installing and configuring the Istio primitives like Destination Rules and Virtual Services, that will make possible the Traffic Management and Fault Injection features.
5.  Finally the fifth part (scripts 09 to 13) are just variations of script 08, that gradually change the state of the Service Mesh, to highlight the following functionalities:
    1.  Canary Deployments: Script 09, uses Istio to route a **fixed percentage** of traffic to multiple versions of the same application, deployed side by side.
    2.  A/B Testing: Script 10, uses Istio to **route a special subset of users to a different version** of the same application, deployed side by side.
    3.  Fault Injection: Script 11 uses Istio to instruct the Envoy proxy to **return an artificially injected HTTP 503 response code** on a fixed percentage of requests.
    4.  Selective Fault Injection: Script 12, as before, it instructs the Envoy proxy to return an HTTP 503 response code, **but only for a special subset of users**, in order to prevent disruption for all clients.
    5.  Artificial Delay: Script 13, uses Istio to instruct the Envoy proxy to delay the response for a fixed amount of time on a certain percentage of requests.

# Running the examples

The examples are designed to run on a Kubernetes Cluster; this repository contains two VS Code Remote Containers, configured for two different Cloud Providers:
1.  The one in the parent folder is configured for Microsoft Azure. The remote container is configured with the Azure CLI and Powershell. 
    * `infrastructure/build_infrastructure.ps1` contains all the necessary code to create a new Cluster in Azure Kubernetes Service, install Kubectl and set the credentials to talk directly to the cluster. 
    *   `infrastructure/tear_down_cluster.ps1` is for cleanup. 
    *   The special script `install_istio.ps1` contains all the necessary steps to run the example, assuming a PowerShell is available.
2.  The one in the `Istio1.4-GoogleCloudPlatform` folder is configured for Google Cloud Platform. The remote container is configured with the Google Cloud Platform SDK. 
    *   `infrastructure/build_infrastructure.sh` contains all the necessary code to create a new Cluster in Google Kubernetes Engine. 
    *   `infrastructure/init_kubectl.sh` installs Kubectl and set the credentials to talk directly to the cluster.
    *   `infrastructure/tear_down_cluster.sh` is for cleanup. 
    *   The special script `install_istio.sh` contains all the necessary steps to run the example using the Bash shell.

# Traffic Generator
In order to generate some constant traffic and see the topology of the Service Mesh change in real-time, a very small and naive .NET Core application is provided for this purpose. In order to make it run, open the `TrafficGenerator/Program.cs` file and change the provided URL (`http://40.81.14.250/productpage`) for the Public IP Address of the Kubernetes Ingress  or Istio Gateway from the Kubernetes Cluster created for this exercise.

```powershell
# To compile
dotnet build

# To run
dotnet run
```