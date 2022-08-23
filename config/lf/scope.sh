#!/bin/sh

image() {
    if [ -n "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ]; then
        printf '{"action": "add", "identifier": "PREVIEW", "x": "%s", "y": "%s", "width": "%s", "height": "%s", "scaler": "contain", "path": "%s"}\n' "$4" "$5" "$(($2 - 1))" "$(($3 - 1))" "$1" > "$FIFO_UEBERZUG"
        exit 1
    else
        chafa "$1" -s "$4x"
    fi
}

batorcat() {
    file="$1"
    shift
    if command -v bat > /dev/null 2>&1; then
        /usr/bin/bat --color=always --style=plain --pager=never "$file" "$@"
    else
        cat "$file"
    fi
}

CACHE="$HOME/.cache/lf/thumbnail.$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | awk '{print $1}'))"

case "$(file --mime-type "$1" -bL)" in
    video/*)
        [ ! -f "${CACHE}.jpg" ] && thumbnailer -o "${CACHE}.jpg" "$1"
        image "${CACHE}.jpg" "$2" "$3" "$4" "$5"
        ;;
    application/pdf)
        [ ! -f "${CACHE}.jpg" ] && pdftoppm -jpeg -f 1 -singlefile "$1" "$CACHE"
        image "${CACHE}.jpg" "$2" "$3" "$4" "$5"
        ;;
    application/epub+zip)
        [ ! -f "$CACHE" ] && epub-thumbnailer "$1" "$CACHE" 1024
        image "$CACHE" "$2" "$3" "$4" "$5"
        ;;
    image/vnd.djvu)
        [ ! -f "$CACHE" ] && ddjvu -format=tif -quality=50 -page=1 "$1" "$CACHE"
        image "$CACHE" "$2" "$3" "$4" "$5"
        ;;
    image/svg+xml)
        [ ! -f "${CACHE}.png" ] && convert "$1" "$CACHE.png"
        image "${CACHE}.png" "$2" "$3" "$4" "$5"
        ;;
    image/*)
        image "$1" "$2" "$3" "$4" "$5"
        ;;
    audio/*)
        exiftool "$1"
        ;;
    application/x-bittorrent)
        transmission-show "$1"
        ;;
    text/html)
        [ ! -f "$CACHE" ] && wkhtmltopdf "$1" - | pdftoppm -jpeg -f 1 -singlefile - "$CACHE"
        image "${CACHE}.jpg" "$2" "$3" "$4" "$5"
        ;;
    application/x-object)
         nm "$1"
        ;;
    application/zip | application/x-rar)
        als "$1"
        ;;
    *)
        batorcat "$1"
        ;;
esac
