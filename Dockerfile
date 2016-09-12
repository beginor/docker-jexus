FROM ubuntu:16.04

MAINTAINER beginor <beginor@qq.com>

RUN apt-get update && apt-get install -y wget

RUN wget http://linuxdot.net/down/jexus-5.8.1-x64.tar.gz \
    && tar -zxf jexus-5.8.1-x64.tar.gz \
    && mv jexus /usr/ \
    && rm jexus-5.8.1-x64.tar.gz

RUN apt-get remove -y wget \
    && apt-get purge -y wget \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/default \
    && echo '<% Response.Write("Hello, world!"); %>' > /var/www/default/index.aspx

COPY start-jexus.sh /start-jexus.sh
RUN chmod +x /start-jexus.sh

EXPOSE 80 443
VOLUME ["/usr/jexus/siteconf", "/var/www", "/usr/jexus/log"]

CMD ["/start-jexus.sh"]