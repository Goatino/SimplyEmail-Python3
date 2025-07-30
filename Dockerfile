# image base
FROM alpine:3.19

# extra metadata
LABEL maintainer="SimplySecurity"
LABEL description="Alpine Linux Dockerfile for SimplyEmail."

# install basic build items and Python 3
RUN apk update && apk add --no-cache \
    wget \
    curl \
    git \
    bash \
    python3 \
    python3-dev \
    py3-pip \
    gcc \
    musl-dev \
    libffi-dev \
    openssl-dev \
    libxml2-dev \
    libxslt-dev \
    jpeg-dev \
    zlib-dev \
    libmagic \
    file-dev \
    && ln -sf python3 /usr/bin/python \
    && ln -sf pip3 /usr/bin/pip

# Copy the project files
COPY . /opt/SimplyEmail/

# Install Python dependencies
WORKDIR "/opt/SimplyEmail"
RUN pip install --no-cache-dir --break-system-packages -r requirements-py3.txt

# Make the main script executable
RUN chmod +x ./SimplyEmail.py

ENTRYPOINT ["python3", "./SimplyEmail.py"]
