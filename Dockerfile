FROM ubuntu:16.04

MAINTAINER beginor <beginor@qq.com>

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb http://download.mono-project.com/repo/debian wheezy main" | tee /etc/apt/sources.list.d/mono-xamarin.list \
    && apt-get update \
    && apt-get install -y mono-devel ca-certificates-mono referenceassemblies-pcl wget openssh-server

RUN wget http://linuxdot.net/down/jexus-5.8.1.tar.gz \
    && tar -zxf jexus-5.8.1.tar.gz \
    && jexus-5.8.1/install \
    && rm -rf jexus-5.8.1 \
    && rm jexus-5.8.1.tar.gz

RUN apt-get remove -y wget \
    && apt-get purge -y wget \
    && rm -rf /var/lib/apt/lists/*

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -C '' -N '' && \
    ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -C '' -N ''  && \
    ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -C '' -N ''

RUN mkdir -p /var/www/default \
    && echo '<% Response.Write("Hello, world!"); %>' > /var/www/default/index.aspx

ADD start-jexus.sh /start-jexus.sh

RUN chmod a+x /start-jexus.sh

EXPOSE 443 80 22

VOLUME ["/usr/jexus/siteconf", "/var/www", "/usr/jexus/log"]

CMD ["/start-jexus.sh"]
