docker build -t prasannabp/multi-client:latest -t prasannabp/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t prasannabp/multi-server:latest -t prasannabp/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t prasannabp/multi-worker:latest -t prasannabp/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push prasannabp/multi-client:latest
docker push prasannabp/multi-server:latest
docker push prasannabp/multi-worker:latest

docker push prasannabp/multi-client:$SHA
docker push prasannabp/multi-server:$SHA
docker push prasannabp/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=prasannabp/multi-server:$SHA
kubectl set image deployments/client-deployment client=prasannabp/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=prasannabp/multi-worker:$SHA
