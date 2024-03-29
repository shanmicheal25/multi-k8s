docker build -t shanmicheal25/multi-client:latest -t shanmicheal25/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shanmicheal25/multi-server:latest -t shanmicheal25/multi-client:$SHA  -f ./server/Dockerfile ./server
docker build -t shanmicheal25/multi-worker:latest -t shanmicheal25/multi-client:$SHA  -f ./worker/Dockerfile ./worker
docker push shanmicheal25/multi-client:latest
docker push shanmicheal25/multi-server:latest
docker push shanmicheal25/multi-worker:latest

docker push shanmicheal25/multi-client:$SHA
docker push shanmicheal25/multi-server:$SHA
docker push shanmicheal25/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shanmicheal25/multi-server:$SHA
kubectl set image deployments/client-deployment server=shanmicheal25/multi-client:$SHA
kubectl set image deployments/worker-deployment server=shanmicheal25/multi-worker:$SHA