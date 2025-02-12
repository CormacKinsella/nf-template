#!/bin/bash -l

# Go to project repository (edit path as needed)

cd ~/project

# Run in the background (edit options as needed)

tmux new -s nf-run -d /bin/bash -c "pixi run nextflow main.nf --account "XXXXX" -profile apptainer,baseHPC"

echo "Nextflow pipeline started in the background"
echo "You can monitor the progress in '.nextflow.log' and with 'squeue'"
