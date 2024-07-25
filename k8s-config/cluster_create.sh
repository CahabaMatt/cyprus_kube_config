

# Gets the AWS Accounts and sets it to a variable
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
echo $AWS_ACCOUNT_ID
# Create Cluster
eksctl create cluster --name flex-cluster --region us-east-1 --version 1.30 --nodegroup-name standard-workers --node-type t3.medium --nodes 2 --nodes-min 1 --nodes-max 3 --managed
# Assumes you have kubectl installed. Updates kubeconfig to use the new cluster
aws eks update-kubeconfig --name flex-cluster --region us-east-1


helm upgrade aws-ebs-csi-driver-helm aws-ebs-csi-driver/aws-ebs-csi-driver \
  --namespace kube-system \
  --set enableVolumeScheduling=true \
  --set enableVolumeResizing=true \
  --set enableVolumeSnapshot=true \
  --set controller.serviceAccount.create=true \
  --set controller.serviceAccount.name=ebs-csi-controller-helm \
  --set node.serviceAccount.create=true \
  --set node.serviceAccount.name=ebs-csi-node-helm
