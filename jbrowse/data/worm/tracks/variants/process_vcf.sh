#!/bin/sh

rm -f VCF_*
wget  http://download.alliancegenome.org/2.3.0/VCF/WBcel235/VCF_WBcel235_14.vcf -o test.vcf
bgzip -c VCF_WBcel235_14.vcf > VCF_WBcel235_14.vcf.gz
tabix -p vcf VCF_WBcel235_14.vcf.gz
