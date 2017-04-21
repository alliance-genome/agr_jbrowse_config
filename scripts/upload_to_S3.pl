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

my ($AWS, $BUCKET, $LOCAL, $REMOTE, $NOTCOMPRESSED, $CORS);

GetOptions(
    'aws=s'         => \$AWS,
    'bucket=s'      => \$BUCKET,
    'local=s'       => \$LOCAL,
    'remote=s'      => \$REMOTE,
    'notcompressed' => \$NOTCOMPRESSED,
    'cors'          => \$CORS
) or ( system( 'pod2text', $0 ), exit -1 );

$AWS    ||= '/home/scain/scain/bin/aws';
$BUCKET ||= 'agrjbrowse';
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

#create bogus index.html, set website and optionally CORS
open(INDEX, ">", "/tmp/index.html") or die;
while(<DATA>) {
    print;
}
close INDEX;

system("$AWS s3 cp --acl public-read /tmp/index.html s3://$BUCKET");
system("$AWS s3 website s3://$BUCKET --index-document index.html");

if ($CORS) {
    system("$AWS s3api put-bucket-cors --bucket $BUCKET --cors-configuration '{\"CORSRules\": [{\"AllowedOrigins\": [\"*\"],\"AllowedHeaders\": [\"*\" ],\"AllowedMethods\": [\"GET\"],\"MaxAgeSeconds\": 3000}]}'");
}

print "Transfer complete\n";
exit(0);


__END__
<html>
This is a simple index file to make S3 web serving work.
</html>

