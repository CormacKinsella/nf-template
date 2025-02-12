/*
----------------------------------------------------------------------------------------
Initialisation subworkflow
	- Verify base dependencies
	- Ensure required inputs/params are provided
	- Import samplesheet
----------------------------------------------------------------------------------------
*/

workflow INITIALISE {

	main:

		// Import samplesheet
		
			Channel
				.fromPath("${params.samplesheet}", checkIfExists: true)
				.splitCsv(header: true)
				.map { row ->

					// Process metadata fields

						def meta = [
							id: row.id
						]

					// Validate metadata fields

						// placeholder

					// Add file paths

						def reads = [
							file(row.fastq_1, checkIfExists: true),
							file(row.fastq_2, checkIfExists: true)
						]

					// Return channel object

						return [meta, reads]
				}
				.set { ch_samplesheet }

	emit:

		// Emit channels to main workflow

			ch_samplesheet = ch_samplesheet

}
