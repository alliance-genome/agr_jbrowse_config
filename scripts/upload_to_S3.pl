#!/usr/bin/perl
use strict;
use warnings;

use Getopt::Long;

#this will take a JBrowse data directory containing tracks/, seq/, and names/
#and upload them to S3 using the aws command line tool.  Note that the keys
#required for accessing S3 on the command line must be stored in ~/.aws/credentials.

# command line input:
#   * path to awscli
#   * name of bucket
#   * path to local track data
#   * path in bucket (make a resonable default?)

my ($AWS, $BUCKET, $LOCAL, $REMOTE, $NOTCOMPRESSED);

GetOptions(
    'aws=s'      => \$AWS,
    'bucket=s'   => \$BUCKET,
    'local=s'    => \$LOCAL,
    'remote=s'   => \$REMOTE,
    'notcompressed=>\$NOTCOMPRESSED
) or ( system( 'pod2text', $0 ), exit -1 );

my $AWS    ||= '/home/scain/scain/bin/aws';
my $BUCKET ||= 'agrjbrowse';
($LOCAL && $REMOTE) or die 'need to supply --local and --remote options';

my $REMOTEPATH = "s3://$BUCKET/$REMOTE/";


chdir($LOCAL) or die "unable to cd to $LOCAL";

#transfer trackList.json and tracks.conf
system("$AWS s3 cp --acl public-read trackList.json $REMOTEPATH");
system("$AWS s3 cp --acl public-read tracks.conf    $REMOTEPATH");

my $gzip = $NOTCOMPRESSED ? " --content-encoding gzip " : '';

#transfer tracks
system("$AWS s3 cp $gzip --recursive --acl public-read tracks/ $REMOTEPATH/tracks/");

#transfer names (if compressed, transfer meta separately)
system("$AWS s3 cp $gzip --recursive --acl public-read names/ $REMOTEPATH/names/");
system("$AWS s3 cp --acl public-read names/meta.json $REMOTEPATH/names/meta.json");

#transfer seq
system("$AWS s3 cp --recursive --acl public-read seq/ $REMOTEPATH/seq/");

