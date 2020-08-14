FROM python:3.8

RUN apt-get update && apt-get install -y --no-install-recommends \
         vim \
     rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
RUN chmod -R a+w /workspace

COPY . .
RUN pip install --upgrade pip && pip install kfserving
ENTRYPOINT ["python", "-m", "InferenceModel"]