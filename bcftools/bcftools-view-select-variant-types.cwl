#!/usr/bin/env cwl-runner

class: CommandLineTool
id: bcftools-view-filter-by-regions
label: bcftools-view-filter-by-regions
cwlVersion: v1.1

$namespaces:
  edam: http://edamontology.org/

requirements:
  DockerRequirement:
    dockerPull: biocontainers/bcftools:v1.9-1-deb_cv1
    
baseCommand: [ bcftools, view ]

inputs:
  vcf:
    type: File
    doc: A VCF file containing variants
    secondaryFiles:
      - .tbi
    inputBinding:
      position: 4

  outprefix:
    type: string

  types:
    type: string
    doc: comma-separated list of variant types [snps|indels|mnps|other] to select. Site is selected if any of the ALT alleles is of the type requested. Types are determined by comparing the REF and ALT alleles in the VCF record not INFO tags like INFO/INDEL or INFO/VT. Use --include to select based on INFO tags.
    inputBinding:
      prefix: --types
      position: 3

outputs:
  - id: out_vcf
    type: File
    format: edam:format_3016
    outputBinding:
      glob: $(inputs.outprefix).vcf.gz

arguments:
  - position: 1
    prefix: --output-type
    valueFrom: z

  - position: 2
    prefix: -o 
    valueFrom: $(inputs.outprefix).vcf.gz


