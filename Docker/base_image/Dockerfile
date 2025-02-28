FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive 

# Install dependencies and tools

RUN apt-get update --quiet && \
	apt-get install --quiet -y --no-install-recommends \
	curl \
	git \
	tree \
	ca-certificates \
	default-jre && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install apptainer

RUN apt update && \
	apt install -y software-properties-common && \
	add-apt-repository -y ppa:apptainer/ppa && \
	apt update && \
	apt install -y apptainer

# Reset the front end to default

ENV DEBIAN_FRONTEND=

# Install Nextflow

RUN curl -s https://get.nextflow.io | bash && \
	mv nextflow /usr/local/bin

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

# Install some tools with pixi

RUN pixi global install -c conda-forge -c bioconda nf-core gh quarto

# Set WORKDIR

WORKDIR $HOME

# Define default command

CMD ["bash"]
