ARG BUILD_FROM
FROM golang:1.25-alpine AS build

ARG BUILD_ARCH
ARG BUILD_FROM

ENV CGO_ENABLED=0
WORKDIR /app

COPY scheduler .

RUN if [ "${BUILD_ARCH}" = "armhf" ]; then \
        export GOARCH=arm GOARM=6; \
    elif [ "${BUILD_ARCH}" = "armv7" ]; then \
        export GOARCH=arm GOARM=7; \
    elif [ "${BUILD_ARCH}" = "aarch64" ]; then \
        export GOARCH=arm64; \
    elif [ "${BUILD_ARCH}" = "i386" ]; then \
        export GOARCH=386; \
    elif [ "${BUILD_ARCH}" = "amd64" ]; then \
        export GOARCH=amd64; \
    else \
        exit 1; \
    fi \
    && go build -o scheduler.bin


FROM $BUILD_FROM

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

ENV LANG=C.UTF-8
# renovate: datasource=github-releases depName=rclone packageName=rclone/rclone
ENV RCLONE_INSTALLED_VERSION=1.72.1
# renovate: datasource=github-releases depName=rclone-webui packageName=rclone/rclone-webui-react
ENV RCLONE_WEBUI_INSTALLED_VERSION=2.0.5
# renovate: datasource=github-releases depName=restic packageName=restic/restic
ENV RESTIC_INSTALLED_VERSION=0.17.3
# renovate: datasource=github-releases depName=backrest packageName=garethgeorge/backrest
ENV BACKREST_INSTALLED_VERSION=1.12.0

RUN apk add bzip2 socat

# Copy root filesystem
COPY rootfs /

# Download Web GUI
RUN curl -LJo /tmp/currentbuild.zip https://github.com/rclone/rclone-webui-react/releases/download/v"${RCLONE_WEBUI_INSTALLED_VERSION}"/currentbuild.zip \
    && unzip /tmp/currentbuild.zip -d /tmp \
    && mkdir -p /usr/share/rclone-webui-react \
    && mv /tmp/build/* /usr/share/rclone-webui-react \
    && rm -rf /tmp/*

# Fix permissions
RUN chmod a+x /etc/cont-init.d/* \
    && chmod a+x /etc/services.d/*/* \
    && chmod a+x /usr/bin/xdg-open

# Install requirements for add-on
RUN if [ "${BUILD_ARCH}" = "armhf" ]; then \
        curl -LJo /tmp/rclone.zip https://github.com/rclone/rclone/releases/download/v"${RCLONE_INSTALLED_VERSION}"/rclone-v"${RCLONE_INSTALLED_VERSION}"-linux-arm.zip; \
    elif [ "${BUILD_ARCH}" = "armv7" ]; then \
        curl -LJo /tmp/rclone.zip https://github.com/rclone/rclone/releases/download/v"${RCLONE_INSTALLED_VERSION}"/rclone-v"${RCLONE_INSTALLED_VERSION}"-linux-arm-v7.zip; \
    elif [ "${BUILD_ARCH}" = "aarch64" ]; then \
        curl -LJo /tmp/rclone.zip https://github.com/rclone/rclone/releases/download/v"${RCLONE_INSTALLED_VERSION}"/rclone-v"${RCLONE_INSTALLED_VERSION}"-linux-arm64.zip; \
    elif [ "${BUILD_ARCH}" = "i386" ]; then \
        curl -LJo /tmp/rclone.zip https://github.com/rclone/rclone/releases/download/v"${RCLONE_INSTALLED_VERSION}"/rclone-v"${RCLONE_INSTALLED_VERSION}"-linux-386.zip; \
    elif [ "${BUILD_ARCH}" = "amd64" ]; then \
        curl -LJo /tmp/rclone.zip https://github.com/rclone/rclone/releases/download/v"${RCLONE_INSTALLED_VERSION}"/rclone-v"${RCLONE_INSTALLED_VERSION}"-linux-amd64.zip; \
    else \
        exit 1; \
    fi \
    && unzip /tmp/rclone.zip -d /tmp \
    && cp /tmp/rclone-*/rclone /usr/bin/rclone  \
    && chmod 755 /usr/bin/rclone \
    && rm -rf /tmp/rclone* \
    && mkdir -p /root/.config/rclone

# Install restic
RUN if [ "${BUILD_ARCH}" = "armhf" ]; then \
        curl -LJo /tmp/restic.bz2 https://github.com/restic/restic/releases/download/v"${RESTIC_INSTALLED_VERSION}"/restic_"${RESTIC_INSTALLED_VERSION}"_linux_arm.bz2; \
    elif [ "${BUILD_ARCH}" = "armv7" ]; then \
        curl -LJo /tmp/restic.bz2 https://github.com/restic/restic/releases/download/v"${RESTIC_INSTALLED_VERSION}"/restic_"${RESTIC_INSTALLED_VERSION}"_linux_arm.bz2; \
    elif [ "${BUILD_ARCH}" = "aarch64" ]; then \
        curl -LJo /tmp/restic.bz2 https://github.com/restic/restic/releases/download/v"${RESTIC_INSTALLED_VERSION}"/restic_"${RESTIC_INSTALLED_VERSION}"_linux_arm64.bz2; \
    elif [ "${BUILD_ARCH}" = "i386" ]; then \
        curl -LJo /tmp/restic.bz2 https://github.com/restic/restic/releases/download/v"${RESTIC_INSTALLED_VERSION}"/restic_"${RESTIC_INSTALLED_VERSION}"_linux_386.bz2; \
    elif [ "${BUILD_ARCH}" = "amd64" ]; then \
        curl -LJo /tmp/restic.bz2 https://github.com/restic/restic/releases/download/v"${RESTIC_INSTALLED_VERSION}"/restic_"${RESTIC_INSTALLED_VERSION}"_linux_amd64.bz2; \
    else \
        exit 1; \
    fi \
    && bzip2 -d /tmp/restic.bz2 \
    && mv /tmp/restic /usr/bin/restic \
    && chmod 755 /usr/bin/restic

# Install backrest (not available for i386)
RUN if [ "${BUILD_ARCH}" = "armhf" ]; then \
        curl -LJo /tmp/backrest.tar.gz https://github.com/garethgeorge/backrest/releases/download/v"${BACKREST_INSTALLED_VERSION}"/backrest_Linux_armv6.tar.gz; \
    elif [ "${BUILD_ARCH}" = "armv7" ]; then \
        curl -LJo /tmp/backrest.tar.gz https://github.com/garethgeorge/backrest/releases/download/v"${BACKREST_INSTALLED_VERSION}"/backrest_Linux_armv6.tar.gz; \
    elif [ "${BUILD_ARCH}" = "aarch64" ]; then \
        curl -LJo /tmp/backrest.tar.gz https://github.com/garethgeorge/backrest/releases/download/v"${BACKREST_INSTALLED_VERSION}"/backrest_Linux_arm64.tar.gz; \
    elif [ "${BUILD_ARCH}" = "amd64" ]; then \
        curl -LJo /tmp/backrest.tar.gz https://github.com/garethgeorge/backrest/releases/download/v"${BACKREST_INSTALLED_VERSION}"/backrest_Linux_x86_64.tar.gz; \
    else \
        echo "Backrest not available for ${BUILD_ARCH}, skipping install"; \
        exit 0; \
    fi \
    && tar -xzf /tmp/backrest.tar.gz -C /tmp \
    && mv /tmp/backrest /usr/bin/backrest \
    && chmod 755 /usr/bin/backrest \
    && rm -f /tmp/backrest.tar.gz

# add scheduler binary
COPY --from=build /app/scheduler.bin /usr/bin/scheduler

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Josh Willox" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="" \
    org.opencontainers.image.authors="Josh Willox" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
