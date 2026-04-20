
include { infer } from './modules/infer_library.nf'

workflow INFER_STRANDNESS {

	Channel
    .fromPath(params.bams, checkIfExists: true)
    .set { bam_ch }

    bam_ch.map { file ->
        def sample_id = file.name.replaceAll('Aligned.sortedByCoord.out.bam', '')
        [sample_id, file]
    }
    .groupTuple()
    .set { final_bam_ch }

	libraries_ch = infer(final_bam_ch)

}

