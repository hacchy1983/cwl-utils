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
    
baseCommand: [ bcftools, query, -l ]

inputs:
  vcf:
    type: File
    doc: A VCF file containing variants
    secondaryFiles:
      - .tbi
    inputBinding:
      position: 1

  outprefix:
    type: string

outputs:
  - id: sample_list
    type: stdout

stdout: $(inputs.outprefix).txt



