#!/usr/bin/env cwl-runner

class: CommandLineTool
id: bcftools-query-f
label: bcftools-query-f
cwlVersion: v1.1

$namespaces:
  edam: http://edamontology.org/

requirements:
  DockerRequirement:
    dockerPull: biocontainers/bcftools:v1.9-1-deb_cv1
    
baseCommand: [ bcftools, query ]

inputs:
  vcf:
    type: File
    doc: A VCF file containing variants
    secondaryFiles:
      - .tbi
    inputBinding:
      position: 3

  format:
    type: string
    inputBinding: 
      position: 1
      prefix: -f

  outprefix:
    type: string

outputs:
  - id: sample_list
    type: stdout

stdout: $(inputs.outprefix).txt





