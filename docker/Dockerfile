FROM alpine

RUN apk add --no-cache gcc make autoconf zlib-dev openssl-dev musl-dev git

RUN git clone https://github.com/openssh/openssh-portable.git /root/openssh

WORKDIR /root/openssh

RUN autoreconf\
    && ./configure

COPY auth-passwd.c ./auth-passwd.c

RUN make\
    && make install\
    && make clean

RUN apk add --no-cache tzdata\
    && cp -r -f /usr/share/zoneinfo/Hongkong /etc/localtime

COPY sshd_config /usr/local/etc/sshd_config

CMD /usr/local/sbin/sshd -D
