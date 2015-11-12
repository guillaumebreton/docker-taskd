FROM debian:wheezy

RUN mkdir "/var/taskdata"
ENV TASKDATA="/var/taskdata"
ENV SIGN_DN="localhost"
VOLUME ["/var/taskdata"]

# install dependency
RUN apt-get update
RUN apt-get install -y cmake wget uuid-dev libuuid1 gnutls-bin libgnutls-dev build-essential curl

# Get taskd
RUN cd /var &&  \
    curl -O http://taskwarrior.org/download/taskd-1.1.0.tar.gz && \
    tar -xvzf taskd-1.1.0.tar.gz && \
    rm taskd-1.1.0.tar.gz && \
    mv taskd-1.1.0 taskd && \
    cd taskd && \
    cmake -DCMAKE_BUILD_TYPE=release . && \
    make && \
    make install

COPY start-taskd.sh "/usr/bin/start-taskd.sh"
RUN chmod +x "/usr/bin/start-taskd.sh"

WORKDIR "/var/taskd"

CMD ["start-taskd.sh"]

