// Second module: Trimming with bbduk

process trimming {

    publishDir "${params.outdir}/trimmedReads/${sample_id}", mode: 'copy'

    conda '/hpcnfs/scratch/ED/davini/analysis/rna_seq_snake/.snakemake/conda/6aea54332bfd41466f6362bfa5babd10'

    input:
    tuple val(sample_id), path(reads)

    output:
    tuple val(sample_id), path('*_trimmed.fastq.gz')

    script:
    """
    bbduk.sh in1=${reads[0]} in2=${reads[1]} out1=${sample_id}_R1_trimmed.fastq.gz out2=${sample_id}_R2_trimmed.fastq.gz qtrim=r trimq=20 minlen=25
    """

}