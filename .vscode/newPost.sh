#!/bin/bash

# get Paramter:
while getopts t: FLAG
do
	case "${FLAG}" in 
		t) TITLE=${OPTARG};;
		*) ERROR=true;;
	esac
done

if [ $ERROR ]
then    
	echo 'Error: invalid arguments!'
	echo 'Syntax:'
	echo "$0 -t <PostTitle>"
	exit 5
fi

if [ -z "${TITLE}" ]
then
	TITLE="untitled"
fi

BASEPATH="./_posts/"
PATTERN="[^0-9a-zA-ZäöüÄÖÜ_]"
FILEDATE=$(date  +"%Y-%m-%d")
POSTDATE=$(date  +"%Y-%m-%d %H:%M:%S %z")

CLEANTITLE=${TITLE//${PATTERN}/"-"}

FULLPATH="${BASEPATH}/${FILEDATE}-$CLEANTITLE.md"

if [ -f "${FULLPATH}" ]
then
	echo 'Error: post already exists with that title!'
	exit 10
else
	touch "${FULLPATH}"
fi

if [  -f "${FULLPATH}" ]
then
	cat >"${FULLPATH}" <<-EOF
	---
	layout:     post
	title:      "${TITLE}"
	date:       ${POSTDATE}
	categories: 
	tags:       
	published:  false
	---
	EOF
else
	echo 'Error: cannot create post.'
	exit 11
fi