#!/bin/bash
# set -ex

if ! [ -x "$(command -v git)" ]; then
    echo 'Error: git is not installed.' >&2
    exit 1
fi

if ! [ -x "$(command -v gpg)" ]; then
    echo 'Error: gpg is not installed.' >&2
    exit 1
fi

WORKDIR="${PWD}/data"
RECIPIENT="mail@codiy.net"
PATTERNS=(
    .aws/*
    .ssh/*.pem
    .ssh/config
    .ssh/id_rsa*
    .gnupg/*.sec.key
    .config/tinify/api.key
    .config/rclone/rclone.conf
)

cd ${WORKDIR}

FILES=`
for pattern in ${PATTERNS[@]} ; do
    ls ${pattern}
done
`
DIST=${HOME}
RUNTIME=${PWD}/runtime
BACKUP=${PWD}/backup
rm -fr ${RUNTIME} ${BACKUP}
mkdir -p ${RUNTIME} ${BACKUP}
touch ${BACKUP}/diff.log

for FILE in ${FILES[@]}; do
    DIST_PATH=${DIST}/${FILE#${PWD}/}
    DECR_PATH=${RUNTIME}/${FILE#${PWD}/}
    BACKUP_PATH=${BACKUP}/${FILE#${PWD}/}

    mkdir -p `dirname ${DIST_PATH}`
    mkdir -p `dirname ${DECR_PATH}`

    gpg --quiet --yes -r ${RECIPIENT} -o ${DECR_PATH} -d ${FILE}

    if [ -f ${DIST_PATH} ]; then
        HASH_DIST=`git hash-object ${DIST_PATH}`
        HASH_DECR=`git hash-object ${DECR_PATH}`
        if [ "${HASH_DIST}" == "${HASH_DECR}" ]; then
            continue
        else
            mkdir -p `dirname ${BACKUP_PATH}`
            DIFF=`git diff --no-index ${DIST_PATH} ${DECR_PATH}`
            yes | cp -rf ${DIST_PATH} ${BACKUP_PATH} 2>/dev/null || :
            echo -e "${DIFF}" >> ${BACKUP}/diff.log
        fi
    fi

    yes | cp -rf ${DECR_PATH} ${DIST_PATH} 2>/dev/null || :

done

cat ${BACKUP}/diff.log 2>/dev/null || :
