FROM josdotso/docker-pp:texlive-pandoc

# Install PP Deps
RUN apt-get update && apt-get -y install \
    wine-stable \
    wine64 \
    littler \
    lua5.3 \
    xvfb && \
    apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/bin/lua5.3 /usr/bin/lua
RUN dpkg --add-architecture i386 && apt-get update && apt-get -y install \
    wine32 && \
    apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# Install Haskell Tools (PP Dep)
ENV PATH "/root/.local/bin:$PATH"
RUN apt-get update && \
    curl -sSL https://get.haskellstack.org/ | sh && \
    apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN echo "Install PP" && \
    curl -sSL https://github.com/CDSoft/pp/archive/2.8.tar.gz | tar xz && \
    cd pp-* && make && make install && cd .. && rm -rf pp-*

# Install templates.
#   https://github.com/Wandmalfarbe/pandoc-latex-template
RUN cd /tmp && \
    curl -Ls  https://github.com/Wandmalfarbe/pandoc-latex-template/releases/download/v1.2.2/Eisvogel-1.2.2.tar.gz \
    | tar zx && \
    mkdir -p /root/.pandoc/templates && \
    mv eisvogel.tex /root/.pandoc/templates/eisvogel.latex \
    && rm -rf /tmp/*

# Run 'pp' by default.
WORKDIR /root
ENTRYPOINT ["pp"]
