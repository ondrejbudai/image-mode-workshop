FROM quay.io/fedora/fedora-bootc:40

RUN dnf install -y osbuild-composer cockpit-composer weldr-client && dnf clean all
RUN systemctl enable cockpit.socket osbuild-composer.socket
