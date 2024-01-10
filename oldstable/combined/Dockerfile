# Copyright 2020 Adam Chalkley
#
# https://github.com/atc0005/go-ci
#
# Licensed under the MIT License. See LICENSE file in the project root for
# full license information.

# https://hub.docker.com/_/golang

FROM golang:1.19.13

# https://docs.github.com/en/packages/learn-github-packages/connecting-a-repository-to-a-package
LABEL org.opencontainers.image.source="https://github.com/atc0005/go-ci"

# https://github.com/opencontainers/image-spec/blob/main/annotations.md#pre-defined-annotation-keys
LABEL org.opencontainers.image.documentation="https://github.com/atc0005/go-ci"
LABEL org.opencontainers.image.url="https://github.com/atc0005/go-ci"
LABEL org.opencontainers.image.title="go-ci-oldstable"
LABEL org.opencontainers.image.description="Docker container image used to lint, build and test Go code. \
    Based on the latest version of the current outgoing stable golang image."
LABEL org.opencontainers.image.authors="Adam Chalkley (github.com/atc0005)"

ENV GOLANGCI_LINT_VERSION="v1.53.3"
ENV STATICCHECK_VERSION="v0.4.3"
ENV GOVULNCHECK_VERSION="v0.1.0"
ENV HTTPERRORYZER_VERSION="v0.0.1"
ENV STRUCTSLOP_VERSION="v0.0.8"
ENV TICKERYZER_VERSION="v0.0.3"
ENV TOMLL_VERSION="v2.0.8"
ENV ERRWRAP_VERSION="v1.5.0"

ENV APT_BSDMAINUTILS_VERSION="12.1.8"
ENV APT_TREE_VERSION="2.1.0-1"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    bsdmainutils=${APT_BSDMAINUTILS_VERSION} \
    tree=${APT_TREE_VERSION} \
    
    \
    && echo "Installing staticcheck@${STATICCHECK_VERSION}" \
    && go install honnef.co/go/tools/cmd/staticcheck@${STATICCHECK_VERSION} \
    && staticcheck --version \
    && echo "Installing govulncheck@${GOVULNCHECK_VERSION}" \
    
    

    && go install golang.org/x/vuln/cmd/govulncheck@${GOVULNCHECK_VERSION} || true \
    && echo 'Installing golangci-lint' \
    && curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b "$(go env GOPATH)/bin" ${GOLANGCI_LINT_VERSION} \
    && golangci-lint --version || true \
    && echo "Installing httperroryzer@${HTTPERRORYZER_VERSION}" \
    
    && go install github.com/orijtech/httperroryzer/cmd/httperroryzer@${HTTPERRORYZER_VERSION} || true \
    && echo 'Installing structslop' \
    && go install github.com/orijtech/structslop/cmd/structslop@${STRUCTSLOP_VERSION} || true \
    && echo 'Installing tickeryzer' \
    && go install github.com/orijtech/tickeryzer/cmd/tickeryzer@${TICKERYZER_VERSION} || true \
    && echo 'Installing tomll' \
    && go install github.com/pelletier/go-toml/v2/cmd/tomll@${TOMLL_VERSION} || true \
    && echo 'Installing errwrap' \
    && go install github.com/fatih/errwrap@${ERRWRAP_VERSION} || true \
    

# Copy over linting config files to root of container image to serve as a
# default. Projects bringing their own config files (e.g., via GitHub Actions)
# can easily override these files, while projects choosing to use these config
# files exclusively can omit their copy.
COPY .markdownlint.yml /
COPY .golangci.yml /
