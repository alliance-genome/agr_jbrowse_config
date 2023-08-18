#!/usr/bin/perl
use strict;
use warnings;

use Getopt::Long;
use File::Find::Rule;
#use URI::Escape;

my ($AWS, $BUCKET, $LOCAL, $REMOTE, $PROFILE,$SKIPFILECOUNT,$SKIPSEQ, $QUIET);

GetOptions(
    'aws=s'         => \$AWS,
    'bucket=s'      => \$BUCKET,
    'local=s'       => \$LOCAL,
    'remote=s'      => \$REMOTE,
    'profile=s'     => \$PROFILE,
    'skipfilecount' => \$SKIPFILECOUNT,
    'skipseq'       => \$SKIPSEQ,
    'quiet'         => \$QUIET
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

#chdir($LOCAL) or die "unable to cd to $LOCAL";

my (@remotetrack_result, @remotenames_result);

unless ($SKIPFILECOUNT) {
#check tracks

    @remotetrack_result = `$AWS s3 ls --recursive $REMOTEPATH/tracks |grep -v htaccess`;
    @remotenames_result = `$AWS s3 ls --recursive $REMOTEPATH/names |grep -v htaccess`;

    my @localtrack_result = `ls -Rl $LOCAL/tracks |grep -P "^-"|wc -l`;
    my $remote_count = scalar @remotetrack_result;
    if ($localtrack_result[0] != $remote_count) {
        print "WARNING: file count differs between local and remote tracks directories\nLOCAL: $localtrack_result[0]\nREMOTE: $remote_count\n";
        die "stopping...";
    }
    else {
        print "File counts agree in tracks.\n" unless $QUIET;
    }

#check names
    my @localnames_result = `ls -Rl $LOCAL/names |grep -P "^-"|wc -l`;

    $remote_count = scalar @remotenames_result;
    if ($localnames_result[0] != $remote_count) {
        print "WARNING: file count differs between local and remote names directories\nLOCAL: $localnames_result[0]\nREMOTE: $remote_count\n";
        die "stopping...";
    }
    else {
        print "File counts agree in names.\n" unless $QUIET;
    }
}

print "starting md5 comparison...\n" unless $QUIET;

#get local file tree
my @localfiles = File::Find::Rule->in("$LOCAL/tracks/");
push @localfiles, File::Find::Rule->in("$LOCAL/names/");
for my $file (@localfiles)  {
    next if $file =~ /htaccess/;
    my ($root, $stem);
    if ($file =~ m{^(.*\Q$LOCAL\E\/)(.*)}) {
        $root = $1;
        $stem = $2;
        if ($stem =~ /(txt|jsonz|json)$/) {
            my $localstem = my $remotestem = $stem;
            $localstem =~ s/ /\\ /g;
            my ($localmd5) = `md5sum $root$localstem`;        
            ($localmd5,undef) = split /\s+/, $localmd5;
            $remotestem =~ s/ /%20/g; 

            my $remotemd5 = get_remote_md5($REMOTE . '/' . $remotestem );
            if ($localmd5 ne $remotemd5) {
                print "$stem didn't match: $localmd5  $remotemd5\n";
                die "stopping...";
            }
        }
        else {
            next;
        }
    }
}

exit(0);


sub get_remote_md5 {
    my $path = shift;

    my $url = "https://s3.amazonaws.com/agrjbrowse/$path";

    #warn $url;

    my @remote_header = `curl -Is $url`;

    my $sum;
    for my $line (@remote_header) {
        if ($line =~ /ETag:\s*"(.*)"/) {
            $sum = $1;
        } 
    }

    die "couldn't get md5 sum for $path\n" unless $sum;

    return $sum;

}
