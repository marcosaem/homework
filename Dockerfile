FROM grafana/grafana:latest

USER grafana
ARG GF_INSTALL_PLUGINS="grafana-piechart-panel,briangann-gauge-panel,jdbranham-diagram-panel,natel-discrete-panel,vonage-status-panel,snuids-trafficlights-panel,sbueringer-consul-datasource,vertamedia-clickhouse-datasource,simpod-json-datasource,blackmirror1-singlestat-math-panel"

COPY ldap.toml /etc/grafana/ldap.toml

RUN if [ ! -z "${GF_INSTALL_PLUGINS}" ]; then \
    OLDIFS=$IFS; \
        IFS=','; \
    for plugin in ${GF_INSTALL_PLUGINS}; do \
        IFS=$OLDIFS; \
        echo "${GF_PATHS_PLUGINS}" && grafana-cli --pluginsDir "${GF_PATHS_PLUGINS}" plugins install ${plugin}; \
    done; \
fi;
