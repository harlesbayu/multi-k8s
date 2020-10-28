docker build -t harlesbayu/multi-client -f ./client/Dockerfile ./client
docker build -t harlesbayu/multi-server -f ./server/Dockerfile ./server
docker build -t harlesbayu/multi-worker -f ./worker/Dockerfule ./worker
docker push harlesbayu/multi-client
docker push harlesbayu/multi-server
docker push harlesbayu/multi-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployments server=harlesbayu/multi-server
kubectl set image deployments/client-deployments server=harlesbayu/client-server
kubectl set image deployments/worker-deployments server=harlesbayu/worker-server
