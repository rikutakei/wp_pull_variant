#!/bin/bash

# Script to pull out a variant from a VCF, given a chromosome number, position,
# file to extract the variant from, and the output file name (WITHOUT the file
# extension).
#
# E.g: ./pull_variant.sh <chr> <pos> <path-to-vcf> <output-file-name>
#
# This script will automatically convert the variant vcf file to plink
# bed/bim/fam file format.

# Some regex for checking the correct input format:
chr='^[0-9]?[0-9]$'
pos='^[0-9]+$'

# Some "Dummy" checks:
if [[ $1 -ge 22 ]]
then
	echo
	echo You didn\'t give me a valid Chromosome number, you dummy!
	echo
	echo Chromosome number should be 1~22!
	echo
	exit 1
fi

if ! [[ $1 =~ $chr ]]
then
	echo
	echo You didn\'t give me a valid Chromosome number, you dummy!
	echo
	echo This is how you\'re supposed to use this script:
	echo
	echo ./pull_variant.sh \<chr\> \<pos\> \<output-file-name\>
	echo
	exit 1
fi

if ! [[ $2 =~ $pos ]]
then
	echo
	echo You didn\'t give me a valid Position, you dummy!
	echo
	echo This is how you\'re supposed to use this script:
	echo
	echo ./pull_variant.sh \<chr\> \<pos\> \<output-file-name\>
	echo
	exit 1
fi

if [ -z "$3" ]
then
	echo
	echo You didn\'t give me an ouput file name, you dummy!
	echo
	echo This is how you\'re supposed to use this script:
	echo
	echo ./pull_variant.sh \<chr\> \<pos\> \<output-file-name\>
	echo
	exit 1
fi

# Post-Dummy test:
echo
echo Hi there, this is a script to pull out a variant from the Samoan reference
echo panel imputed West Polynesian VCF file.
echo
echo You\'ve decided to pull out a variant at:
echo Chromosome: $1
echo Position: $2
echo
echo
echo Following programs will be used to pull out the variants:
echo
echo `plink2 --version`
echo `tabix --version | head -1`
echo
echo
echo These are the specific commands used to get your variant:
echo
echo "tabix -h /Volumes/userdata/staff_groups/merrimanlab/Merriman_Documents/Riku/west_poly_imp/chr${1}.dose_qc.vcf.gz $1:$2-$2 > $3.vcf.gz"
echo plink2 --vcf $3.vcf.gz --recode --out $3
echo rm $3.vcf.gz $3.log $3.nosex
echo

tabix -fh /Volumes/userdata/staff_groups/merrimanlab/Merriman_Documents/Riku/west_poly_imp/chr${1}.dose_qc.vcf.gz $1:$2-$2 > $3.vcf.gz
plink2 --vcf $3.vcf.gz --recode --out $3 --silent
rm $3.vcf.gz $3.log $3.nosex

echo
echo The output is saved as $3.ped and $3.map.
echo
echo Thank you for using this script, and I hope you find something interesting :\)
echo

