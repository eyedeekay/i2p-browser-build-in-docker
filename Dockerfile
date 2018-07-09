FROM debian:stable
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y libyaml-libyaml-perl libtemplate-perl \
                  libio-handle-util-perl libio-all-perl \
                  libio-captureoutput-perl libpath-tiny-perl \
                  libstring-shellquote-perl libsort-versions-perl \
                  libdigest-sha-perl libdata-uuid-perl libdata-dump-perl \
                  libfile-copy-recursive-perl git libgtk2.0-dev curl wget \
                  runc git
RUN adduser --disabled-password --gecos 'build,,,,' build
COPY Makefile Dockerfile /home/build/
RUN chown -R build:build /home/build/
USER build
WORKDIR /home/build/
RUN make configure
WORKDIR /home/build/i2p-browser-build
RUN make submodule-update
RUN ./rbm/rbm fetch argparse
RUN ./rbm/rbm fetch binutils
RUN ./rbm/rbm fetch cctools
RUN ./rbm/rbm fetch cmake
RUN ./rbm/rbm fetch container-image
RUN ./rbm/rbm fetch debootstrap-image
RUN ./rbm/rbm fetch depot_tools
RUN ./rbm/rbm fetch ed25519
RUN ./rbm/rbm fetch elfutils
RUN ./rbm/rbm fetch firefox
RUN ./rbm/rbm fetch firefox-langpacks
RUN ./rbm/rbm fetch fonts
RUN ./rbm/rbm fetch fteproxy
RUN ./rbm/rbm fetch fxc2
RUN ./rbm/rbm fetch gcc
RUN ./rbm/rbm fetch gmp
RUN ./rbm/rbm fetch go
RUN ./rbm/rbm fetch goptlib
RUN ./rbm/rbm fetch go-webrtc
RUN ./rbm/rbm fetch goxcrypto
RUN ./rbm/rbm fetch goxnet
RUN ./rbm/rbm fetch https-everywhere
RUN ./rbm/rbm fetch libdmg-hfsplus
RUN ./rbm/rbm fetch libevent
RUN ./rbm/rbm fetch libfte
RUN ./rbm/rbm fetch llvm
RUN ./rbm/rbm fetch macosx-toolchain
RUN ./rbm/rbm fetch meek
RUN ./rbm/rbm fetch mingw-w64
RUN ./rbm/rbm fetch nsis
RUN ./rbm/rbm fetch obfs4
RUN ./rbm/rbm fetch obfsproxy
RUN ./rbm/rbm fetch openssl
RUN ./rbm/rbm fetch parsley
RUN ./rbm/rbm fetch pycrypto
RUN ./rbm/rbm fetch pyptlib
RUN ./rbm/rbm fetch pyyaml
RUN ./rbm/rbm fetch release
RUN ./rbm/rbm fetch rust
RUN ./rbm/rbm fetch selfrando
RUN ./rbm/rbm fetch siphash
RUN ./rbm/rbm fetch snowflake
RUN ./rbm/rbm fetch tbb-windows-installer
RUN ./rbm/rbm fetch tor
RUN ./rbm/rbm fetch tor-browser
RUN ./rbm/rbm fetch torbutton
RUN ./rbm/rbm fetch tor-launcher
RUN ./rbm/rbm fetch twisted
RUN ./rbm/rbm fetch txsocksx
RUN ./rbm/rbm fetch uniuri
RUN ./rbm/rbm fetch webrtc
RUN ./rbm/rbm fetch winpython
RUN ./rbm/rbm fetch zlib
RUN ./rbm/rbm fetch zope.interface
CMD make nightly-linux-x86_64
