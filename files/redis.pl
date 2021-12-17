#!/usr/bin/perl
 use strict;
 use warnings;
 use File::Slurp;
 use JSON::XS;
 use EBox;
 use EBox::Config::Redis;

 EBox::init();
 my @lines;
 my $json_pretty = JSON::XS->new->pretty->utf8;
 my $redis = EBox::Config::Redis->instance(1);

 @lines = split ("\n\n+", read_file(@ARGV[0]));
 $redis->begin();
 foreach my $line (@lines) {
        if ($line =~ m/^\s*$/) {
                next;
        }
        my ($key, $value) = $line =~ /^\s*([^\s]+?): (.*)\s*$/s;
        if ((not defined $key) or (not defined $value)) {
                print "Not defined: $line\n";
                next;
        }
        my $firstChar = substr ($value, 0, 1);
        if (($firstChar eq '[') or ($firstChar eq '{')) {
           $value = $json_pretty->decode($value);
        }
#       print "Line: $line ( $key : $value)\n";
        $redis->set($key, $value);
}
$redis->commit();
