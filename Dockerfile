FROM debian:stable-slim
ENV PASSWORD="cra"
RUN apt update && apt install ca-certificates -y
RUN sed -i 's/deb.debian.org/mirrors.sustech.edu.cn/g' /etc/apt/sources.list && apt update 
RUN apt install vim systemctl openssh-server fish gcc g++ git gnupg curl wget screen -y
RUN chsh -s /usr/bin/fish
RUN mkdir /.ssh && touch /.ssh/authorized_keys && curl https://file.cdn.ntdgy.top/pubkey > /.ssh/authorized_keys && chmod 700 /.ssh && chmod 600 /.ssh/authorized_keys
RUN curl https://file.cdn.ntdgy.top/ca.crt -o  /usr/local/share/ca-certificates/ca.crt && update-ca-certificates
RUN echo "PermitRootLogin yes \nPubkeyAuthentication yes\nAuthorizedKeysFile          .ssh/authorized_keys .ssh/authorized_keys2\nPasswordAuthentication yes" >> /etc/ssh/sshd_config && service ssh restart
RUN echo "root:${PASSWORD}" | chpasswd 
COPY start.sh /start.sh
RUN chmod 755 /start.sh
CMD ["/bin/bash","/start.sh"]

