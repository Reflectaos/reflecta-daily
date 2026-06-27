FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

RUN apt-get update && apt-get install -y \
    curl git unzip xz-utils zip libglu1-mesa \
    clang cmake ninja-build pkg-config libgtk-3-dev wget \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/flutter/flutter.git /flutter \
    --depth 1 --branch stable

ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter precache --web \
    && flutter config --enable-web \
    && flutter doctor

RUN curl -sL https://firebase.tools | bash

RUN dart pub global activate flutterfire_cli
ENV PATH="${PATH}:/root/.pub-cache/bin"

RUN chown -R vscode:vscode /flutter
