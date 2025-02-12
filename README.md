# Nextflow development template

## Summary

**nf-template** is a Nextflow pipeline template.

## Quick start

### Gitpod cloud test environment (update URL to the project repo)

[![Open test environment in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/CormacKinsella/nf-template)

>[!TIP]
>The Gitpod environment includes pixi, Nextflow, Apptainer, and other useful tools - so you can directly run pipeline tests.

### Local or cluster installation

- Install or update the [pixi package manager](https://pixi.sh/latest/)

```
# Install

curl -fsSL https://pixi.sh/install.sh | bash

# Update

pixi self-update

```

- Clone the pipeline repository

- Run the pipeline from the repository, e.g.: `pixi run test` or `pixi run dag`

## Required inputs

### Samplesheet

>[!TIP]
> The table below is for visualisation, in practice it should be represented in a `samplesheet.csv` file

## Outputs (defaults to 'results' directory)

- FASTQC reports on input reads

- Package version report file

## Pipeline overview

**Insert pipeline dag**
