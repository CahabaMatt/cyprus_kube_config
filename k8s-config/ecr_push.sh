docker build -t aces-app .
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 339712977225.dkr.ecr.us-east-1.amazonaws.com
docker tag aces-app:latest 339712977225.dkr.ecr.us-east-1.amazonaws.com/aces-app:latest
docker push 339712977225.dkr.ecr.us-east-1.amazonaws.com/aces-app:latest

helm upgrade --install flex-backend . --values values.yaml