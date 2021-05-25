#!/bin/bash

WORMVCF="4.0.0/worm-latest.vcf.gz"
ZEBRAFISHVCF="4.0.0/zebrafish-latest.vcf.gz"
FLYVCF="4.0.0/fly-latest.vcf.gz"
MOUSEVCF="4.0.0/mouse-latest.vcf.gz"
RATVCF="4.0.0/rat-latest.vcf.gz"

HTPWORMVCF="HTPOSTVEPVCF_WB_latest.vcf.gz"
HTPZEBRAFISHVCF="HTPOSTVEPVCF_ZFIN_latest.vcf.gz"
HTPFLYVCF="HTPOSTVEPVCF_FB_latest.vcf.gz"
HTPMOUSEVCF="HTPOSTVEPVCF_MGI_latest.vcf.gz"
HTPRATVCF="HTPOSTVEPVCF_RGD_latest.vcf.gz"
HTPYEASTVCF="HTPOSTVEPVCF_SGD_latest.vcf.gz"

HTPWORMVCFPATH="4.1.0/HTPOSTVEPVCF_WB_latest.vcf.gz"
HTPZEBRAFISHVCFPATH="4.1.0/HTPOSTVEPVCF_ZFIN_latest.vcf.gz"
HTPFLYVCFPATH="4.1.0/HTPOSTVEPVCF_FB_latest.vcf.gz"
HTPMOUSEVCFPATH="4.1.0/HTPOSTVEPVCF_MGI_latest.vcf.gz"
HTPRATVCFPATH="4.1.0/HTPOSTVEPVCF_RGD_latest.vcf.gz"
HTPYEASTVCFPATH="4.1.0/HTPOSTVEPVCF_SGD_latest.vcf.gz"

rm -rf ../apollo/data/worm/jbrowse
mkdir ../apollo/data/worm/jbrowse
rm -rf ../apollo/data/zebrafish/jbrowse
mkdir  ../apollo/data/zebrafish/jbrowse
rm -rf ../apollo/data/fly/jbrowse
mkdir  ../apollo/data/fly/jbrowse
mkdir  ../apollo/data/MGI/jbrowse
rm -rf ../apollo/data/RGD/jbrowse
mkdir  ../apollo/data/RGD/jbrowse
rm -rf ../apollo/data/yeast/jbrowse
mkdir  ../apollo/data/yeast/jbrowse

wget -O ../apollo/data/worm/jbrowse/VCF_WBcel235_latest.vcf.gz https://s3.amazonaws.com/agrjbrowse/VCF/$WORMVCF
wget -O ../apollo/data/worm/jbrowse/VCF_WBcel235_latest.vcf.gz.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$WORMVCF.tbi
wget -O ../apollo/data/worm/jbrowse/$HTPWORMVCF https://s3.amazonaws.com/agrjbrowse/VCF/$HTPWORMVCFPATH
wget -O ../apollo/data/worm/jbrowse/$HTPWORMVCF.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$HTPWORMVCFPATH.tbi

wget -O ../apollo/data/zebrafish/jbrowse/VCF_GRCz11_latest.vcf.gz https://s3.amazonaws.com/agrjbrowse/VCF/$ZEBRAFISHVCF
wget -O ../apollo/data/zebrafish/jbrowse/VCF_GRCz11_latest.vcf.gz.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$ZEBRAFISHVCF.tbi
wget -O ../apollo/data/zebrafish/jbrowse/$HTPZEBRAFISHVCF https://s3.amazonaws.com/agrjbrowse/VCF/$HTPZEBRAFISHVCFPATH
wget -O ../apollo/data/zebrafish/jbrowse/$HTPZEBRAFISHVCF.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$HTPZEBRAFISHVCFPATH.tbi

wget -O ../apollo/data/fly/jbrowse/VCF_R6_latest.vcf.gz https://s3.amazonaws.com/agrjbrowse/VCF/$FLYVCF
wget -O ../apollo/data/fly/jbrowse/VCF_R6_latest.vcf.gz.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$FLYVCF.tbi
wget -O ../apollo/data/fly/jbrowse/$HTPFLYVCF https://s3.amazonaws.com/agrjbrowse/VCF/$HTPFLYVCFPATH
wget -O ../apollo/data/fly/jbrowse/$HTPFLYVCF.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$HTPFLYVCFPATH.tbi

wget -O ../apollo/data/MGI/jbrowse/VCF_GRCm38_latest.vcf.gz https://s3.amazonaws.com/agrjbrowse/VCF/$MOUSEVCF
wget -O ../apollo/data/MGI/jbrowse/VCF_GRCm38_latest.vcf.gz.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$MOUSEVCF.tbi
wget -O ../apollo/data/MGI/jbrowse/$HTPMOUSEVCF https://s3.amazonaws.com/agrjbrowse/VCF/$HTPMOUSEVCFPATH
wget -O ../apollo/data/MGI/jbrowse/$HTPMOUSEVCF.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$HTPMOUSEVCFPATH.tbi

wget -O ../apollo/data/RGD/jbrowse/VCF_Rnor60_latest.vcf.gz https://s3.amazonaws.com/agrjbrowse/VCF/$RATVCF
wget -O ../apollo/data/RGD/jbrowse/VCF_Rnor60_latest.vcf.gz.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$RATVCF.tbi
wget -O ../apollo/data/RGD/jbrowse/$HTPRATVCF https://s3.amazonaws.com/agrjbrowse/VCF/$HTPRATVCFPATH
wget -O ../apollo/data/RGD/jbrowse/$HTPRATVCF.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$HTPRATVCFPATH.tbi

wget -O ../apollo/data/yeast/jbrowse/$HTPYEASTVCF https://s3.amazonaws.com/agrjbrowse/VCF/$HTPYEASTVCFPATH
wget -O ../apollo/data/yeast/jbrowse/$HTPYEASTVCF.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$HTPYEASTVCFPATH.tbi


