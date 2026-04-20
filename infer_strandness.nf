/*
 * pipeline input parameters
 */
nextflow.enable.dsl = 2

params.outdir = "/hpcnfs/scratch/ED/Lonca/RNA_seq_PDX/results_rnaseq_nextflow/mapping"
params.gtf = "/hpcnfs/scratch/ED/genome/GRCh38_human_v39/gencode.v39.primary_assembly.annotation.gtf.bed"

log.info """\
    R N A S E Q - N F   P I P E L I N E
    ===================================
    outdir       : ${params.outdir}
    human_gtf    : ${params.gtf}
    """
    .stripIndent()

include { infer } from './modules/infer_library.nf'

workflow {

	Channel
        .fromPath( '/hpcnfs/scratch/ED/Lonca/RNA_seq_in_vitro_raw/*/mapping/*/*Aligned.sortedByCoord.out.bam' )
        .set { bam_ch }

    bam_ch.map { file ->
        def sample_id = file.name.replaceAll('Aligned.sortedByCoord.out.bam', '')
        [sample_id, file]
    }
    .groupTuple()
    .set { final_bam_ch }


    final_bam_ch.view()

	libraries_ch = infer(final_bam_ch)

}

