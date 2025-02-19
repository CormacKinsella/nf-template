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

// Email report

	if (params.email_report) {

		workflow.onComplete {

			// Prepare email content
			def workflow_status = workflow.success ? 'COMPLETED' : 'FAILED'
			def email_address = params.email
			def subject = "Pipeline execution ${workflow.runName}: ${workflow_status}"
			def msg = """
			Pipeline execution summary
			---------------------------
			Run Name     : ${workflow.runName}
			Completed at : ${workflow.complete}
			Duration     : ${workflow.duration}
			Success      : ${workflow.success}
			Exit status  : ${workflow.exitStatus}
			Error report : ${workflow.errorReport ?: 'No errors'}
			"""
			.stripIndent()

			// Send the email
			sendMail(
				to: email_address,
				subject: subject,
				body: msg
			)

		}

	}
