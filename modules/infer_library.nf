// Second module: Trimming with bbduk

process infer {

    publishDir "${params.outdir}/${sample_id}", mode: 'copy'

    input:
    tuple val(sample_id), path(bams)

    output:
    tuple val(sample_id), path('*_strandness.txt')

    script:
    """
    infer_experiment.py -r $params.gtf -i $bams > ${sample_id}_strandness.txt
    """

}