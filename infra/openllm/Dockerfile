FROM python:3.11-slim-buster

WORKDIR /chroma

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN openllm repo update

COPY . .

CMD ["openllm", "serve", "llama3.2:1b-instruct-ggml-fp16-darwin"]
