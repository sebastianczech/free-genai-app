FROM python:3.13

WORKDIR /chroma

RUN apt update && apt install sqlite3 build-essential -y && apt upgrade -y

COPY infra/chroma/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY infra/chroma .

CMD ["chroma", "run", "--path", "./db"]