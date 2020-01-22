#!/bin/bash
rm -rf ../jbrowse/data/worm/jbrowse
mkdir ../jbrowse/data/worm/jbrowse
wget -P ../jbrowse/data/worm/jbrowse https://s3.amazonaws.com/agrjbrowse/VCF/VCF_WBcel235_20.vcf.gz
wget -P ../jbrowse/data/worm/jbrowse https://s3.amazonaws.com/agrjbrowse/VCF/VCF_WBcel235_20.vcf.gz.tbi


rm -rf ../jbrowse/data/zebrafish/jbrowse
mkdir  ../jbrowse/data/zebrafish/jbrowse
wget -P ../jbrowse/data/zebrafish/jbrowse https://s3.amazonaws.com/agrjbrowse/VCF/VCF_GRCz11_22.vcf.gz
wget -P ../jbrowse/data/zebrafish/jbrowse https://s3.amazonaws.com/agrjbrowse/VCF/VCF_GRCz11_22.vcf.gz.tbi

rm -rf ../jbrowse/data/fly/jbrowse
mkdir  ../jbrowse/data/fly/jbrowse
wget -P ../jbrowse/data/fly/jbrowse https://s3.amazonaws.com/agrjbrowse/VCF/VCF_R6_20.vcf.gz
wget -P ../jbrowse/data/fly/jbrowse https://s3.amazonaws.com/agrjbrowse/VCF/VCF_R6_20.vcf.gz.tbi

rm -rf ../jbrowse/data/MGI/jbrowse
mkdir  ../jbrowse/data/MGI/jbrowse
wget -P ../jbrowse/data/MGI/jbrowse https://s3.amazonaws.com/agrjbrowse/VCF/VCF_GRCm38_21.vcf.gz
wget -P ../jbrowse/data/MGI/jbrowse https://s3.amazonaws.com/agrjbrowse/VCF/VCF_GRCm38_21.vcf.gz.tbi

rm -rf ../jbrowse/data/RGD/jbrowse
mkdir  ../jbrowse/data/RGD/jbrowse
wget -P ../jbrowse/data/RGD/jbrowse https://s3.amazonaws.com/agrjbrowse/VCF/VCF_Rnor60_19.vcf.gz
wget -P ../jbrowse/data/RGD/jbrowse https://s3.amazonaws.com/agrjbrowse/VCF/VCF_Rnor60_19.vcf.gz.tbi

