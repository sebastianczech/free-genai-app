build:
	docker buildx build --tag openllm-service:latest --file infra/openllm/Dockerfile .
	docker buildx build --tag chroma-service:latest --file infra/chroma/Dockerfile .
	docker buildx build --tag load-balancer-k8s:latest --file infra/lb/Dockerfile .

cluster:
	kind create cluster --config infra/k8s/multi-node.yaml --name home-lab

config:
	kind load docker-image openllm-service:latest --name home-lab
	kind load docker-image chroma-service:latest --name home-lab
	kubectl apply -f infra/openllm/k8s.yaml
	kubectl apply -f infra/chroma/k8s.yaml
	kubectl label node home-lab-control-plane node.kubernetes.io/exclude-from-external-load-balancers-

unconfig:
	kubectl delete -f infra/openllm/k8s.yaml
	kubectl delete -f infra/chroma/k8s.yaml

lb:
	docker run --rm --network kind -v /var/run/docker.sock:/var/run/docker.sock load-balancer-k8s

clean:
	kind delete cluster -n home-lab
	docker image prune --all --force
	docker system prune --all --force

status:
	docker images
	docker exec -it home-lab-worker crictl images
	kind get clusters
	kubectl get nodes
	kubectl get all