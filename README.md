# kubernetes-todo-app

## Instructions:

#### Local test
`brew tap mongodb/brew`  
`brew install mongodb-community@6.0`  
`pip install pymongodb`  

#### for testing test flask app on docker
`docker build -t testapp .`  
`docker run -p 8090:5000 testapp`  
`docker rm <container_id>`  
`docker rmi <image_id>`  

#### run the app with mongo
`docker-compose up`  

#### push to docker hub
`docker build -t todo-app-arm64 .`  
`docker tag todo-app-arm64 tahajunaid1/todo-app-arm64:latest`  
`docker push tahajunaid1/todo-app-arm64:latest`  


#### local kubernetes:
`brew inistall minikube`  
`minikube start`  
`minikube dashboard`  
`kubectl apply -f kubernetes`  
`minikube service todo-service`  

#### debug
`kubectl get all`  
`kubectl get pod`  
`kubectl get deployments`  
`kubectl get service -owide`  
`kubectl get pvc`  
`kubectl logs todo-app-77c75744b7-px6zn`  
`kubectl describe pod todo-app-77c75744b7-px6zn`  


#### EKS (setup aws console cli):  
#### install kubectl and eksctl. 
#### Eksctl installation:  
`curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp`  

`sudo mv /tmp/eksctl /usr/local/bin`  
`eksctl version`  
#### create a kubernetes cluster with t2.micro instances  
`eksctl create cluster --name tjk8 --region us-east-2 --node-type t2.micro`   
 


#### set creds
`aws configure`  
> AWS Access Key ID [None]: NICE TRY
> AWS Secret Access Key [None]: NOT ANYMORE  
> Default region name [None]: us-east-2  
> Default output format [None]: json`  

#### increase nodes
`eksctl scale nodegroup --cluster=tjk8 --name=ng-185b3bdc --nodes-max=8`  
`eksctl scale nodegroup --cluster=tjk8 --name=ng-185b3bdc --nodes=8`  


#### add AmazonEBSCSIDriverPolicy to your nodegroup permissions  

#### download ebs cli driver (we need this for pvc)  
`kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.17"`  
#### verify if ebs driver working on all nodes  
`kubectl get pods -n kube-system | grep ebs`  
#### For EKS you have to build the image for amd64 (on my mac it was for arm64)  
`docker buildx build --platform=linux/amd64 -t ${tj2237-todo-app-web:1.0} .`  
`docker tag todo-app-web tahajunaid1/todo-app:latest`  
`docker push tahajunaid1/todo-app:latest`   

#### upload single yml file with all deployments, services, pvc etc to cli  
`kubectl apply -f minikube-depl-all.yml`  

##### delete everything and retry in case of errors
`kubectl delete all`  
`kubectl delete deployment todo-app && kubectl delete deployment mongo-db && kubectl delete service todo-service && kubectl delete service mongo-service && kubectl delete pvc mongo-pvc && rm minikube-depl-all.yml`
 
