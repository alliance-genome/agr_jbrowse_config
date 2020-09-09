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

$species{mouse}{vcf}    = "GRCm38_17.vcf";
$species{rat}{vcf}      = "Rnor60_20.vcf";
$species{fly}{vcf}      = "R6_17.vcf";
$species{worm}{vcf}     = "WBcel235_17.vcf";
$species{zebrafish}{vcf}= "GRCz11_17.vcf";

$species{mouse}{assembly}    = "GRCm38";
$species{rat}{assembly}      = "Rnor60";
$species{fly}{assembly}      = "R6";
$species{worm}{assembly}     = "WBcel235";
$species{zebrafish}{assembly}= "GRCz11";

#download the files to local
for my $key (keys %species) {
    my $downloadURL = "https://download.alliancegenome.org/$RELEASE/VCF-GZ/$species{$key}{assembly}/VCF-GZ_$species{$key}{vcf}.gz";
    system("curl -o $species{$key}{vcf}.gz $downloadURL") == 0 or die "$downloadURL failed";

    $downloadURL = "https://download.alliancegenome.org/$RELEASE/VCF-GZ-TBI/$species{$key}{assembly}/VCF-GZ-TBI_$species{$key}{vcf}.gz.tbi";
    system("curl -o $species{$key}{vcf}.gz.tbi $downloadURL") == 0 or die "$downloadURL failed";
}

#put in S3
for my $key (keys %species) {
    my $remote = "s3://$BUCKET/VCF/$RELEASE/$species{$key}{vcf}.gz";
    system("$AWS s3 cp --acl public-read $species{$key}{vcf}.gz $remote") == 0 or warn "upload $remote failed";

    $remote = "s3://$BUCKET/VCF/$RELEASE/$species{$key}{vcf}.gz.tbi";
    system("$AWS s3 cp --acl public-read $species{$key}{vcf}.gz.tbi $remote") == 0 or warn "upload $remote failed";
}

#delete the local copies
for my $key (keys %species) {
    unlink "$species{$key}{vcf}.gz";
    unlink "$species{$key}{vcf}.gz.tbi";
}
