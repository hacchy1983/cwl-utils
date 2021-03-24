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
      position: 3

  output_type:
    type: string
    default: z
    inputBinding:
      prefix: --output-type
      position: 1

  outprefix:
    type: string

  regions:
    type: string
    inputBinding:
      prefix: --regions
      position: 2

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


