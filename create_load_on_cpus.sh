#!/bin/sh

if [ ! -z "${1}" ]; then
	perl -e 'while (--$ARGV[0] and fork) {}; while () {}' "${1}"
fi
