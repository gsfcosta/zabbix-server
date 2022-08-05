FROM centos:7

RUN yum install -y epel-release
RUN yum update -y
RUN yum install -y jq \
          mysql-devel \
          gcc \
          make \
          unzip \
          zip \
          libxml2-devel \
          net-snmp-devel \
          libcurl-devel \
          openssl-devel \
          fping \
          python-pip \
          python3 \
          ruby \
          perl-IO-Socket-SSL \
          perl-Digest-HMAC \
          perl-TermReadKey \
          perl-MIME-Lite \
          perl-File-LibMagic \
          perl-IO-Socket-INET6 \
          mysql \
          which \
          automake \
          libevent-devel \
          perl-JSON-XS \
          perl-libwww-perl \
	  perl-LWP-Protocol-https \
	  perl-parent \
	  perl-ExtUtils-MakeMaker \
          perl-Test-Simple \
 	  perl-Test-Exception \
	  net-snmp-utils \
	  dos2unix


#RUN pip install pip --upgrade
RUN pip install boto3 \
                requests
                
RUN pip3 install requests
RUN pip3 install python-dateutil

COPY ["source/zabbix*.tar.gz", "/tmp/zabbix.tar.gz"]

WORKDIR /tmp/
RUN tar zxvf zabbix.tar.gz
RUN cd /tmp/zabbix-* && \
    ./configure --prefix=/usr/local/zabbix --enable-server \
        --enable-agent \
        --with-net-snmp \
        --with-mysql \
        --with-libcurl \
        --with-libxml2 \
        --with-openssl

RUN cd /tmp/zabbix-* && make install
RUN useradd zabbix

COPY ["scripts/run.sh", "/run.sh"]
COPY ["scripts/sendEmail", "/usr/bin/sendEmail"]
COPY ["etc/zabbix_server.conf", "/usr/local/zabbix/etc/zabbix_server.conf"]
COPY ["source/zabbix-notify-master.zip", "/tmp/zabbix-notify-master.zip"]

RUN chown -R zabbix.zabbix /usr/local/zabbix/ && \
    mkdir -p /zabbix_scripts/external_scripts && \
    mkdir -p /zabbix_scripts/alertscripts && \
    chmod +x -R /zabbix_scripts/external_scripts && \
    chown -R zabbix.zabbix /zabbix_scripts/external_scripts && \
    chown -R zabbix.zabbix /zabbix_scripts/alertscripts/ && \
    chmod +x /usr/bin/sendEmail

RUN ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

WORKDIR /tmp
RUN unzip /tmp/zabbix-notify-master.zip
WORKDIR /tmp/zabbix-notify-master
RUN perl Makefile.PL INSTALLSITESCRIPT=/zabbix_scripts/alertscripts
RUN make install

ENV PATH="/usr/local/zabbix/bin:/usr/local/zabbix/sbin:${PATH}"

USER zabbix
ENTRYPOINT ["/run.sh"]
