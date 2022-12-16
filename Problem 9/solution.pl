#!/usr/bin/perl

use Switch;
use warnings; use strict;
use Data::Dumper;

use List::Util qw/sum/;

open my $fh, "input.txt";


my @rope = (100) x 20;

my @mapseg1 = (0) x (200*200);

my @mapseg9 = (0) x (200*200);


# Takes in next element of file and runs move head X number of times on a specifc direction
sub process_instruction(){
    my ($dir, $dist) = split(' ',$_);
    for (1..$dist){
        move_head($dir)
    }

}

# Returns -1 if x < y, 0 if x=y and 1 if x > y


sub less_eq_great{
    my ($x,$y) = @_;

    if ($x < $y){
        return(-1);
    }
    if ($x == $y){
        return(0);
    }
    if ($x > $y){
        return(1);
    }
}

# Moves head according to the specifc direction
sub move_head(){
    switch($_[0]) {
    case 'R' {$rope[0] += 1}
    case 'L' {$rope[0] -= 1}
    case 'U' {$rope[1] += 1}
    case 'D' {$rope[1] -= 1}
}
    update_tail();
}


# Updates the segments after the head
sub update_tail(){
    for my $n (1...$#rope/2){
        ($rope[$n*2],$rope[$n*2+1])  = update_next_knot(@rope[$n*2-2..$n*2+1]);
    }
    @mapseg1[$rope[2]*200 + $rope[3]] = 1;
    @mapseg9[$rope[18]*200 + $rope[19]] = 1;
#     print(@tailvisted)
}



# Takes four values, knot ones x and y, and knots two x and y
# Returns the new values of knot two
sub update_next_knot{
    my ($headx,$heady,$tailx,$taily) = @_;
    my $temp;


    # We only move one of these two conditions are met
    if ((abs ($headx - $tailx) >= 2) | (abs ($heady - $taily) >= 2) ){
        $tailx += less_eq_great($headx,$tailx);
        $taily += less_eq_great($heady,$taily);
    }

    return($tailx,$taily);
}


my $iter_sum1 = 0;

my $iter_sum9 = 0;


my $each = 0;



while(<$fh>){
    process_instruction();
}

for my $each (@mapseg1) {
    if(defined $each){
        $iter_sum1 += $each;
}
}



for my $each (@mapseg9) {
    if(defined $each){
#         print('#');
        $iter_sum9 += $each;
    }
    else{
#         print('.');
    }
}


print ("$iter_sum1\n$iter_sum9\n");

close;
