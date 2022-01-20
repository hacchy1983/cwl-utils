#!/usr/bin/env cwl-runner

class: CommandLineTool
id: gatk4-LiftoverVcf
label: gatk4-LiftoverVcf
cwlVersion: v1.1

$namespaces:
  edam: 'http://edamontology.org/'

requirements:
  DockerRequirement:
    dockerPull: broadinstitute/gatk:4.2.4.1
  ShellCommandRequirement: {}
  
baseCommand: java

inputs:
  vcf:
    type: File
    doc: A VCF file containing variants
    secondaryFiles:
      - .tbi
    inputBinding:
      prefix: --INPUT
      position: 4

  reference:
    type: File
    doc: FastA file for reference genome
    secondaryFiles:
      - .fai
      - ^.dict
    inputBinding:
      prefix: -R
      position: 5

  outprefix:
    type: string

  chain:
    type: File
    doc: A CHAIN file
    inputBinding: 
      prefix: --CHAIN
      position: 6
      

  java_options:
    type: string?
    default: -XX:-UseContainerSupport -Xmx48g -Xms48g
    inputBinding:
      position: 1
      shellQuote: false


    
outputs:
  - id: out_vcf
    type: File
    format: edam:format_3016
    outputBinding:
      glob: $(inputs.outprefix).vcf.gz
    secondaryFiles:
      - .tbi
  - id: reject_vcf
    type: File
    format: edam:format_3016
    outputBinding:
      glob: $(inputs.outprefix).reject.vcf.gz
    secondaryFiles:
      - .tbi
  - id: log
    type: stderr

stderr: $(inputs.outprefix).vcf.gz.log
    
arguments:
  - position: 2
    prefix: -jar
    valueFrom: /gatk/gatk-package-4.2.4.1-local.jar
  - position: 3
    valueFrom: LiftoverVcf
  - position: 7
    prefix: --OUTPUT
    valueFrom: $(inputs.outprefix).vcf.gz
  - position: 8
    prefix: --REJECT
    valueFrom: $(inputs.outprefix).reject.vcf.gz
  - position: 9
    prefix: --CREATE_INDEX
    valueFrom: "true"
    
