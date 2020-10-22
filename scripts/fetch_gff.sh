#!/bin/bash

YEASTGFF="3.2.0/GFF/SGD/GFF_SGD_1.gff"
WORMGFF="3.2.0/GFF/WB/GFF_WB_1.gff"
FLYGFF="3.2.0/GFF/FB/GFF_FB_0.gff"
ZEBRAFISHGFF="3.2.0/GFF/ZFIN/GFF_ZFIN_2.gff"
MOUSEGFF="3.2.0/GFF/MGI/GFF_MGI_1.gff"
RATGFF="3.2.0/GFF/RGD/GFF_RGD_3.gff"
HUMANGFF="3.2.0/GFF/HUMAN/GFF_HUMAN_3.gff"

curl -o yeast.gff "https://download.alliancegenome.org/$YEASTGFF"
curl -o worm.gff  "https://download.alliancegenome.org/$WORMGFF"
curl -o fly.gff   "https://download.alliancegenome.org/$FLYGFF"
curl -o zebrafish.gff "https://download.alliancegenome.org/$ZEBRAFISHGFF"
curl -o mouse.gff "https://download.alliancegenome.org/$MOUSEGFF"
curl -o rat.gff   "https://download.alliancegenome.org/$RATGFF"
curl -o human.gff "https://download.alliancegenome.org/$HUMANGFF"
