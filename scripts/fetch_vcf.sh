#!/bin/bash

WORMVCF="4.0.0/worm-latest.vcf.gz"
ZEBRAFISHVCF="4.0.0/zebrafish-latest.vcf.gz"
FLYVCF="4.0.0/fly-latest.vcf.gz"
MOUSEVCF="4.0.0/mouse-latest.vcf.gz"
RATVCF="4.0.0/rat-latest.vcf.gz"

rm -rf ../apollo/data/worm/jbrowse
mkdir ../apollo/data/worm/jbrowse
rm -rf ../apollo/data/zebrafish/jbrowse
mkdir  ../apollo/data/zebrafish/jbrowse
rm -rf ../apollo/data/fly/jbrowse
mkdir  ../apollo/data/fly/jbrowse
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

