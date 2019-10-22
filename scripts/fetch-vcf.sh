#!/bin/sh 

#https://fms.alliancegenome.org/api/datafile/by/VCF?latest=true


cd ../jbrowse/data/worm/tracks/variants && rm -f VCF_* && curl http://download.alliancegenome.org/2.3.0/VCF/WBcel235/VCF_WBcel235_16.vcf -o VCF_latest.vcf && bgzip VCF_latest.vcf && tabix VCF_latest.vcf.gz && cd ../../../../../scripts/
cd ../jbrowse/data/fish/tracks/variants && rm -f VCF_* && curl http://download.alliancegenome.org/2.3.0/VCF/GRCz11/VCF_GRCz11_18.vcf -o VCF_latest.vcf && bgzip VCF_latest.vcf && tabix VCF_latest.vcf.gz && cd ../../../../../scripts/
cd ../jbrowse/data/MGI/tracks/variants && rm -f VCF_* && curl http://download.alliancegenome.org/2.3.0/VCF/GRCm38/VCF_GRCm38_17.vcf -o VCF_latest.vcf && bgzip VCF_latest.vcf && tabix VCF_latest.vcf.gz && cd ../../../../../scripts/
cd ../jbrowse/data/RGD/tracks/variants && rm -f VCF_* && curl http://download.alliancegenome.org/2.3.0/VCF/Rnor60/VCF_Rnor60_16.vcf -o VCF_latest.vcf && bgzip VCF_latest.vcf && tabix VCF_latest.vcf.gz && cd ../../../../../scripts/
cd ../jbrowse/data/fly/tracks/variants && rm -f VCF_* && curl http://download.alliancegenome.org/2.3.0/VCF/R6/VCF_R6_16.vcf -o VCF_latest.vcf && bgzip VCF_latest.vcf && tabix VCF_latest.vcf.gz && cd ../../../../../scripts/
