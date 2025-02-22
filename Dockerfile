FROM public.ecr.aws/amazonlinux/amazonlinux:latest

# Install dependencies
RUN yum update -y && \
 yum install -y httpd

# Set ServerName to suppress warnings
RUN echo "a20888cff0b544f89ba1235f091d6e0f-1674497320.ap-south-1.elb.amazonaws.com" >> /etc/httpd/conf/httpd.conf

## Install apache and write hello world message
RUN echo 'Hello World!' > /var/www/html/index.html

## Configure apache
RUN echo 'mkdir -p /var/run/httpd' >> /root/run_apache.sh && \
 echo 'mkdir -p /var/lock/httpd' >> /root/run_apache.sh && \
 echo '/usr/sbin/httpd -D FOREGROUND' >> /root/run_apache.sh && \
 chmod 755 /root/run_apache.sh

EXPOSE 8080

CMD /root/run_apache.sh
