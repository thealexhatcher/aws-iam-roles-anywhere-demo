FROM amazonlinux:2
## SYSTEM SETUP
RUN yum update -y
RUN yum install -y sudo gcc g++ make git zip unzip tar bzip2 wget jq openssl uuid which python3 -y
## VSCODE USER Setup
RUN wget --quiet "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -O ~/awscliv2.zip \
    && unzip ~/awscliv2.zip \
    && ./aws/install \
    && aws --version \
    && rm aws/install \
    && rm ~/awscliv2.zip
RUN wget --quiet https://s3.amazonaws.com/roles-anywhere-credential-helper/CredentialHelper/latest/linux_amd64/aws_signing_helper -O /usr/local/bin/aws_signing_helper \
    && chmod +x /usr/local/bin/aws_signing_helper
RUN adduser vscode
RUN usermod -aG wheel vscode
RUN echo '%vscode ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
USER vscode
