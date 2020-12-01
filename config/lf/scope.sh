#!/bin/sh
# Preview script for lf, adapted from ranger's scope.sh.

set -C -f -u
IFS='\n'
file=$( readlink -f "$1" )

# Handle extension.
case "${1##*.}" in
	# Archive
	a|ace|alz|arc|arj|bz|bz2|cab|cbz|cbr|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
	rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)
		atool --list -- "$file"
		exit 0 ;;
	rar)
		# Avoid password prompt by providing empty password
		unrar lt -p- -- "$file"
		exit 0 ;;
	7z)
		# Avoid password prompt by providing empty password
		7z l -p -- "$file"
		exit 0 ;;

	# PDF
	pdf)
		# Preview as text conversion
		pdftotext -l 10 -nopgbrk -q -- "$file" -
		exit 0 ;;

	# BitTorrent
	torrent)
		transmission-show -- "$file"
		exit 0 ;;

	# Word doc
	docx)
		# Preview as text conversion
		docx2txt "$file"
		exit 0 ;;

	# OpenDocument
	odt|ods|odp|sxw)
		# Preview as text conversion
		odt2txt "$file"
		exit 0 ;;

	# HTML
	htm|html|xhtml)
		# Preview as text conversion
		w3m -dump "$file"
		exit 0 ;;
esac

# Handle mimetype.
case "$( file -b --mime-type -- "$file" | tr '[:upper:]' '[:lower:]' )" in
	# Text
	text/*|*/xml|*/json)
		highlight -t 4 -O ansi -- "$file" || cat -- "$file"
		# bat -pp -- "$file"
		exit 0 ;;
	# Image
	image/*)
		# Preview as text conversion
		# img2txt --gamma=0.6 -- "$file" && exit 0
		# exiftool "$file"
		chafa --fill=block --symbols=block -c 240 -s $(($(tput cols) / 2))x$(tput lines) "${file}"
		exit 0 ;;
	# Video and audio
	video/*|audio/*)
		mediainfo "$file"
		exit 0 ;;
esac

[ -x "$file" ] && echo "Binary file." && exit 0

echo "No preview available." && exit 1
