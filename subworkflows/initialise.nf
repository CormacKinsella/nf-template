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

		// Reference genome channel

			Channel
				.fromPath("${params.reference}", checkIfExists: true)
				.map { file ->
					def extension = file.extension
					if (['fa', 'fna', 'fasta'].contains(extension)) {
						return file
					} else {
						error ("ERROR: Reference file '${file}' does not have a '.fa', '.fna', or '.fasta' extension, please provide a FASTA file.")
					}
				}
				.set { ch_reference }

	emit:

		// Emit channels to main workflow

			ch_samplesheet = ch_samplesheet
			ch_reference = ch_reference

}
