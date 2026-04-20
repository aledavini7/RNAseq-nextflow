// Third module: Alignment with STAR

process star {

    publishDir "${params.outdir}/mapping/${sample_id}", mode: 'copy'

    conda '/hpcnfs/scratch/ED/davini/analysis/rna_seq_snake/.snakemake/conda/812f336485e53b203483f799aaaa2f5e'

    input:
    tuple val(sample_id), path(trimmed_reads)

    output:
    tuple val(sample_id), path('*Aligned.sortedByCoord.out.bam')
    tuple val(sample_id), path('*Log.final.out')
    tuple val(sample_id), path('*ReadsPerGene.out.tab')

    script:
    """
    STAR --runThreadN $task.cpus --readFilesCommand zcat --readFilesIn ${trimmed_reads[0]} ${trimmed_reads[1]} --outFileNamePrefix ${sample_id} --genomeDir ${params.index} --sjdbGTFfile ${params.gtf_rnaseq} --outSAMstrandField intronMotif --outFilterIntronMotifs RemoveNoncanonicalUnannotated --quantMode GeneCounts --outSAMtype BAM SortedByCoordinate --limitBAMsortRAM 20000000000
    """

}
