docker build -t cruzlll/multi-client:latest -t cruzlll/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cruzlll/multi-server:latest -t cruzlll/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cruzlll/multi-worker:latest -t cruzlll/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cruzlll/multi-client:latest 
docker push cruzlll/multi-server:latest
docker push cruzlll/multi-worker:latest

docker push cruzlll/multi-client:$SHA 
docker push cruzlll/multi-server:$SHA 
docker push cruzlll/multi-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cruzlll/multi-server:$SHA
kubectl set image deployments/client-deployment client=cruzlll/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cruzlll/multi-worker:$SHA