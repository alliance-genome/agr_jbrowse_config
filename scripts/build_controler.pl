#!/usr/bin/perl
use strict;
use warnings;

use Getopt::Long;
use FindBin qw($Bin);

my ($AWS, $BUCKET, $NOTCOMPRESSED, $CORS,$CREATE,
    $SKIPSEQ, $AWSACCESS, $AWSSECRET, $RELEASE);

GetOptions(
    'aws=s'         => \$AWS,
    'bucket=s'      => \$BUCKET,
    'notcompressed' => \$NOTCOMPRESSED,
    'cors'          => \$CORS,
    'create'        => \$CREATE,
    'skipseq'       => \$SKIPSEQ,
    'awsaccess=s'   => \$AWSACCESS,
    'awssecret=s'   => \$AWSSECRET,
    'release=s'     => \$RELEASE
) or ( system( 'pod2text', $0 ), exit -1 );

$AWS    ||= '/usr/local/bin/aws';
$BUCKET ||= 'agrjbrowse';
$RELEASE or die 'need to supply --release version';

($AWSACCESS && $AWSSECRET) or warn 'without --awsaccess and --awssecret keys, upload will fail.\n';

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
$species{'fly'}{'gff'}       = 'fly.gff';
$species{'zebrafish'}{'gff'} = 'zebrafish.gff';
$species{'mouse'}{'gff'}     = 'mouse.gff';
$species{'rat'}{'gff'}       = 'rat.gff';
$species{'human'}{'gff'}     = 'human.gff';
              

# run flatfile to json
for my $key (keys %species) {
    warn "running ff2j on $key\n"; 

    #super hacky: 
    # This is a way to make really big mammalian GFF files
    # split into two files:
    # One where the chromosome starts with "1" (ie, 1, 10, 11...)
    # and one with all the rest (2,3,20,X...)
    system("grep -P '^1' $species{$key}{'gff'} > some.gff" );
    system("grep -vP '^1' $species{$key}{'gff'} > rest.gff" );

    my $ff_command = "bin/flatfile-to-json.pl bin/flatfile-to-json.pl --compress --gff some.gff --out data/$key --type gene,ncRNA_gene,pseudogene,rRNA_gene,snRNA_gene,snoRNA_gene,tRNA_gene,telomerase_RNA_gene,transposable_element_gene --trackLabel \"All Genes\"  --trackType CanvasFeatures --key \"All Genes\" --maxLookback 100000";
    # for non-vertebrates, some.gff won't exist
    if (-e 'some.gff') {system($ff_command) == 0 or warn "$ff_command failed";}

    $ff_command = "bin/flatfile-to-json.pl bin/flatfile-to-json.pl --compress --gff rest.gff --out data/$key --type gene,ncRNA_gene,pseudogene,rRNA_gene,snRNA_gene,snoRNA_gene,tRNA_gene,telomerase_RNA_gene,transposable_element_gene --trackLabel \"All Genes\"  --trackType CanvasFeatures --key \"All Genes\" --maxLookback 100000";
    system($ff_command) == 0 or warn "$ff_command failed";
}

unlink 'some.gff' if -e 'some.gff';
unlink 'rest.gff';

# run generate names
for my $key (keys %species) {
    warn "running gen names on $key\n";
    my $gn_command = "bin/generate-names.pl --compress --out data/$key";
    system($gn_command) == 0 or warn "$gn_command failed";
}


# upload to s3
my $remote_path_const = "s3://$BUCKET/docker/$RELEASE";
warn $remote_path_const;

for my $key (keys %species) {
    my $local_path = "data/$key";
    my $command = "$Bin/upload_to_S3.pl --awsaccess $AWSACCESS --awssecret $AWSSECRET --local $local_path --remote $remote_path_const/$species{$key}{'remote_path'} --bucket agrjbrowse --skipseq";
    system($command) == 0 or warn "$command failed";
}

exit(0);
