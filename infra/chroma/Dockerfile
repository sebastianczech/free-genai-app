FROM python:3.11-slim-buster

WORKDIR /chroma

COPY infra/chroma/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY infra/chroma .

CMD ["chroma", "run", "--path", "./db"]