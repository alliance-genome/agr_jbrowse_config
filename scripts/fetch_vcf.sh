#!/bin/bash

WORMVCF="3.1.0/VCF_WBcel235_56.vcf.gz"
ZEBRAFISHVCF="3.1.0/VCF_GRCz11_56.vcf.gz"
FLYVCF="3.1.0/VCF_R6_56.vcf.gz"
MOUSEVCF="3.1.0/VCF_GRCm38_56.vcf.gz"
RATVCF="3.1.0/VCF_Rnor60_38.vcf.gz"

rm -rf ../apollo/data/worm/jbrowse
mkdir ../apollo/data/worm/jbrowse
rm -rf ../apollo/data/zebrafish/jbrowse
mkdir  ../apollo/data/zebrafish/jbrowse
rm -rf ../apollo/data/fly/jbrowse
mkdir  ../apollo/data/fly/jbrowse
rm -rf ../apollo/data/MGI/jbrowse
mkdir  ../apollo/data/MGI/jbrowse
rm -rf ../apollo/data/RGD/jbrowse
mkdir  ../apollo/data/RGD/jbrowse

wget -O ../apollo/data/worm/jbrowse/VCF_WBcel235_latest.vcf.gz https://s3.amazonaws.com/agrjbrowse/VCF/$WORMVCF
wget -O ../apollo/data/worm/jbrowse/VCF_WBcel235_latest.vcf.gz.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$WORMVCF.tbi

wget -O ../apollo/data/zebrafish/jbrowse/VCF_GRCz11_latest.vcf.gz https://s3.amazonaws.com/agrjbrowse/VCF/$ZEBRAFISHVCF
wget -O ../apollo/data/zebrafish/jbrowse/VCF_GRCz11_latest.vcf.gz.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$ZEBRAFISHVCF.tbi

wget -O ../apollo/data/fly/jbrowse/VCF_R6_latest.vcf.gz https://s3.amazonaws.com/agrjbrowse/VCF/$FLYVCF
wget -O ../apollo/data/fly/jbrowse/VCF_R6_latest.vcf.gz.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$FLYVCF.tbi

wget -O ../apollo/data/MGI/jbrowse/VCF_GRCm38_latest.vcf.gz https://s3.amazonaws.com/agrjbrowse/VCF/$MOUSEVCF
wget -O ../apollo/data/MGI/jbrowse/VCF_GRCm38_latest.vcf.gz.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$MOUSEVCF.tbi

wget -O ../apollo/data/RGD/jbrowse/VCF_Rnor60_latest.vcf.gz https://s3.amazonaws.com/agrjbrowse/VCF/$RATVCF
wget -O ../apollo/data/RGD/jbrowse/VCF_Rnor60_latest.vcf.gz.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$RATVCF.tbi

