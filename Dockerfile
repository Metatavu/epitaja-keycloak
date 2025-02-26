FROM quay.io/keycloak/keycloak:26.1.2 AS builder

WORKDIR /opt/keycloak
ADD theme /opt/keycloak/themes/epitaja
ENV KC_DB=mysql
ENV KC_HEALTH_ENABLED=true
ENV KC_CACHE_STACK=kubernetes

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:26.1.2
ENV KC_DB=mysql
ENV KC_HEALTH_ENABLED=true
ENV KC_CACHE_STACK=kubernetes

COPY --from=builder /opt/keycloak/ /opt/keycloak/