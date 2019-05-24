FROM fedora:30

RUN dnf install -y graphviz pandoc xz \
 && dnf clean all

WORKDIR /usr/local/bin
RUN curl -s https://cdsoft.fr/pp/pp-linux-x86_64.txz | tar Jxvf -

ENTRYPOINT ["pp"]
