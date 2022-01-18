#!/usr/bin/env cwl-runner

class: CommandLineTool
id: bcftools-reheader-change-sample-names
label: bcftools-reheader-change-sample-names
cwlVersion: v1.1

$namespaces:
  edam: http://edamontology.org/

requirements:
  DockerRequirement:
    dockerPull: biocontainers/bcftools:v1.9-1-deb_cv1
    
baseCommand: [ bcftools, reheader ]

inputs:
  vcf:
    type: File
    doc: A VCF file containing variants
    secondaryFiles:
      - .tbi
    inputBinding:
      position: 3

  samples:
    type: File
    doc: A file containing sample name per line
    inputBinding:
      prefix: --samples
      position: 1

  outprefix:
    type: string

outputs:
  - id: out_vcf
    type: File
    format: edam:format_3016
    outputBinding:
      glob: $(inputs.outprefix).vcf.gz

arguments:
  - position: 2
    prefix: -o 
    valueFrom: $(inputs.outprefix).vcf.gz


