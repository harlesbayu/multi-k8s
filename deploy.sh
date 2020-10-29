docker build -t harlesbayu/multi-client:latest -t harlesbayu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t harlesbayu/multi-server:latest -t harlesbayu/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t harlesbayu/multi-worker:latest -t harlesbayu/multi-worker:$SHA-f ./worker/Dockerfile ./worker

docker push harlesbayu/multi-client:latest
docker push harlesbayu/multi-server:latest
docker push harlesbayu/multi-worker:latest

docker push harlesbayu/multi-client:$SHA
docker push harlesbayu/multi-server:$SHA
docker push harlesbayu/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployments server=harlesbayu/multi-server:$SHA
kubectl set image deployments/client-deployments client=harlesbayu/client-server:$SHA
kubectl set image deployments/worker-deployments worker=harlesbayu/worker-server:$SHA
