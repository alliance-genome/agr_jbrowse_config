#!/usr/bin/perl
use strict;
use warnings;

use Getopt::Long;

my ($AWS, $BUCKET, $LOCAL, $REMOTE, $PROFILE,$SKIPSEQ);

GetOptions(
    'aws=s'         => \$AWS,
    'bucket=s'      => \$BUCKET,
    'local=s'       => \$LOCAL,
    'remote=s'      => \$REMOTE,
    'profile=s'     => \$PROFILE,
    'skipseq'       => \$SKIPSEQ
) or ( system( 'pod2text', $0 ), exit -1 );

$AWS    ||= '/usr/local/bin/aws';
$BUCKET ||= 'agrjbrowse';
($LOCAL && $REMOTE) or die 'need to supply --local and --remote options';

if ($REMOTE =~ s/\/$//) {
  warn "please leave the trailing slash off the remote path";
}

if ($LOCAL =~ s/\/$//) {
  warn "please leave the trailing slash off the local path";
}


if ($PROFILE) {
    $AWS = "$AWS --profile $PROFILE ";
}

my $REMOTEPATH = "s3://$BUCKET/$REMOTE";

chdir($LOCAL) or die "unable to cd to $LOCAL";

#check tracks
my @localtrack_result = `ls -Rl $LOCAL/tracks |grep -P "^-"|wc -l`;
my @remotetrack_result = `$AWS s3 ls --recursive $REMOTEPATH/tracks |grep -v htaccess|wc -l`;

if ($localtrack_result[0] != $remotetrack_result[0]) {
    warn "WARNING: file count differs between local and remote tracks directories\nLOCAL: $localtrack_result[0]\nREMOTE: $remotetrack_result[0]\n";
}
else {
    warn "all is well in tracks\n";
}

#check names
my @localnames_result = `ls -Rl $LOCAL/names |grep -P "^-"|wc -l`;
my @remotenames_result = `$AWS s3 ls --recursive $REMOTEPATH/names |grep -v htaccess|wc -l`;

if ($localnames_result[0] != $remotenames_result[0]) {
    warn "WARNING: file count differs between local and remote names directories\nLOCAL: $localnames_result[0]\nREMOTE: $remotenames_result[0]\n";
}
else {
    warn "all is well in names\n";
}


exit(0);
