# Add Admin IAM ROLE to EC2
#vim .bashrc
#export PATH=$PATH:/usr/local/bin/
#source .bashrc


#! /bin/bash
curl -Lo kops https://github.com/kubernetes/kops/releases/download/v1.30.3/kops-linux-amd64
chmod +x kops
sudo mv kops /usr/local/bin/
kops version
curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client
aws s3api create-bucket --bucket reyaz-kops-testbkt123.k8s.local --region ap-south-1 --create-bucket-configuration LocationConstraint=ap-south-1
aws s3api put-bucket-versioning --bucket reyaz-kops-testbkt123.k8s.local --region ap-south-1 --versioning-configuration Status=Enabled
export KOPS_STATE_STORE=s3://reyaz-kops-testbkt123.k8s.local
kops create cluster --name reyaz.k8s.local --zones ap-south-1a --master-count=1 --master-size t2.medium --node-count=2 --node-size t2.micro
kops update cluster --name reyaz.k8s.local --yes --admin
#kops upgrade cluster --name <your-cluster-name> --yes
#kops validate cluster --wait 10m
