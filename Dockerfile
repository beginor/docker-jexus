FROM beginor/mono:5.0.1

MAINTAINER beginor <beginor@qq.com>

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
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove -y \
    && mkdir -p /var/www/default

# Add startup script and make it executable
ADD bootstrap.sh /usr/bin/
# Expost ports
EXPOSE 80 443
# Define volumes
VOLUME ["/usr/jexus/siteconf", "/var/www", "/usr/jexus/log"]
# Define workdir
WORKDIR /usr/jexus
# Define startup scripts;
ENTRYPOINT ["/usr/bin/bootstrap.sh"]
