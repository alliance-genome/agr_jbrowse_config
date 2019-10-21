grep -P "^\#" GRCm38-2.2.0.vcf > header.tmp; sort header.tmp > headersorted.tmp; grep -vP "^\#" GRCm38-2.2.0.vcf > vcf.tmp; sort -k1,1 -k2,2n vcf.tmp > sorted.tmp; cat headersorted.tmp sorted.tmp > GRCm38-2.2.0.sorted.vcf

grep -P "^\#" GRCz11-2.2.0.vcf > header.tmp; sort header.tmp > headersorted.tmp; grep -vP "^\#" GRCz11-2.2.0.vcf > vcf.tmp; sort -k1,1 -k2,2n vcf.tmp > sorted.tmp; cat headersorted.tmp sorted.tmp > GRCz11-2.2.0.sorted.vcf
grep -P "^\#" R6.27-2.2.0.vcf > header.tmp; sort header.tmp > headersorted.tmp; grep -vP "^\#" R6.27-2.2.0.vcf > vcf.tmp; sort -k1,1 -k2,2n vcf.tmp > sorted.tmp; cat headersorted.tmp sorted.tmp > R6.27-2.2.0.sorted.vcf
grep -P "^\#" Rnor_6.0-2.2.0.vcf > header.tmp; sort header.tmp > headersorted.tmp; grep -vP "^\#" Rnor_6.0-2.2.0.vcf > vcf.tmp; sort -k1,1 -k2,2n vcf.tmp > sorted.tmp; cat headersorted.tmp sorted.tmp > Rnor_6.0-2.2.0.sorted.vcf
grep -P "^\#" WBcel235-2.2.0.vcf > header.tmp; sort header.tmp > headersorted.tmp; grep -vP "^\#" WBcel235-2.2.0.vcf > vcf.tmp; sort -k1,1 -k2,2n vcf.tmp > sorted.tmp; cat headersorted.tmp sorted.tmp > WBcel235-2.2.0.sorted.vcf

rm *.tmp
