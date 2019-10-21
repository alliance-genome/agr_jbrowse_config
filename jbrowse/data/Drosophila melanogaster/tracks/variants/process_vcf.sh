#!/bin/sh

rm -f VCF_*
wget  http://download.alliancegenome.org/2.3.0/VCF/R6/VCF_R6_11.vcf
bgzip -c VCF_R6_11.vcf > VCF_R6_11.vcf.gz
tabix -p vcf VCF_R6_11.vcf.gz
