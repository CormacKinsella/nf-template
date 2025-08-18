FROM ubuntu:24.04

# Metadata

ARG DESCRIPTION="Docker image for Nextflow development"
LABEL org.opencontainers.image.description=$DESCRIPTION

# Suppress interactive menus

ENV DEBIAN_FRONTEND=noninteractive 

# Install dependencies
# gh should remain here, as .gitconfig authentication helper assumes apt installation, i.e.: /usr/bin/gh

RUN apt-get update --quiet && \
	apt-get install --quiet -y --no-install-recommends \
	curl \
	git \
	gh \
	tree \
	ca-certificates \
	default-jre && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install wave

RUN curl -L -o wave-1.5.1.jar "https://github.com/seqeralabs/wave-cli/releases/download/v1.5.1/wave-1.5.1.jar"

RUN chmod +x wave-1.5.1.jar && \
	mv wave-1.5.1.jar /usr/local/bin

# Reset the front end to default

ENV DEBIAN_FRONTEND=

# Create user 'codespace'

RUN groupadd -g 33333 codespace && \
	useradd -u 33333 -g codespace -m codespace -s /bin/bash && \
	chown -R codespace:codespace /usr/local/bin

# Switch to codespace user

USER codespace
ENV HOME=/home/codespace

# Install pixi

ENV PATH="$HOME/.pixi/bin:$PATH"

RUN curl -fsSL https://pixi.sh/install.sh | bash

# Install tools

RUN pixi global install -c conda-forge -c bioconda nextflow=25.04.6 apptainer=1.4.2 nf-core=3.3.2 quarto=1.7.33

WORKDIR $HOME

# Define default command

CMD ["bash"]
