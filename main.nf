#!/usr/bin/env nextflow

/*
----------------------------------------------------------------------------------------

CormacKinsella/nf-template

GitHub: https://github.com/CormacKinsella/nf-template

Contributors:
- Cormac Kinsella (cormac.kinsella@nbis.se)

----------------------------------------------------------------------------------------
*/

// Imports

	include { INITIALISE } from './subworkflows/initialise.nf'
	include { TEMPLATE } from './workflows/template.nf'

// Entry workflow

	workflow {

		main:

			INITIALISE ()
			TEMPLATE (INITIALISE.out.ch_samplesheet)

		publish:

			TEMPLATE.out.ch_fastqc >> 'fastqc'
			TEMPLATE.out.ch_versions >> 'package_versions'
	}

// Publish outputs

	output {

		fastqc {
			path 'quality_reports/fastqc'
			mode 'copy'
			overwrite false
		}

		package_versions {
			path 'package_versions'
			mode 'copy'
			overwrite true
		}

	}
