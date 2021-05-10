docker build -t aiscream/multi-client:latest -t aiscream/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aiscream/multi-server -t aiscream/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aiscream/multi-worker aiscream/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push aiscream/multi-client:latest
docker push aiscream/multi-server:latest
docker push aiscream/multi-worker:latest
docker push aiscream/multi-client:$SHA
docker push aiscream/multi-server:$SHA
docker push aiscream/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deplyment server aicream/multi-server:$SHA
kubectl set image deployments/client-deplyment client aicream/multi-client:$SHA
kubectl set image deployments/worker-deplyment worker aicream/multi-worker:$SHA
