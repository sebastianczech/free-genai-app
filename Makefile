build:
	docker buildx build --tag openllm_service:latest --file infra/openllm/Dockerfile .
	docker buildx build --tag chroma_service:latest --file infra/chroma/Dockerfile .