# #login
# az login

# #select subscription
# $subscription = "21c605e4-8080-4fb2-81a9-fa419e5390e3"
# az account set --subscription "21c605e4-8080-4fb2-81a9-fa419e5390e3"

# Create a resource group
$resourceGroup="kube-monitoring"
$location="westeurope"

# # Cloud Lab users can ignore this command and should use the existing Resource group, such as "cloud-demo-XXXXXX" 
# az group create --name $resourceGroup --location $location

# # ACR name should not have upper case letter
$acrname = "blizzart"
# az acr create --resource-group $resourceGroup --name $acrname --sku Basic

# # Log in to the ACR
# az acr login --name $acrname

# # Get the ACR login server name
# # To use the azure-vote-front container image with ACR, the image needs to be tagged with the login server address of your registry. 
# # Find the login server address of your registry
#az acr show --name $acrname --query loginServer --output table

# # Associate a tag to the local image
#docker tag mcr.microsoft.com/azuredocs/azure-vote-front:v1 "blizzart.azurecr.io/azure-vote-front:v1"

# # Now you will see $acrname.azurecr.io/azure-vote-front:v1 if you run docker images
# # Push the local registry to remote
#docker push blizzart.azurecr.io/azure-vote-front:v1

# # Verify if you image is up in the cloud.
# az acr repository list --name "$acrname.azurecr.io" --output table


# #create kubernetes cluster
# # To ensure your cluster operates reliably, it is preferable to run at least 2 (two) nodes.
# # For this exercise, let's start with just one node.
# # NOTE: Cloud Lab users cannot use the "--enable-addons monitoring" option in the "az aks create" because they are not allowed to create the Log Analytics workspace.
# # Instead, Cloud Lab users should enable the monitoring in a separate command "az aks enable-addons -a monitoring", as shown in the "create-cluster.sh" above, to use the existing Log Analytics workspace's Resource ID.
$clusterName = "myAKSCluster"

# az aks create --name $clusterName `
#  --resource-group $resourceGroup `
#  --node-count 1 `
#  --enable-addons monitoring `
#  --generate-ssh-keys `
#  --attach-acr $acrname
 
# # To connect to the Kubernetes cluster from your local computer, you use kubectl, the Kubernetes command-line client.
# # Preferable run as super user sudo

# az aks install-cli
# # Configure kubectl to connect to your Kubernetes cluster

#az aks get-credentials --resource-group $resourceGroup --name $clusterName 
# # Verify the connection to your cluster

# kubectl get nodes

# # Deploy the images to the AKS cluster

# # Get the ACR login server name
az acr show --name $acrname --query loginServer --output table

# # Edit the manifest file, *azure-vote-all-in-one-redis.yaml*, to replace `mcr.microsoft.com/azuredocs/azure-vote-front:v1` with `myacr202106.azurecr.io/azure-vote-front:v1`.  
# # If you do not change the manifest file, then it will use Microsoft's image for this application available at Dockerhub - https://hub.docker.com/r/microsoft/azure-vote-front
# # The reason for editing is that in order to push an image to ACR, the image needs to be tagged with the login server address of your registry. 


# # Deploy the application. Run the command below from the parent directory where the *azure-vote-all-in-one-redis.yaml* file is present. 
# kubectl apply -f azure-vote-all-in-one-redis.yaml
# # Test the application
# kubectl get service azure-vote-front --watch
# # You can also verify that the service is running like this
# kubectl get service