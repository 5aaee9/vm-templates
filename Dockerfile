FROM archlinux

ENV RUNNER_VERSION="2.169.1"

# Init build env
RUN yes | pacman -Syu packer \
        qemu \
        cloud-utils \
        ansible \
        dotnet-runtime \
        curl \
        openssl \
        zlib \
        rclone \
        unzip \
        krb5 \
        wget \
        iputils \
        jq && \
    mkdir /runner && \
    cd /runner && \
    wget https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    rm -f ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    mkdir _work

WORKDIR /runner
COPY scripts/entrypoint.sh /entrypoint.sh

CMD [ "/entrypoint.sh" ]
