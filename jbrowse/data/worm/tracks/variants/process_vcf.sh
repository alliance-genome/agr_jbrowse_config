#!/bin/sh

rm -f VCF_*
wget  http://download.alliancegenome.org/2.3.0/VCF/WBcel235/VCF_WBcel235_11.vcf
bgzip -c VCF_WBcel235_11.vcf > VCF_WBcel235_11.vcf.gz
tabix -p vcf VCF_WBcel235_11.vcf.gz
