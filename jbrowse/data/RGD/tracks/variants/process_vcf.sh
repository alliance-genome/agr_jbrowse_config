#!/bin/sh

rm -f VCF_*
wget  http://download.alliancegenome.org/2.3.0/VCF/Rnor60/VCF_Rnor60_11.vcf
bgzip -c VCF_Rnor60_11.vcf > VCF_Rnor60_11.vcf.gz
tabix -p vcf VCF_Rnor60_11.vcf.gz
