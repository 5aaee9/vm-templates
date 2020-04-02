FROM archlinux

ENV RUNNER_VERSION="2.168.0"

# Init build env
RUN yes | pacman -Syu packer \
        qemu \
        cloud-utils \
        curl \
        wget \
        jq && \
    mkdir /runner && \
    cd /runner && \
    wget https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    rm -f ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    ./bin/installdependencies.sh && \
    mkdir _work

WORKDIR /runner
COPY scripts/entrypoint.sh /entrypoint.sh

CMD [ "/entrypoint.sh" ]
