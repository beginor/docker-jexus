FROM beginor/mono:5.2.0

MAINTAINER beginor <beginor@qq.com>

# COPY startup script and make it executable
COPY bootstrap.sh /usr/bin/

# Install wget download and install jexus, then cleanup
RUN apt-get update \
    && apt-get install -y wget \
    && wget http://linuxdot.net/down/jexus-5.8.2.tar.gz \
    && tar -zxf jexus-5.8.2.tar.gz \
    && jexus-5.8.2/install \
    && rm -rf jexus-5.8.2 \
    && rm jexus-5.8.2.tar.gz \
    && apt-get remove -y wget \
    && apt-get purge -y wget \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/www/default

# Expost ports
EXPOSE 80 443
# Define volumes
VOLUME ["/usr/jexus/siteconf", "/var/www", "/usr/jexus/log"]
# Define workdir
WORKDIR /usr/jexus
# Define startup scripts;
ENTRYPOINT ["/usr/bin/bootstrap.sh"]
