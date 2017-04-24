#!/usr/bin/perl
use strict;
use warnings;

use Getopt::Long;
use File::Copy::Recursive qw(fcopy rcopy);
use File::Basename;
use File::Path qw(remove_tree);

=head1 NAME

upload_jbrowse_static.pl - Uploads files to run JBrowse to S3

=head1 SYNOPSYS

  % upload_to_S3.pl --aws <path> --bucket <name> \
                    --local <path> --remote <path> \
                   [--cors] [--create]

=head1 NOTES

Assumes that track data are in the data directory.  If
data/trackList.json doesn't exist, assumes that data are 
in separate directories exactly one level below data/.

To prepare for uploading, the jbrowse directory is copied to 
/tmp and symlinks are replaced with actual files and directories. 
After uploading is done, this temporary copy is deleted. 

=head1 AUTHOR

Scott Cain E<lt>scott@scottcain.netE<gt>

Copyright (c) 2017

This script is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut


my ($AWS, $BUCKET, $LOCAL, $REMOTE, $CREATE);

GetOptions(
    'aws=s'         => \$AWS,
    'bucket=s'      => \$BUCKET,
    'local=s'       => \$LOCAL,
    'remote=s'      => \$REMOTE,
    'create'        => \$CREATE
) or ( system( 'pod2text', $0 ), exit -1 );

$AWS    ||= '/home/scain/scain/bin/aws';
$BUCKET ||= 'agrjbrowsestatic';
$LOCAL  or die 'need to supply --local option';
$REMOTE ||= '';

my $REMOTEPATH = "s3://$BUCKET/$REMOTE";

if ($CREATE) {
    system("$AWS s3 mb s3://$BUCKET");
}

my $tmplocal = "/tmp/jbrowse";

rcopy($LOCAL, $tmplocal);

chdir($tmplocal) or die "unable to cd to $tmplocal";

my @all_files = glob('*');

for my $file (@all_files) {
    replace_symlink($file);
}

#trim out tracks, names and seq (except refSeqs.json)
remove_unwanted_files('data');

#transfer trackList.json and tracks.conf
system("$AWS s3 cp --acl public-read --recursive $tmplocal $REMOTEPATH");


#set website for the bucket--this is the real index.html file for jbrowse
system("$AWS s3 website s3://$BUCKET --index-document index.html");

print "Transfer complete\n";


#unlink($tmplocal);
exit(0);


sub replace_symlink {
    my $file = shift;

    if (-l $file) {
        #warn "replacing a link $file";
        my $path = readlink $file;
        my $filename = fileparse($path);
        unlink $file;
        rcopy($path, $filename);

        replace_symlink($filename);
        return;
    }

    if (-d $file) {
        #warn "directory: $file";
        chdir($file);
        my @files = glob('*');
        for my $subfile (@files) {
            replace_symlink($subfile);
        }
        chdir('..');
        return;
    }

    return if -f $file;

    warn "shouldn't have gotten here: $file";
    return;
}

sub remove_unwanted_files{
    my $dir = shift;

    chdir($dir);

    my @files = glob('*');

    for my $file (@files) {
        remove_tree($file) if ($file eq 'tracks');
        remove_tree($file) if ($file eq 'names');
        if ($file eq 'seq') {
            chdir($file);
            my @seqdirs = glob('[0-f]*');
            for my $sd (@seqdirs) {
                remove_tree($sd) if -d $sd;
                unlink($sd)      if -f $sd;
            }
            chdir('..');
        }
        remove_unwanted_files($file) if -d $file;
    }

    chdir('..'); 
    return;
}

