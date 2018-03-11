FROM beginor/mono:5.10.0.140

LABEL MAINTAINER="beginor <beginor@qq.com>"

# COPY startup script and make it executable
COPY bootstrap.sh /usr/bin/

# Install wget download and install jexus, then cleanup
RUN apt-get update \
    && apt-get install -y wget curl \
    && wget https://linuxdot.net/down/jexus-5.8.3.tar.gz \
    && tar -zxf jexus-5.8.3.tar.gz \
    && jexus-5.8.3/install \
    && rm -rf jexus-5.8.3 \
    && rm jexus-5.8.3.tar.gz \
    && apt-get remove -y wget \
    && apt-get purge -y wget \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Expost ports
EXPOSE 80 443
# Define volumes
VOLUME ["/usr/jexus/siteconf", "/var/www", "/usr/jexus/log"]
# Define workdir
WORKDIR /usr/jexus
# Define startup scripts;
ENTRYPOINT ["/usr/bin/bootstrap.sh"]
# Healthy check
HEALTHCHECK --interval=30s --timeout=30s --start-period=30s --retries=3 \
  CMD curl -f http://127.0.0.1 || exit 1
