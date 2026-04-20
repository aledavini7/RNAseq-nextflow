
include { fastqc; fastq_screen; multiqc; fastqc as fastqc_trimm; fastq_screen as fastq_screen_trimm; multiqc_trimm } from './modules/qc.nf'
include { trimming } from './modules/trimming.nf'
include { star } from './modules/mapping.nf'

workflow RNA_SEQ {

	Channel
    .fromFilePairs(params.reads, checkIfExists: true)
    .set { reads_ch }

	qc_ch = fastqc(reads_ch)
    screen_ch = fastq_screen(reads_ch)

    multiqc_ch = multiqc(qc_ch.mix(screen_ch).collect())

    trimmed_ch = trimming(reads_ch)

    qc_trimmed_ch = fastqc_trimm(trimmed_ch)
    screen_trimmed_ch = fastq_screen_trimm(trimmed_ch)

    multiqc_trimm_ch = multiqc_trimm(qc_trimmed_ch.mix(screen_trimmed_ch).collect())


    star_ch = star(trimmed_ch)

}

