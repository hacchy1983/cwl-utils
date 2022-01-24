#!/usr/bin/env cwl-runner

class: CommandLineTool
id: bcftools-view-extract-samples
label: bcftools-view-extract-samples
cwlVersion: v1.1

$namespaces:
  edam: http://edamontology.org/

requirements:
  InlineJavascriptRequirement: {}
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
      position: 5

  outprefix:
    type: string

  samples_file:
    type: File
    doc: A file containing sample IDs to be extracted

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

  - position: 3
    valueFrom: "--force-samples"

  - position: 4
    prefix: --samples-file
    valueFrom: ^$(inputs.samples_file.dirname)/$(inputs.samples_file.basename)