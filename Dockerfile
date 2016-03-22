FROM frolvlad/alpine-oraclejdk8

RUN apk add --update dropbear openssh-sftp-server bash mc git curl && \
    rm -rf /var/cache/apk/* && \
    mkdir /etc/dropbear && \
    touch /var/log/lastlog && \
    adduser -D deployIt && echo "deployIt:deployIt" | chpasswd

WORKDIR /home/deployIt
ADD run.sh run.sh

RUN chown -R deployIt:deployIt /home/deployIt
RUN chmod +x run.sh

CMD ["/home/deployIt/run.sh"]
