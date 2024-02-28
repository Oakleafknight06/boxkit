ARG SOURCE_IMAGE_NAME="${SOURCE_IMAGE_NAME:-wolfi-toolbox}"
ARG SOURCE_IMAGE_REGISTRY="${SOURCE_IMAGE_REGISTRY:-ghcr.io/ublue-os}"
ARG SOURCE_IMAGE="${SOURCE_IMAGE_REGISTRY}/${SOURCE_IMAGE_NAME}"

FROM $SOURCE_IMAGE:latest

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the Toolbox or Distrobox commands" \
      summary="A new cloud-native terminal experience powered by Wolfi and Homebrew" \
      maintainer=""

COPY ./extra-packages/ /toolbox-packages
COPY ./files /

# Update image, Install Packages, and move /home/linuxbrew
RUN apk update && \
    apk upgrade && \
    grep -v '^#' /toolbox-packages | xargs apk add && \
    mv /home/linuxbrew /home/homebrew && \
    rm /toolbox-packages

