#!/usr/bin/perl
use strict;
use warnings;

use Getopt::Long;

my ($AWS, $BUCKET, $LOCAL, $REMOTE, $NOTCOMPRESSED, $CORS,$CREATE,$PROFILE,
    $SKIPSEQ, $AWSACCESS, $AWSSECRET);

GetOptions(
    'aws=s'         => \$AWS,
    'bucket=s'      => \$BUCKET,
    'local=s'       => \$LOCAL,
    'remote=s'      => \$REMOTE,
    'notcompressed' => \$NOTCOMPRESSED,
    'cors'          => \$CORS,
    'create'        => \$CREATE,
    'profile=s'     => \$PROFILE,
    'skipseq'       => \$SKIPSEQ
) or ( system( 'pod2text', $0 ), exit -1 );


my %species;

$species{'yeast'}{'fullname'}     = 'Saccharomyces cerevisiae';
$species{'worm'}{'fullname'}      = 'Caenorhabditis elegans';           
$species{'fly'}{'fullname'}       = 'Drosophila melanogaster';
$species{'zebrafish'}{'fullname'} = 'Danio rerio';
$species{'mouse'}{'fullname'}     = 'Mus musculus';
$species{'rat'}{'fullname'}       = 'Rattus norvegicus';
$species{'human'}{'fullname'}     = 'Homo sapiens';

$species{'yeast'}{'remote_path'}     = 'SGD/yeast';
$species{'worm'}{'remote_path'}      = 'WormBase/worm';
$species{'fly'}{'remote_path'}       = 'FlyBase/fruitfly';
$species{'zebrafish'}{'remote_path'} = 'zfin/zebrafish';
$species{'mouse'}{'remote_path'}     = 'MGI/mouse';
$species{'rat'}{'remote_path'}       = 'RGD/rat';
$species{'human'}{'remote_path'}     = 'human';

$species{'yeast'}{'gff'}     = 'yeast.gff';
$species{'worm'}{'gff'}      = 'worm.gff';
$species{'fly'}{'gff'}       = 'fruitfly.gff';
$species{'zebrafish'}{'gff'} = 'zebrafish.gff';
$species{'mouse'}{'gff'}     = 'mouse.gff';
$species{'rat'}{'gff'}       = 'rat.gff';
$species{'human'}{'gff'}     = 'human.gff';
              

# run flatfile to json
for my $key (keys %species) {
    my $ff_command = "bin/flatfile-to=json.pl bin/flatfile-to-json.pl --compress --gff $species{$key}{'gff'} --out data/$key --type gene,ncRNA_gene,pseudogene,rRNA_gene,snRNA_gene,snoRNA_gene,tRNA_gene,telomerase_RNA_gene,transposable_element_gene --trackLabel \"All Genes\"  --trackType CanvasFeatures --key \"All Genes\" --maxLookback 1000000";
    system($ff_command) == 0 or die "$ff_command failed";
}


# run generate names
for my $key (keys %species) {
    my $gn_command = "bin/generate-names.pl --compress --out data/$key";
    system($gn_command) == 0 or die "$gn_command failed";
}


# upload to s3
my $remote_path_const = "s3://$BUCKET/docker/$RELEASE/";
