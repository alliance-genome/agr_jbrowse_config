#!/usr/bin/perl
use strict;
use warnings;

use Getopt::Long;

my ($AWS, $BUCKET, $RELEASE, $AWSACCESS, $AWSSECRET);

GetOptions(
    'aws=s'         => \$AWS,
    'bucket=s'      => \$BUCKET,
    'awsaccess=s'   => \$AWSACCESS,
    'awssecret=s'   => \$AWSSECRET,
    'release=s'     => \$RELEASE
) or ( system( 'pod2text', $0 ), exit -1 );

$AWS    ||= '/usr/local/bin/aws';

$BUCKET ||= 'agrjbrowse';
$RELEASE or die 'need to supply --release version';

($AWSACCESS && $AWSSECRET) or warn "without --awsaccess and --awssecret keys, upload may fail.\n\n";

my %species;

$species{mouse}{vcf}    = "GRCm38_37.vcf";
$species{rat}{vcf}      = "Rnor60_41.vcf";
$species{fly}{vcf}      = "R6_37.vcf";
$species{worm}{vcf}     = "WBcel235_37.vcf";
$species{zebrafish}{vcf}= "GRCz11_37.vcf";

$species{mouse}{tbi}    = "GRCm38_30.vcf.gz.tbi";
$species{rat}{tbi}      = "Rnor60_30.vcf.gz.tbi";
$species{fly}{tbi}      = "R6_30.vcf.gz.tbi";
$species{worm}{tbi}     = "WBcel235_30.vcf.gz.tbi";
$species{zebrafish}{tbi}= "GRCz11_30.vcf.gz.tbi";

$species{mouse}{assembly}    = "GRCm38";
$species{rat}{assembly}      = "Rnor60";
$species{fly}{assembly}      = "R6";
$species{worm}{assembly}     = "WBcel235";
$species{zebrafish}{assembly}= "GRCz11";

#download the files to local
for my $key (keys %species) {
    my $downloadURL = "https://download.alliancegenome.org/$RELEASE/VCF-GZ/$species{$key}{assembly}/VCF-GZ_$species{$key}{vcf}.gz";
    system("wget -O $key-latest.vcf.gz $downloadURL") == 0 or die "$downloadURL failed";

    $downloadURL = "https://download.alliancegenome.org/$RELEASE/VCF-GZ-TBI/$species{$key}{assembly}/VCF-GZ-TBI_$species{$key}{tbi}";
    system("wget -O $key-latest.vcf.gz.tbi $downloadURL") == 0 or die "$downloadURL failed";
}

#put in S3
for my $key (keys %species) {
    my $remote = "s3://$BUCKET/VCF/$RELEASE/";
    system("$AWS s3 cp --acl public-read $key-latest.vcf.gz $remote") == 0 or warn "upload of $key-latest.vcf.gz to $remote failed";

    system("$AWS s3 cp --acl public-read $key-latest.vcf.gz.tbi $remote") == 0 or warn "upload of $key-latest.vcf.gz.tbi to $remote failed";
}

#delete the local copies
for my $key (keys %species) {
#    unlink "$species{$key}{vcf}.gz";
#    unlink "$species{$key}{vcf}.gz.tbi";
}
