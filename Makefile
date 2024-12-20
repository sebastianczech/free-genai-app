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

unconfig:
	kubectl delete -f infra/openllm/k8s.yaml
	kubectl delete -f infra/chroma/k8s.yaml

lb:
	kubectl label node home-lab-control-plane node.kubernetes.io/exclude-from-external-load-balancers-
	docker run -p 8010:30810 -p 3010:30310 --rm --network kind -v /var/run/docker.sock:/var/run/docker.sock load-balancer-k8s

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

check:
	pre-commit run --all-files
	kubeconform -summary -skip Cluster infra

debug_k8s_control_plane:
	docker exec -it home-lab-control-plane bash

debug_k8s_worker1:
	docker exec -it home-lab-worker bash

debug_k8s_worker2:
	docker exec -it home-lab-worker2 bash

debug_lb:
	docker exec -it home-lab-control-plane curl 172.18.0.7:8010
	docker exec -it home-lab-control-plane curl 172.18.0.6:3010

debug_pods:
	kubectl run tmp-shell --rm -i --tty --image nicolaka/netshoot

debug_chrome:
	docker run --name chroma-service --rm -it chroma-service:latest bash

debug_openllm:
	docker run --name openllm-service --rm -it openllm-service:latest bash
