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
    ~/.aws/*
    ~/.ssh/*.pem
    ~/.ssh/config
    ~/.ssh/id_rsa*
    ~/.config/rclone/rclone.conf
)

cd ${WORKDIR}

FILE_HASH_DB="${PWD}/.hash"
if [ ! -f ${FILE_HASH_DB}} ]; then
    touch ${FILE_HASH_DB}
fi

FILES=`
for pattern in ${PATTERNS[@]} ; do
    ls ${pattern}
done
`

for FILE in ${FILES[@]}; do
    FILE_PATH=${FILE##${HOME}/}
    mkdir -p `dirname ${FILE_PATH}`
    # 通过文件指纹查询
    HASH=`git hash-object ${FILE}`
    HASH_CONTENT="${FILE_PATH} ${HASH}"
    CHECK_HASH=`sed -n "/${HASH}$/p" ${FILE_HASH_DB}`
    if [ "${CHECK_HASH}" != "" ]; then
        if [ "${CHECK_HASH}" != "${HASH_CONTENT}" ]; then
            # 文件指纹存在, 但文件名不一样(R - 重命名)
            TMP=`sed "/${HASH}$/d" ${FILE_HASH_DB}`
            echo -e "${TMP}" > ${FILE_HASH_DB}
            echo -e "R ${FILE_PATH}"
            echo ${HASH_CONTENT} >> ${FILE_HASH_DB}
            gpg --yes --armor -r ${RECIPIENT} -o ${FILE_PATH} -e ${FILE}
        fi
        continue
    fi

    # 通过文件名查询
    TMP=${FILE_PATH//\//\\\/}
    PAT=${TMP//\./\\\.}
    CHECK_FILE=`sed -n "/^${PAT}/p" ${FILE_HASH_DB}`
    if [ "${CHECK_FILE}" != "" ]; then
        # 文件名存在, 但指纹不一样(M - 文件内容变更)
        TMP=`sed "/^${PAT}/d" ${FILE_HASH_DB}`
        echo -e "${TMP}" > ${FILE_HASH_DB}
        echo "M ${FILE_PATH}";
    else
        # 文件名不存在, 指纹也不存在(A - 新增的文件)
        echo "A ${FILE_PATH}";
    fi

    echo ${HASH_CONTENT} >> ${FILE_HASH_DB}
    gpg --yes --armor -r ${RECIPIENT} -o ${FILE_PATH} -e ${FILE}

done

# 维护文件指纹库 - 删除无用条目
DB_FILES=`cat ${FILE_HASH_DB} | awk {'print $1'}`
for DB_FILE in ${DB_FILES[@]}; do
    EXISTS=false
    for FILE in ${FILES[@]}; do
        FILE_PATH="${FILE##${HOME}/}"
        if [ "${FILE_PATH}" == "${DB_FILE}" ]; then
            EXISTS=true
            break
        fi
    done
    if [ ${EXISTS} == false ]; then
        rm -fr ${DB_FILE}
        TMP=${DB_FILE//\//\\\/}
        PAT=${TMP//\./\\\.}
        TMP=`sed "/^${PAT}/d" ${FILE_HASH_DB}`
        echo -e "${TMP}" > ${FILE_HASH_DB}
        echo -e "D ${DB_FILE}"
    fi
done
