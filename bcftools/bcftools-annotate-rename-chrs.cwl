#!/usr/bin/env cwl-runner

class: CommandLineTool
id: bcftools-annotate-rename-chrs
label: bcftools-annotate-rename-chrs
cwlVersion: v1.1

$namespaces:
  edam: http://edamontology.org/

requirements:
  DockerRequirement:
    dockerPull: biocontainers/bcftools:v1.9-1-deb_cv1
    
baseCommand: [ bcftools, annotate ]

inputs:
  rename-chrs:
    type: File
    doc: A mapping file for old and new chromosome names
    inputBinding: 
      position: 1
      prefix: --rename-chrs

  vcf:
    type: File
    doc: A VCF file containing variants
    secondaryFiles:
      - .tbi
    inputBinding:
      position: 3

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
  - position: 3
    prefix: --output-type
    valueFrom: z



