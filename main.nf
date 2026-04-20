#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { RNA_SEQ } from './rna_seq'
include { INFER_STRANDNESS } from './infer_strandness'

workflow {
    if (params.run_strandness) {
        INFER_STRANDNESS()
    } else {
        RNA_SEQ()
    }
}