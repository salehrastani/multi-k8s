docker build -t salehrastani/multi-client:latest -t salehrastani/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t salehrastani/multi-server:latest -t salehrastani/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t salehrastani/multi-worker:latest -t salehrastani/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push salehrastani/multi-client:latest
docker push salehrastani/multi-server:latest
docker push salehrastani/multi-worker:latest

docker push salehrastani/multi-client:$SHA
docker push salehrastani/multi-server:$SHA
docker push salehrastani/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=salehrastani/multi-client:$SHA
kubectl set image deployments/server-deployment server=salehrastani/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=salehrastani/multi-worker:$SHA
