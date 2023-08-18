#!/bin/bash

WORMVCF="6.0.0/worm-latest.vcf.gz"
ZEBRAFISHVCF="6.0.0/zebrafish-latest.vcf.gz"
FLYVCF="6.0.0/fly-latest.vcf.gz"
MOUSEVCF="6.0.0/mouse-latest.vcf.gz"
RATVCF="6.0.0/rat-latest.vcf.gz"

HTPWORMVCF="HTPOSTVEPVCF_WB_latest.vcf.gz"
HTPZEBRAFISHVCF="HTPOSTVEPVCF_ZFIN_latest.vcf.gz"
HTPFLYVCF="HTPOSTVEPVCF_FB_latest.vcf.gz"
HTPMOUSEVCF="HTPOSTVEPVCF_MGI_latest.vcf.gz"
HTPRATVCF="HTPOSTVEPVCF_RGD_latest.vcf.gz"
HTPYEASTVCF="HTPOSTVEPVCF_SGD_latest.vcf.gz"

HTPWORMVCFPATH="6.0.0/HTPOSTVEPVCF_WB_latest.vcf.gz"
HTPZEBRAFISHVCFPATH="6.0.0/HTPOSTVEPVCF_ZFIN_latest.vcf.gz"
HTPFLYVCFPATH="6.0.0/HTPOSTVEPVCF_FB_latest.vcf.gz"
#HTPMOUSEVCFPATH="5.0.0/HTPOSTVEPVCF_MGI_latest.vcf.gz"
HTPRATVCFPATH="6.0.0/HTPOSTVEPVCF_RGD_latest.vcf.gz"
HTPYEASTVCFPATH="6.0.0/HTPOSTVEPVCF_SGD_latest.vcf.gz"

HUMANDOWNLOADPATH="https://download.alliancegenome.org/variants/HUMAN"
MOUSEDOWNLOADPATH="https://download.alliancegenome.org/variants/MGI"

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
rm -rf ../apollo/data/yeast/jbrowse
mkdir  ../apollo/data/yeast/jbrowse
#rm -rf ../apollo/data/human/jbrowse
#mkdir  ../apollo/data/human/jbrowse

wget -q -O ../apollo/data/worm/jbrowse/VCF_WBcel235_latest.vcf.gz https://s3.amazonaws.com/agrjbrowse/VCF/$WORMVCF
wget -q -O ../apollo/data/worm/jbrowse/VCF_WBcel235_latest.vcf.gz.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$WORMVCF.tbi
wget -q -O ../apollo/data/worm/jbrowse/$HTPWORMVCF https://s3.amazonaws.com/agrjbrowse/VCF/$HTPWORMVCFPATH
wget -q -O ../apollo/data/worm/jbrowse/$HTPWORMVCF.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$HTPWORMVCFPATH.tbi

wget -q -O ../apollo/data/zebrafish/jbrowse/VCF_GRCz11_latest.vcf.gz https://s3.amazonaws.com/agrjbrowse/VCF/$ZEBRAFISHVCF
wget -q -O ../apollo/data/zebrafish/jbrowse/VCF_GRCz11_latest.vcf.gz.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$ZEBRAFISHVCF.tbi
wget -q -O ../apollo/data/zebrafish/jbrowse/$HTPZEBRAFISHVCF https://s3.amazonaws.com/agrjbrowse/VCF/$HTPZEBRAFISHVCFPATH
wget -q -O ../apollo/data/zebrafish/jbrowse/$HTPZEBRAFISHVCF.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$HTPZEBRAFISHVCFPATH.tbi

wget -q -O ../apollo/data/fly/jbrowse/VCF_R6_latest.vcf.gz https://s3.amazonaws.com/agrjbrowse/VCF/$FLYVCF
wget -q -O ../apollo/data/fly/jbrowse/VCF_R6_latest.vcf.gz.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$FLYVCF.tbi
wget -q -O ../apollo/data/fly/jbrowse/$HTPFLYVCF https://s3.amazonaws.com/agrjbrowse/VCF/$HTPFLYVCFPATH
wget -q -O ../apollo/data/fly/jbrowse/$HTPFLYVCF.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$HTPFLYVCFPATH.tbi

wget -q -O ../apollo/data/MGI/jbrowse/VCF_GRCm39_latest.vcf.gz https://s3.amazonaws.com/agrjbrowse/VCF/$MOUSEVCF
wget -q -O ../apollo/data/MGI/jbrowse/VCF_GRCm38_latest.vcf.gz.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$MOUSEVCF.tbi
#need to get the per-chromosome vcfs and update the config
#wget -q -O ../apollo/data/MGI/jbrowse/$HTPMOUSEVCF https://s3.amazonaws.com/agrjbrowse/VCF/$HTPMOUSEVCFPATH
#wget -q -O ../apollo/data/MGI/jbrowse/$HTPMOUSEVCF.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$HTPMOUSEVCFPATH.tbi

wget -q -O ../apollo/data/RGD/jbrowse/VCF_Rnor60_latest.vcf.gz https://s3.amazonaws.com/agrjbrowse/VCF/$RATVCF
wget -q -O ../apollo/data/RGD/jbrowse/VCF_Rnor60_latest.vcf.gz.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$RATVCF.tbi
wget -q -O ../apollo/data/RGD/jbrowse/$HTPRATVCF https://s3.amazonaws.com/agrjbrowse/VCF/$HTPRATVCFPATH
wget -q -O ../apollo/data/RGD/jbrowse/$HTPRATVCF.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$HTPRATVCFPATH.tbi

wget -q -O ../apollo/data/yeast/jbrowse/$HTPYEASTVCF https://s3.amazonaws.com/agrjbrowse/VCF/$HTPYEASTVCFPATH
wget -q -O ../apollo/data/yeast/jbrowse/$HTPYEASTVCF.tbi https://s3.amazonaws.com/agrjbrowse/VCF/$HTPYEASTVCFPATH.tbi

#for CHR in {1..22} ; do
#    wget -q -O "../apollo/data/human/jbrowse/HUMAN.vep.$CHR.vcf.gz"     "$HUMANDOWNLOADPATH/HUMAN.vep.$CHR.vcf.gz"
#    wget -q -O "../apollo/data/human/jbrowse/HUMAN.vep.$CHR.vcf.gz.tbi" "$HUMANDOWNLOADPATH/HUMAN.vep.$CHR.vcf.gz.tbi"
#done
#CHR=MT
#    wget -q -O "../apollo/data/human/jbrowse/HUMAN.vep.$CHR.vcf.gz"     "$HUMANDOWNLOADPATH/HUMAN.vep.$CHR.vcf.gz"
#    wget -q -O "../apollo/data/human/jbrowse/HUMAN.vep.$CHR.vcf.gz.tbi" "$HUMANDOWNLOADPATH/HUMAN.vep.$CHR.vcf.gz.tbi"

#CHR=X
#    wget -q -O "../apollo/data/human/jbrowse/HUMAN.vep.$CHR.vcf.gz"     "$HUMANDOWNLOADPATH/HUMAN.vep.$CHR.vcf.gz"
#    wget -q -O "../apollo/data/human/jbrowse/HUMAN.vep.$CHR.vcf.gz.tbi" "$HUMANDOWNLOADPATH/HUMAN.vep.$CHR.vcf.gz.tbi"

#CHR=Y
#    wget -q -O "../apollo/data/human/jbrowse/HUMAN.vep.$CHR.vcf.gz"     "$HUMANDOWNLOADPATH/HUMAN.vep.$CHR.vcf.gz"
#    wget -q -O "../apollo/data/human/jbrowse/HUMAN.vep.$CHR.vcf.gz.tbi" "$HUMANDOWNLOADPATH/HUMAN.vep.$CHR.vcf.gz.tbi"

#for CHR in {1..19} ; do
#    wget -q -O "../apollo/data/MGI/jbrowse/MOUSE.vep.$CHR.vcf.gz"     "$MOUSEDOWNLOADPATH/MGI.vep.$CHR.vcf.gz"
#    wget -q -O "../apollo/data/MGI/jbrowse/MOUSE.vep.$CHR.vcf.gz.tbi" "$MOUSEDOWNLOADPATH/MGI.vep.$CHR.vcf.gz.tbi"
#done

#CHR=MT
#    wget -q -O "../apollo/data/MGI/jbrowse/MOUSE.vep.$CHR.vcf.gz"     "$MOUSEDOWNLOADPATH/MGI.vep.$CHR.vcf.gz"
#    wget -q -O "../apollo/data/MGI/jbrowse/MOUSE.vep.$CHR.vcf.gz.tbi" "$MOUSEDOWNLOADPATH/MGI.vep.$CHR.vcf.gz.tbi"

#CHR=Y
#    wget -q -O "../apollo/data/MGI/jbrowse/MOUSE.vep.$CHR.vcf.gz"     "$MOUSEDOWNLOADPATH/MGI.vep.$CHR.vcf.gz"
#    wget -q -O "../apollo/data/MGI/jbrowse/MOUSE.vep.$CHR.vcf.gz.tbi" "$MOUSEDOWNLOADPATH/MGI.vep.$CHR.vcf.gz.tbi"

#CHR=X
#    wget -q -O "../apollo/data/MGI/jbrowse/MOUSE.vep.$CHR.vcf.gz"     "$MOUSEDOWNLOADPATH/MGI.vep.$CHR.vcf.gz"
#    wget -q -O "../apollo/data/MGI/jbrowse/MOUSE.vep.$CHR.vcf.gz.tbi" "$MOUSEDOWNLOADPATH/MGI.vep.$CHR.vcf.gz.tbi"
