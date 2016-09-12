FROM ubuntu:16.04

MAINTAINER beginor <beginor@qq.com>

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb http://download.mono-project.com/repo/debian wheezy main" | tee /etc/apt/sources.list.d/mono-xamarin.list \
    && apt-get update \
    && apt-get install -y mono-devel ca-certificates-mono referenceassemblies-pcl wget openssh-server \
    && rm -rf /var/lib/apt/lists/*

RUN wget http://linuxdot.net/down/jexus-5.8.1.tar.gz \
    && tar -zxf jexus-5.8.1.tar.gz \
    && jexus-5.8.1/install \
    && rm -rf jexus-5.8.1 \
    && rm jexus-5.8.1.tar.gz

RUN mkdir -p /var/www/default \
    && echo '<% Response.Write("Hello, world!"); %>' > /var/www/default/index.aspx

ADD start-jexus.sh /start-jexus.sh

RUN chmod a+x /start-jexus.sh

EXPOSE 443 80 22

VOLUME ["/usr/jexus/siteconf", "/var/www", "/usr/jexus/log"]

CMD ["/start-jexus.sh"]
