FROM ubuntu:22.04 AS build

ENV PIPX_BIN_DIR="/usr/local/bin" \
    PIPX_HOME="/opt/pipx"

RUN <<-EOF
apt-get update
apt-get install -y --no-install-recommends pipx openjdk-17-jre-headless
EOF

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/

FROM build AS runner

RUN <<-EOF
pipx install --include-deps ansible
pipx install ansible-rulebook
EOF

FROM runner AS final

RUN <<-EOF
ansible-galaxy collection install ansible.eda
EOF
