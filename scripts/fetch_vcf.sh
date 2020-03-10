#!/bin/bash

WORMVCF="VCF_WBcel235_68.vcf.gz"
ZEBRAFISHVCF="VCF_GRCz11_68.vcf.gz"
FLYVCF="VCF_R6_68.vcf.gz"
MOUSEVCF="VCF_GRCm38_68.vcf.gz"
RATVCF="VCF_Rnor60_56.vcf.gz"

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

wget -P ../apollo/data/worm/jbrowse/ https://s3.amazonaws.com/agrjbrowse/VCF/$WORMVCF
wget -P ../apollo/data/worm/jbrowse/ https://s3.amazonaws.com/agrjbrowse/VCF/$WORMVCF.tbi

wget -P ../apollo/data/zebrafish/jbrowse/ https://s3.amazonaws.com/agrjbrowse/VCF/$ZEBRAFISHVCF
wget -P ../apollo/data/zebrafish/jbrowse/ https://s3.amazonaws.com/agrjbrowse/VCF/$ZEBRAFISHVCF.tbi

wget -P ../apollo/data/fly/jbrowse/ https://s3.amazonaws.com/agrjbrowse/VCF/$FLYVCF
wget -P ../apollo/data/fly/jbrowse/ https://s3.amazonaws.com/agrjbrowse/VCF/$FLYVCF.tbi

wget -P ../apollo/data/MGI/jbrowse/ https://s3.amazonaws.com/agrjbrowse/VCF/$MOUSEVCF
wget -P ../apollo/data/MGI/jbrowse/ https://s3.amazonaws.com/agrjbrowse/VCF/$MOUSEVCF.tbi

wget -P ../apollo/data/RGD/jbrowse/ https://s3.amazonaws.com/agrjbrowse/VCF/$RATVCF
wget -P ../apollo/data/RGD/jbrowse/ https://s3.amazonaws.com/agrjbrowse/VCF/$RATVCF.tbi

