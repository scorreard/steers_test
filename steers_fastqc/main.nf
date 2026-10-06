
log.info """
STEERS fastqc - Solenne Correard - GenOuest
=============================================
Specie id			: ${params.id}
Input file  		: ${params.input}
"""

include { FASTQC                      } from './../modules/nf-core/fastqc/main'
include { CUTADAPT                    } from './../modules/nf-core/cutadapt/main'
include { HIFIASM                     } from './../modules/nf-core/hifiasm/main'
include { CUSTOM_DUMPSOFTWAREVERSIONS } from './../modules/nf-core/custom/dumpsoftwareversions/main'

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    RUN MAIN WORKFLOW
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

// Info required for completion email and summary

workflow {

    input_data = [
        [ id:params.id, single_end: true], // meta map
        [ file(params.input, checkIfExists: true) ]
    ]

    ch_versions = Channel.empty()

    FASTQC (
        input_data
    )
    ch_versions = ch_versions.mix(FASTQC.out.versions.first())

    CUTADAPT (
        input_data
    )
    ch_versions = ch_versions.mix(CUTADAPT.out.versions.first())

    HIFIASM(CUTADAPT.out.reads, [[], [], []], [[], [], []], [[], []])
    ch_versions = ch_versions.mix(HIFIASM.out.versions.first())

    CUSTOM_DUMPSOFTWAREVERSIONS (
        ch_versions.unique().collectFile(name: 'collated_versions.yml')
    )
}
