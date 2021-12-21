#!/usr/bin/env bash
# Use tinypng.com API to shrink a png/jpeg image.
# Requires Bash 4 (or above) and curl.

# Base URL for tinify.com API service.
baseurl=api.tinify.com
# API URL.
apiurl=https://$baseurl/shrink
# Developers URL.
dev_url=https://tinify.com/developers
# A file to keep the API key for future requests.
keyfile="$HOME/.config/tinify/api.key"
# The API key.
apikey=
# PNGs to shrink.
org_images=()
# The directory to which the user wants to download the shrinked PNGs.
download_dir=
# Print URLs of shrinked PNGs after download.
print_urls_after_dl=0
# URLs to shrinked PNG/JPaGs.
declare -A image_urls
# Overwrite exisiting images.
overwrite=0
# Silent Mode
silent=0

# Print help message to stdout.
# Args: none.
show_help() {
    local bold=$(tput bold)
    local reset=$(tput sgr0)
cat<<-EOF
${bold}NAME${reset}
        tinypng - Shrink PNG/JPEGs using tinify.com service.
${bold}SYNOPSIS${reset}
        tinypng [-dkph] -f FILE
${bold}DESCRIPTION${reset}
        Shrink PNG/JPEGs using tinify.com service.

        On first execution, or if $keyfile is not present, tinypng will ask for an API key.
        Obtain your API key from $dev_url, copy and paste it when prompted.
${bold}OPTIONS${reset}
        -f,--file FILE              Select a FILE to be shrinked.
        -d,--dirname DIRECTORY      Download all shrinked images to DIRECTORY.
        -o,--overwrite              Overwrite the source images with the downloaded ones.
        -k,--key API_KEY            Use API_KEY, instead of the one stored in $keyfile.
        -p,--print                  When -d is being used, the URLs of the shrinked images are not being printed to stdout.
                                    Use this option to force printing even when using -d.
                                    Otherwise, this option is set implicitly.
        -- FILES                    Ignore any options to come.
                                    Everything after this option is considered a file.
        -s,--slient                 Slient Mode.
        -h,--help                   Show this message and exit successfully.

${bold}EXAMPLES${reset}
        Shrink foo.jpg, bar.png, baz.png and print the result URLs to stdout.
        ${bold}$ tinypng -f foo.jpg -f bar.png -f baz.png${reset}
            or
        ${bold}$ tinypng -- foo.jpg bar.png baz.png${reset}
        Shrink foo.jpg, bar.png, baz.png and download the result images to tiny_pngs/ directory
        ${bold}$ tinypng -d tiny_pngs/ -- foo.jpg bar.png baz.png${reset}
EOF
}

# Check Requirements, Requires Bash 4 (or above) and Curl
check_requirements() {
    BASH_VERSION=`bash --version | head -n1 | cut -d" " -f4 |cut -d"." -f1`
    if [ "${BASH_VERSION}" -lt "4" ]; then
        echo 'Error: your bash version is lower than 4.0'
        echo 'For Mac OS X, you can install lastest bash with homebrew by executing `brew install bash`'
        exit 1
    fi
    if ! [ -x "$(command -v curl)" ]; then
        echo 'Error: curl is not installed.' >&2
        exit 1
    fi
}

# Die, bitch.
# Args: Exit status (optional), failure message.
die() {
    local r=$?
    if [[ $1 != *[!0-9]* ]]; then
        r=$1
        shift
    fi
    printf 'tinypng: %s\n' "$@" >&2
    exit $r
}

# Check if a file is a PNG image.
# Args: File name.
is_png() {
    local file=$1
    [[ "$(file --brief --mime-type "$file")" = "image/png" ]]
}

# Check if a file is a JPEG image.
# Args: File name.
is_jpg() {
    local file=$1
    [[ "$(file --brief --mime-type "$file")" = "image/jpeg" ]]
}

# Check if a file is a PNG/JPEG image and store it for shrinking.
# Args: File name.
check_and_store_image() {
    local file=$1

    if [[ -f $file ]] && (is_png "$file" || is_jpg "$file"); then
        org_images+=("$file")
    else
        printf 'tinypng: Skipping %s. It is not a PNG/JPEG file.\n' "$file" >&2
    fi
}

# Ping a site to see if it is reachable
# Args: URL.
is_reachable() {
    local url=$1
    if [ "$(uname)" == "Darwin" ]; then
        ping -c1 -W2 "$url" >/dev/null 2>&1
    else
        ping -c1 -w2 "$url" >/dev/null 2>&1
    fi
}

# Reads the API key.
# Args: none.
read_key() {
    read -r apikey < "$keyfile"
} 2>/dev/null

# Prompt and ask the user for an API key.
# Args: none.
prompt_for_key() {
    printf 'Get your API key from %s copy and paste it here.\n' "$dev_url"
    read -p 'Enter your API key: ' apikey
    echo
}

# Saves the API key for future requests.
# Args: API key.
save_apikey() {
    local key=$1
    umask 0077
    printf '%s\n' "$key" > "$keyfile"
}

# Request a tiny URL from tinify.com.
# Args: PNGs.
get_shrinked_url() {
    local png=$1
    curl --fail --silent --user api:"$apikey" \
        --data-binary @"$png" -i "$apiurl" --dump-header /dev/stdout | grep -oE -m1 "https://$baseurl/output/[[:alnum:]]+" &
    wait
}

# Download a PNG.
# Args: File name, URL to PNG file.
# todo: change name to download in background
download() {
    local file=$1 url=$2
    if [ ${silent} -gt 0 ]; then
        curl --fail --silent --user api:"$apikey" --output "$file" "$url" &
    else
        curl --fail --progress-bar --dump-header /dev/stdout --user api:"$apikey" --output "$file" "$url" &
    fi
    wait
}

### MAIN ###
# Parse command line options and arguments.
while (( $# ));do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -k|--key)
            apikey=$2
            [[ $apikey ]] || die "$1 requires an argument."
            shift
            ;;
        -d|--dirname)
            [[ -d $2 ]] || die "$1 requires a directory name as an argument."
            download_dir=${2%/}
            shift
            ;;
        -f|--file)
            if [[ $2 ]]; then
                check_and_store_image "$2"
            else
                die "$1 requires an argument."
            fi
            shift
            ;;
        -s|--silent)
            silent=1
            ;;
        -p|--print)
            print_urls_after_dl=1
            ;;
        -o|--overwrite)
            overwrite=1
            ;;
        --)
            shift
            for f;do
                check_and_store_image "$f"
            done
            break
            ;;
        *)
            show_help && die "$1 Unknown option."
    esac
    shift
done

check_requirements

(( ${#org_images[@]} )) || { show_help; exit 1; }

# Check if tinify.com is indeed reachable.
# is_reachable "$baseurl" || die "tinify.com is not reachable."

# Save and/or get API key.
if [[ ! $apikey ]]; then
    if ! read_key; then
        prompt_for_key
        save_apikey "$apikey"
    fi
fi

# Request tinify.com to shrink imagess.
for image in "${org_images[@]}"; do
    [ $silent -gt 0 ] || printf 'Shrinking %s\n' "${image##*/} ..." >&2

    if image_url=$(get_shrinked_url "$image"); then
        name="tiny-${image##*/}"
        (( overwrite  )) && name="${name#tiny-}"
        org_dir=`dirname ${image}`
        image_urls["${org_dir}/${name}"]="$image_url"
    else
        printf 'tinypng: tinify.com failed to shrink %s.\n' "$image" >&2
    fi
done

# If some of the PNGs were shrinked successfully.
if (( ${#image_urls[@]} )); then
    # Download shrinked PNGs.
    if [ "${download_dir}" != "" ]; then
        for key in "${!image_urls[@]}"; do
            dir_name=`dirname ${key}`
            [ $silent -gt 0 ] || printf 'Downloading %s to %s\n' "$key" "$download_dir" >&2
            if ! download "$download_dir/${key#${dir_name}}" "${image_urls[$key]}"; then
                printf 'tinypng: Failed to download %s from %s to %s.\n' "$key" "${image_urls[$key]}" "$download_dir" >&2
            fi
        done
        (( print_urls_after_dl )) && printf '%s\n' "${image_urls[@]}"
    else
        for key in "${!image_urls[@]}"; do
            download_dir=`dirname ${key}`
            [ $silent -gt 0 ] || printf 'Downloading %s to %s\n' "$key" "$download_dir" >&2
            if ! download "$download_dir/${key#${download_dir}}" "${image_urls[$key]}"; then
                printf 'tinypng: Failed to download %s from %s to %s.\n' "$key" "${image_urls[$key]}" "$download_dir" >&2
            fi
        done
        (( print_urls_after_dl )) && printf '%s\n' "${image_urls[@]}"
    fi
fi
exit 0
