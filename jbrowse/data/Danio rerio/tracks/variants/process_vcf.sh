#!/bin/sh

rm -f VCF_*
wget  http://download.alliancegenome.org/2.3.0/VCF/GRCz11/VCF_GRCz11_13.vcf
bgzip -c VCF_GRCz11_13.vcf > VCF_GRCz11_13.vcf.gz
tabix -p vcf VCF_GRCz11_13.vcf.gz
