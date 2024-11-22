# Build GenAI application running locally for free

## Prerequisites

Before using code from that repository, please install tools:
- [Docker Desktop](https://docs.docker.com/desktop/) for running containers locally
- [kind](https://kind.sigs.k8s.io/) for running local Kubernetes

## Tech stack

In repository there were used multiple components:
- [OpenLLM](https://github.com/bentoml/OpenLLM) for open-source LLMs
- [Chroma](https://docs.trychroma.com/) as open-source vector database
- [LangChain](https://python.langchain.com/docs/introduction/) as a framework for developing application
- [Streamlit](https://docs.streamlit.io/) for powerful data application

## Infrastructure

1. Create Kubernetes cluster using kind:
```bash
TODO
```
2. Build Docker images for OpenLLM and Chroma:
```bash
TODO
```
3. Deploy OpenLLM and Chroma services in local Kubernetes cluster:
```bash
TODO
```

## CI/CD

As all components for that repository are deployed locally, in CI/CD workflows there are prepared pipelines for:
- linting PR titles
- executing `pre-commit` tools for every PR
- doing release with CHANGELOG

For commands executed on local machines, there was prepared `Makefile`, using which in few steps you can deploy whole infrastructure.

## Application

Basic LLM app was built using tutorials:
- [Build a basic LLM chat app](https://docs.streamlit.io/develop/tutorials/llms/build-conversational-apps)
- [Build an LLM app using LangChain](https://docs.streamlit.io/develop/tutorials/llms/llm-quickstart)

1. Install dependencies:
```bash
cd app
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```
2. Define OpenAI API key:
```bash
mkdir -p .streamlit
echo 'OPENAI_API_KEY = "YOUR_API_KEY"' > .streamlit/secrets.toml
```
3. Run echo bot:
```bash
streamlit run echo_bot.py
```
4. Run simple chat:
```bash
streamlit run simple_chat.py
```
5. Run ChatGPT-like app:
```bash
streamlit run chat_gpt_like.py
```
6. Run playground:
```bash
streamlit run playground.py
```
