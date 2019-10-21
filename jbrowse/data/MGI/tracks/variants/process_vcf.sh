#!/bin/sh

rm -f VCF_*
wget  http://download.alliancegenome.org/2.3.0/VCF/GRCm38/VCF_GRCm38_12.vcf
bgzip -c VCF_GRCm38_12.vcf > VCF_GRCm38_12.vcf.gz
tabix -p vcf VCF_GRCm38_12.vcf.gz
