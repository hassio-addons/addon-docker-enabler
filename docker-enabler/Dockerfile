ARG BUILD_FROM=hassioaddons/base:2.2.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Copy root filesystem
COPY rootfs /

# Scrip to run after startup
CMD ["/usr/bin/run.sh"]

# Build arugments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Docker Enabler" \
    io.hass.description="Grants an add-on access to the Docker socket" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.label-schema.description="Grants an add-on access to the Docker socket" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Docker Enabler" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://addons.community" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-docker-enabler/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-docker-enabler" \
    org.label-schema.vendor="Community Hass.io Addons"
