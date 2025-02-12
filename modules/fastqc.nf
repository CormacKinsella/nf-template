process FASTQC {

	// Directives

	debug false
	tag "${meta.id}"
	label 'process_single'
	container 'oras://community.wave.seqera.io/library/fastqc:0.12.1--0827550dd72a3745'

	// I/O & script

	input:
	tuple val(meta), path(reads)

	output:
	path "*fastqc.zip", emit: ch_fastqc
	tuple val(task.process), val('fastqc'), eval('fastqc --version | sed "s/.* v//"'), topic: versions

	when:
	task.ext.when == null || task.ext.when

	script:
	"""

	# Run FastQC on raw and fastp processed reads

		fastqc --format fastq --threads ${task.cpus} ${reads}

	# Clean up

		rm *.html

	"""

}
