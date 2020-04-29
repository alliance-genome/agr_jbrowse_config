#!/usr/bin/perl
use strict;
use warnings;

use Getopt::Long;

=head1 NAME

upload_to_S3.pl - Uploads a set of JBrowse track data to an AWS S3 bucket

=head1 SYNOPSYS

  % upload_to_S3.pl --aws <path> --bucket <name> \
                    --local <path> --remote <path> \
                   [--notcompressed]
                   [--cors]
                   [--skipseq]
                   [--profile]

=head1 AUTHOR

Scott Cain E<lt>scott@scottcain.netE<gt>

Copyright (c) 2017

This script is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

#this will take a JBrowse data directory containing tracks/, seq/, and names/
#and upload them to S3 using the aws command line tool.  Note that the keys
#required for accessing S3 on the command line must be stored in ~/.aws/credentials.

# command line input:
#   * path to awscli
#   * name of bucket
#   * path to local track data
#   * path in bucket (make a resonable default?)


###TODO add a noindex option to not create the index.html file and not set website (because it's already been done presumably).

my ($AWS, $BUCKET, $LOCAL, $REMOTE, $NOTCOMPRESSED, $CORS,$CREATE,$PROFILE,$SKIPSEQ);

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

$AWS    ||= '/usr/local/bin/aws';
$BUCKET ||= 'agrjbrowse';
($LOCAL && $REMOTE) or die 'need to supply --local and --remote options';

if ($PROFILE) {
    $AWS = "$AWS --profile $PROFILE ";
}

my $REMOTEPATH = "s3://$BUCKET/$REMOTE";

if ($CREATE) {
    system("$AWS s3 mb s3://$BUCKET");
}

chdir($LOCAL) or die "unable to cd to $LOCAL";

#transfer trackList.json and tracks.conf
system("$AWS s3 cp --acl public-read trackList.json $REMOTEPATH");
system("$AWS s3 cp --acl public-read tracks.conf    $REMOTEPATH");

my $gzip = $NOTCOMPRESSED ? '' : " --content-encoding gzip ";

#transfer tracks
system("$AWS s3 cp $gzip --recursive --acl public-read tracks/ $REMOTEPATH/tracks/");

#transfer names (if compressed, transfer meta separately)
system("$AWS s3 cp $gzip --recursive --acl public-read names/ $REMOTEPATH/names/");
system("$AWS s3 cp --acl public-read names/meta.json $REMOTEPATH/names/meta.json");

#transfer seq
unless ($SKIPSEQ) {
    system("$AWS s3 cp $gzip --recursive --acl public-read seq/ $REMOTEPATH/seq/");
    system("$AWS s3 cp --acl public-read seq/refSeqs.json $REMOTEPATH/seq/refSeqs.json");
}

#create bogus index.html, set website and optionally CORS
open(INDEX, ">", "/tmp/index.html") or die;
while(<DATA>) {
    print INDEX;
}
close INDEX;

system("$AWS s3 cp --acl public-read /tmp/index.html s3://$BUCKET");
system("$AWS s3 website s3://$BUCKET --index-document index.html");

if ($CORS) {
    system("$AWS s3api put-bucket-cors --bucket $BUCKET --cors-configuration '{\"CORSRules\": [{\"AllowedOrigins\": [\"*\"],\"AllowedHeaders\": [\"*\" ],\"AllowedMethods\": [\"GET\"],\"MaxAgeSeconds\": 3000}]}'");
}

#set public read for the entire bucket--prevents 403 errors when requesting a file that isn't there.
system("$AWS s3api put-bucket-acl --grant-read uri=http://acs.amazonaws.com/groups/global/AllUsers --bucket $BUCKET");

print "Transfer complete\n";
exit(0);


__END__
<html>
This is a simple index file to make S3 web serving work.
</html>

