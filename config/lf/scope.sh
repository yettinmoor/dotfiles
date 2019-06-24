#!/bin/sh
# Preview script for lf, adapted from ranger's scope.sh.

set -C -f -u
IFS='\n'

# Handle extension.
case "${1##*.}" in
	# Archive
	a|ace|alz|arc|arj|bz|bz2|cab|cbz|cbr|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
	rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)
		atool --list -- "$1"
		exit 0 ;;
	rar)
		# Avoid password prompt by providing empty password
		unrar lt -p- -- "$1"
		exit 0 ;;
	7z)
		# Avoid password prompt by providing empty password
		7z l -p -- "$1"
		exit 0 ;;

	# PDF
	pdf)
		# Preview as text conversion
		pdftotext -l 10 -nopgbrk -q -- "$1" -
		exit 0 ;;

	# BitTorrent
	torrent)
		transmission-show -- "$1"
		exit 0 ;;

	# Word doc
	docx)
		# Preview as text conversion
		docx2txt "$1"
		exit 0 ;;

	# OpenDocument
	odt|ods|odp|sxw)
		# Preview as text conversion
		odt2txt "$1"
		exit 0 ;;

	# HTML
	htm|html|xhtml)
		# Preview as text conversion
		w3m -dump "$1"
		exit 0 ;;
esac

# Handle mimetype.
case "$( file -b --mime-type -- "$1" | tr '[:upper:]' '[:lower:]' )" in
	# Text
	text/*|*/xml)
		highlight -t 4 -O ansi -- "$1" || cat -- "$1"
		exit 0 ;;
	# Image
	image/*)
		# Preview as text conversion
		# img2txt --gamma=0.6 -- "$1" && exit 0
		exiftool "$1"
		exit 0 ;;
	# Video and audio
	video/*|audio/*)
		mediainfo "$1"
		exit 0 ;;
esac

[ -x "$1" ] && echo "Binary file." && exit 0

echo "No preview available." && exit 1
