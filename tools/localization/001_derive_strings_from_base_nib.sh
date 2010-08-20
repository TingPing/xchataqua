#!/bin/bash
PWD=`pwd`
BASELOCALE='en'
WORKDIR="../../Localization/$BASELOCALE.lproj"
PWDDIR="$PWD/lproj/$BASELOCALE"

mkdir -p $PWDDIR
cd $WORKDIR
for xib in `ls *.xib`; do
	if [ $PWDDIR/$xib.strings -nt $xib ]; then
		continue # pass if old one
	fi
	cmd="ibtool --generate-stringsfile $xib.strings.utf16 $xib"
	cmd2="iconv -f utf-16 -t utf-8 $xib.strings.utf16"
	if [ $DEBUG ]; then
	  echo "$cmd ; $cmd2"
	fi
	$cmd
	$cmd2 > $PWDDIR/$xib.strings
	rm $xib.strings.utf16 # remove temporary utf16 file
	echo -n .
done
echo ""
