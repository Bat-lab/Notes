FROM centos:7.9.2009

RUN yum update -y && \
    yum install epel-release -y && \
    yum update -y && \
    yum -y install curl telnet wget && \
    yum clean all -y

RUN   rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022  && \
      yum localinstall https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm -y && \
      yum install mysql-community-server -y 
      


#RUN yum install supervisor -y

#ADD supervisord.conf /etc/supervisor/conf.d/

EXPOSE 3306

#COPY entrypoint.sh /opt

#RUN chmod +x /opt/entrypoint.sh

RUN yum install expect -y

ADD script.service /usr/lib/systemd/system/ 

RUN ln -s /usr/lib/systemd/system/script.service /etc/systemd/system/multi-user.target.wants/

ADD mysql.sh /opt

RUN chmod +x /opt/mysql.sh

CMD ["/usr/sbin/init"]
