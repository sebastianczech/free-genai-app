FROM python:3.11-slim-buster

WORKDIR /openllm

COPY infra/openllm/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN openllm repo update

COPY infra/openllm .

CMD ["openllm", "serve", "llama3.2:1b-instruct-ggml-fp16-darwin"]
