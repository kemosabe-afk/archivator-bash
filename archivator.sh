#!/bin/bash

##########
# CHECKS #
##########

checkbin() {
case ${c} in
    tar|tgz|tbz2|txz)
        if ! (which tar &> /dev/null); then
            echo -e "\033[0;31m'tar' utility is not installed on your device"; exit 1
        fi
        ;;

    7z)
        if ! (which 7z &> /dev/null); then
            echo -e "\033[0;31m'7-Zip' utility is not installed on your device"; exit 1
        fi
        ;;

    rar)
        if ! (which rar &> /dev/null); then
            echo -e "\033[0;31m'RAR' utility is not installed on your device"; exit 1
        fi
        ;;
    
    zip)
        if ! (which zip &> /dev/null); then
            echo -e "\033[0;31m'ZIP' utility is not installed on your device"; exit 1
        fi
        ;;
esac
}

checkfile() {
if [ -n "${f}" ]; then
    if [ ! -f "${f}" ]; then
        echo -e "\033[0;31m'${f}' file does not exist!"; exit 1
    fi
fi
}

checkdir() {
if [ -n "${d}" ]; then
    if [ ! -d "${d}" ]; then
        echo -e "\033[0;31m'${d}' directory does not exist!"; exit 1
    fi
fi
}

#########
# USAGE #
#########

usage() {
echo -e "
        Usage:          \033[1m$0 [-c|-x create|extract] [-d directory] [-f file]\033[0m

        -c create       \033[1mCreate an Archive [tar|tgz|tbz2|txz|7z|rar|zip].\033[0m
        -x extract      \033[1mExtract an Archive (Auto-Detects the Type of Archive).\033[0m
        -d directory    \033[1mCreate/Extract to the Specific Directory.\033[0m
        -f file         \033[1mInput File to Archive/Extract.\033[0m

        For Example:    \033[1m$0 -c tbz2 -d ~/ -f ./test.txt
                        \033[1m$0 -x -d ./ -f ~/test.txt.tar.bz2
"
}

###########
# GETOPTS #
###########

while getopts ":c:xd:f:" o; do
    case "${o}" in
        c)
            c=${OPTARG}
        [[ $c == "tar" || $c == "tgz" || $c == "tbz2" \
        || $c == "txz" || $c == "7z"  || $c == "rar" \
        || $c == "zip" ]] || usage
            ;;
        x)
            x=${OPTARG}
            ;;
        d)
            d=${OPTARG}
            ;;
        f)
            f=${OPTARG}
            ;;            
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${c}" ] && [ -z "${x}" ] && [ -z "${f}" ]; then
    usage
fi

############
# CHECKING #
############

checkbin && checkfile && checkdir

[[ -n ${d} ]] && [[ ${d} != */ ]] && d="${d}/"

##############
# ARCHIVATOR #
##############

[ -n "${c}" ] && [ -z "${x}" ] && [ -n "${f}" ] && \

case ${c} in
    tar)
        echo -e "\033[0;31mArchiving ${f} into .tar archive..."; \
        tar -cf "${d}""${f}".tar "${f}";
        echo -e "\033[0;31mDone!"
        ;;

    tgz)
        echo -e "\033[0;31mArchiving ${f} into .tar.gz archive..."; \
        tar -czf "${d}""${f}".tar.gz "${f}";
        echo -e "\033[0;31mDone!"
        ;;

    tbz2)
        echo -e "\033[0;31mArchiving ${f} into .tar.bz2 archive..."; \
        tar -cjf "${d}""${f}".tar.bz2 "${f}";
        echo -e "\033[0;31mDone!";
        ;;

    txz)
        echo -e "\033[0;31mArchiving ${f} into .tar.xz archive..."; \
        tar -cJf "${d}""${f}".tar.xz "${f}";
        echo -e "\033[0;31mDone!";
        ;;

    7z)
        echo -e "\033[0;31mArchiving ${f} into .7z archive..."; \
        7z a "${d}""${f}".7z "${f}" > NULL; rm NULL;
        echo -e "\033[0;31mDone!";
        ;;

    rar)
        echo -e "\033[0;31mArchiving ${f} into .rar archive..."; \
        rar a "${d}""${f}".rar "${f}" > NULL; rm NULL;
        echo -e "\033[0;31mDone!";
        ;;

    zip)
        echo -e "\033[0;31mArchiving ${f} into .zip archive..."; \
        zip -r "${d}""${f}".zip "${f}" > NULL; rm NULL;
        echo -e "\033[0;31mDone!"
        ;;
esac

#############
# EXTRACTOR #
#############

shopt -s nocasematch

[ -z "${c}" ] && [ -z "${x}" ] && [ -n "${f}" ] && \

case $(file "${f}") in
    *"tar"*)
        if [ -n "${d}" ];then
            echo -e "\033[0;31mExtracting ${f}..."; \
            tar xf "${f}" -C "${d}";
            echo -e "\033[0;31mDone!"
        else
            echo -e "\033[0;31mExtracting ${f}..."; \
            tar xf "${f}";
            echo -e "\033[0;31mDone!"
        fi
            ;;

    *"gzip"*)
        if [ -n "${d}" ];then
            echo -e "\033[0;31mExtracting ${f}..."; \
            tar xzf "${f}" -C "${d}";
            echo -e "\033[0;31mDone!"
        else
            echo -e "\033[0;31mExtracting ${f}..."; \
            tar xzf "${f}";
            echo -e "\033[0;31mDone!"
        fi
            ;;

    *"bzip2"*)
        if [ -n "${d}" ];then
            echo -e "\033[0;31mExtracting ${f}..."; \
            tar xjf "${f}" -C "${d}";
            echo -e "\033[0;31mDone!"
        else
            echo -e "\033[0;31mExtracting ${f}..."; \
            tar xjf "${f}";
            echo -e "\033[0;31mDone!"
        fi
            ;;

    *"XZ"*)
        if [ -n "${d}" ];then
            echo -e "\033[0;31mExtracting ${f}..."; \
            tar xJf "${f}" -C "${d}";
            echo -e "\033[0;31mDone!"
        else
            echo -e "\033[0;31mExtracting ${f}..."; \
            tar xjf "${f}";
            echo -e "\033[0;31mDone!"
        fi
            ;;

    *"7-zip"*)
        if [ -n "${d}" ];then
            echo -e "\033[0;31mExtracting ${f}..."; \
            7z e "${f}" -o"${d}" > NUL; rm NUL;
            echo -e "\033[0;31mDone!"
        else
            echo -e "\033[0;31mExtracting ${f}..."; \
            7z x "${f}" > NUL; rm NUL;
            echo -e "\033[0;31mDone!" 
        fi
            ;;

    *"RAR"*)
        if [ -n "${d}" ];then
            echo -e "\033[0;31mExtracting ${f}..."; \
            unrar e "${f}" "${d}" > NUL; rm NUL;
            echo -e "\033[0;31mDone!"
        else
            echo -e "\033[0;31mExtracting ${f}..."; \
            unrar e "${f}" > NUL; rm NUL;
            echo -e "\033[0;31mDone!"
        fi
            ;;

    *"Zip"*)
        if [ -n "${d}" ];then
            echo -e "\033[0;31mExtracting ${f}..."; \
            unzip "${f}" -d "${d}" > NUL; rm NUL;
            echo -e "\033[0;31mDone!"
        else
            echo -e "\033[0;31mExtracting ${f}..."; \
            unzip "${f}" > NUL; rm NUL;
            echo -e "\033[0;31mDone!"
        fi
            ;;

    *)
        usage
            ;;
esac