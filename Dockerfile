FROM beginor/mono:latest

MAINTAINER beginor <beginor@qq.com>

# Install wget and openssh-server, download and install jexus, then cleanup
RUN apt-get update \
    && apt-get install -y wget openssh-server \
    && wget http://linuxdot.net/down/jexus-5.8.1.tar.gz \
    && tar -zxf jexus-5.8.1.tar.gz \
    && jexus-5.8.1/install \
    && rm -rf jexus-5.8.1 \
    && rm jexus-5.8.1.tar.gz \
    && apt-get remove -y wget \
    && apt-get purge -y wget \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove -y \
    && mkdir -p /var/run/sshd \
    && mkdir -p /var/www/default

# Add startup script and make it executable
ADD start-jexus.sh /start-jexus.sh
RUN chmod a+x /start-jexus.sh

# Expost ports
EXPOSE 443 80 22

# Define volumes
VOLUME ["/usr/jexus/siteconf", "/var/www", "/usr/jexus/log"]

# Define startup scripts;
CMD ["/start-jexus.sh"]
