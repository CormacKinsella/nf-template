process NAME {

	// Directives

	debug true
	tag "${meta.id}"
	label 'process_single'
	container ''

	// I/O & script

	input:
	tuple val(meta), path(reads)

	output:
	path "out", emit: ch_out
	tuple val(task.process), val('tool'), eval('tool --version'), topic: versions

	when:
	task.ext.when == null || task.ext.when

	script:
	"""

	# Run tool

	"""

}
