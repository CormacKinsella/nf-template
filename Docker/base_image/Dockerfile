# Base image

FROM ubuntu:24.04

# User is root by default, explicit due to later switch

USER root

# Skip interactive post-install configuration steps

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

# Reset the front end to its original value

ENV DEBIAN_FRONTEND=

# Install Nextflow

RUN curl -s https://get.nextflow.io | bash && \
	mv nextflow /usr/local/bin

# Create cloud user/group, give ownership of required bin

RUN groupadd -g 33333 cloud && \
	useradd -u 33333 -g cloud -m cloud -s /bin/bash && \
	chown -R cloud:cloud /usr/local/bin

# Switch to cloud user for remaining installations & setup

USER cloud

# Install pixi

ENV HOME=/home/cloud

ENV PATH="$HOME/.pixi/bin:$PATH"

RUN curl -fsSL https://pixi.sh/install.sh | bash

# Install some tools with pixi

RUN pixi global install -c conda-forge -c bioconda nf-core gh quarto

# Add aliases

RUN echo "alias ll='ls -alh'" >> $HOME/.bashrc && \
	echo "alias l='ls -1'" >> $HOME/.bashrc && \
	echo "alias li='ls -l | head -n 20'" >> $HOME/.bashrc && \
	echo "alias lo='ls -l | tail -n 20'" >> $HOME/.bashrc && \
	echo "alias ..='cd ../..'" >> $HOME/.bashrc && \
	echo "alias ...='cd ../../..'" >> $HOME/.bashrc

# Git configuration

RUN git config --global alias.br branch && \
	git config --global alias.ch checkout && \
	git config --global alias.st status && \
	git config --global alias.co commit && \
	git config --global credential.helper '!gh auth git-credential' && \
	echo "git () { if [[ \$1 == 'br' ]]; then command git br -a; elif [[ \$1 == 'st' ]]; then command git st -u; else command git \"\$@\"; fi; }" >> $HOME/.bashrc && \
	echo 'parse_git_branch() { branch=$(git branch 2> /dev/null | sed -n "/^\*/s/^\* //p"); if [ -n "$branch" ]; then echo "($branch)"; fi; }' >> $HOME/.bashrc && \
	echo 'PS1="\u:\$(pwd | sed \"s|^$HOME|~|\")\$(parse_git_branch)\$ "' >> $HOME/.bashrc && \
	echo >> $HOME/.bashrc

# Set WORKDIR
WORKDIR $HOME

# Define default command

CMD ["bash"]
