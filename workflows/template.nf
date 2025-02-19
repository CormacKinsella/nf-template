/* 
----------------------------------------------------------------------------------------
Main workflow
----------------------------------------------------------------------------------------
*/

// Feature flags

	nextflow.preview.topic = true
	nextflow.preview.output = true

// Imports

	include { FASTQC } from '../modules/fastqc.nf'

// Main workflow

	workflow TEMPLATE {

		take:

			ch_samplesheet

		main:

			// Run FastQC

				FASTQC(ch_samplesheet)

			// Report package versions

				Channel.topic('versions')
					.map { process, tool, version ->
						return [process: process, tool: tool, version: version]
					}
					.unique()
					.collect()
					.map { it.join('\n') }
					.collectFile(name: 'package_versions.txt', newLine: true)
					.set { ch_versions }

		emit:

			// Emit channels for publication

				ch_fastqc = FASTQC.out.ch_fastqc
				ch_versions = ch_versions

	}
