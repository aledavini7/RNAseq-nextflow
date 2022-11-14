// First module: Quality Check

process fastqc {

    publishDir "${params.outdir}/qc/${sample_id}", mode: 'copy'

    conda '/hpcnfs/scratch/ED/davini/analysis/rna_seq_snake/.snakemake/conda/de622be5afca1dededa0c89514304fde' //conda env with fastqc=0.11.6

    input:
    tuple val(sample_id), path(reads)

    output:
    path('*')
    //tuple val(sample_id), path('*_fastqc.zip')
    //tuple val(sample_id), path('*_fastqc.html')

    script:
    """
    fastqc ${reads} --threads $task.cpus
    """

}


process fastq_screen {

    publishDir "${params.outdir}/qc/${sample_id}", mode: 'copy'

    conda '/hpcnfs/scratch/ED/davini/analysis/rna_seq_snake/.snakemake/conda/42cbca41bb6f5fab04a97e93c07c3071' //conda env with fastq-screen=0.14.0, bowtie=1.3, bowtie2=2.4, samtools=1.14

    input:
    tuple val(sample_id), path(reads)

    output:
    path('*')
    //tuple val(sample_id), path('*_screen.txt')
    //tuple val(sample_id), path('*_screen.png')
    //tuple val(sample_id), path('*_screen.html')

    script:
    """
    fastq_screen ${reads} --threads $task.cpus
    """    

}

process multiqc {

    publishDir "${params.outdir}/multiqc_raw/", mode: 'copy'

    conda '/hpcnfs/scratch/ED/davini/analysis/rna_seq_snake/.snakemake/conda/c1dcc088ef1e78c31efe662353cdee8f'

    input:
    path '*'
    //tuple val(sample_id), path(qcs)
    //tuple val(sample_id), path(screens)

    output:
    path 'multiqc_report.html'

    script:
    """
    multiqc .
    """

}

process multiqc_trimm {

    publishDir "${params.outdir}/multiqc_trimm/", mode: 'copy'

    conda '/hpcnfs/scratch/ED/davini/analysis/rna_seq_snake/.snakemake/conda/c1dcc088ef1e78c31efe662353cdee8f'

    input:
    path '*'
    //tuple val(sample_id), path(qcs)
    //tuple val(sample_id), path(screens)

    output:
    path 'multiqc_report.html'

    script:
    """
    multiqc .
    """

}

/*
process multiqc_star {

    publishDir "${params.outdir}/multiqc_star/", mode: 'copy'

    conda '/hpcnfs/scratch/ED/davini/analysis/rna_seq_snake/.snakemake/conda/c1dcc088ef1e78c31efe662353cdee8f'

    input:
    path '*'

    output:
    path 'multiqc_report.html'

    script:
    """
    multiqc .
    """

}

*/

