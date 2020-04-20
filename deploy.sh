docker build -t rm01964/multi-client:latest -t rm01964/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rm01964/multi-server:latest -t rm01964/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rm01964/multi-worker:latest -t rm01964/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rm01964/multi-client:latest
docker push rm01964/multi-server:latest
docker push rm01964/multi-worker:latest

docker push rm01964/multi-client:$SHA
docker push rm01964/multi-server:$SHA
docker push rm01964/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rm01964/multi-server:$SHA
kubectl set image deployments/client-deployment client=rm01964/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rm01964/multi-worker:$SHA