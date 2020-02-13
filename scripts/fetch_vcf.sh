#!/bin/bash

WORMVCF="VCF_WBcel235_20.vcf.gz"
FLYVCF="VCF_R6_20.vcf.gz"
ZEBRAFISHVCF="VCF_GRCz11_22.vcf.gz" 
MOUSEVCF="VCF_GRCm38_21.vcf.gz"
RATVCF="VCF_Rnor60_19.vcf.gz"

rm -rf ../jbrowse/data/worm/jbrowse
mkdir ../jbrowse/data/worm/jbrowse
rm -rf ../jbrowse/data/zebrafish/jbrowse
mkdir  ../jbrowse/data/zebrafish/jbrowse
rm -rf ../jbrowse/data/fly/jbrowse
mkdir  ../jbrowse/data/fly/jbrowse
rm -rf ../jbrowse/data/MGI/jbrowse
mkdir  ../jbrowse/data/MGI/jbrowse
rm -rf ../jbrowse/data/RGD/jbrowse
mkdir  ../jbrowse/data/RGD/jbrowse

wget -P ../jbrowse/data/worm/jbrowse/ https://s3.amazonaws.com/agrjbrowse/VCF/$WORMVCF
wget -P ../jbrowse/data/worm/jbrowse/ https://s3.amazonaws.com/agrjbrowse/VCF/$WORMVCF.tbi

wget -P ../jbrowse/data/zebrafish/jbrowse/ https://s3.amazonaws.com/agrjbrowse/VCF/$ZEBRAFISHVCF
wget -P ../jbrowse/data/zebrafish/jbrowse/ https://s3.amazonaws.com/agrjbrowse/VCF/$ZEBRAFISHVCF.tbi

wget -P ../jbrowse/data/fly/jbrowse/ https://s3.amazonaws.com/agrjbrowse/VCF/$FLYVCF
wget -P ../jbrowse/data/fly/jbrowse/ https://s3.amazonaws.com/agrjbrowse/VCF/$FLYVCF.tbi

wget -P ../jbrowse/data/MGI/jbrowse/ https://s3.amazonaws.com/agrjbrowse/VCF/$MOUSEVCF
wget -P ../jbrowse/data/MGI/jbrowse/ https://s3.amazonaws.com/agrjbrowse/VCF/$MOUSEVCF.tbi

wget -P ../jbrowse/data/RGD/jbrowse/ https://s3.amazonaws.com/agrjbrowse/VCF/$RATVCF
wget -P ../jbrowse/data/RGD/jbrowse/ https://s3.amazonaws.com/agrjbrowse/VCF/$RATVCF.tbi

