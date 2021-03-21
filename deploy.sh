docker build -t stephengrider/multi-client:latest -t stephengrider/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stephengrider/multi-server:latest -t stephengrider/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t stephengrider/multi-worker:latest -t stephengrider/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pfedorov/multi-client:latest
docker push pfedorov/multi-server:latest
docker push pfedorov/multi-worker:latest

docker push pfedorov/multi-client:$SHA
docker push pfedorov/multi-server:$SHA
docker push pfedorov/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pfedorov/multi-server:$SHA
kubectl set image deployments/client-deployment client=pfedorov/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pfedorov/multi-worker:$SHA