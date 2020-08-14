FROM ubuntu:16.04

RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         git \
         curl \
         ca-certificates \
         libjpeg-dev \
         libpng-dev && \
     rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
RUN chmod -R a+w /workspace

COPY . .
RUN pip install --upgrade pip && pip install kfserving
ENTRYPOINT ["python", "-m", "InferenceModel"]