#!/bin/bash


print_instructions() {
    printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━INSTRUCTIONS━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    printf "\e[4mUsage:\n\e[0m"
    printf "    ./file-verification.sh -a account -c container-path -f files -o outfile \n"
     printf "    files..........list of local files to upload.\n"
    printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" && exit
}

####################################Options####################################
# Parsing options

OPTIND=1 # Reset OPTIND
while getopts :a:c:f:o:h opt
    do
        case $opt in
            a) account=$OPTARG;;
            c) container=$OPTARG;;
            f) files=$OPTARG;;
            o) out=$OPTARG;;
            h) print_instructions;;
        esac
    done

shift $(($OPTIND -1))

echo -e "File Name\tLocal MD5\tOn Azure MD5\tStatus\n" | tee $out


for line in $(cat $files); do
	echo "Working on: $line"

	ON_PREM_MD5=$(md5 $line | cut -f 2 -d '=' | cut -f 2 -d ' ' )

    echo "Uploading: $line to https://$account.blob.core.windows.net/$container/$line"
    azcopy copy "$line" "https://$account.blob.core.windows.net/$container/$line" --put-md5

    echo "Checking checksum."
	ON_AZURE_MD5=`azcopy list --properties "contentMD5" "https://$account.blob.core.windows.net/$container/$line" | grep ContentMD5 | cut -f 2 -d';' | cut -d' ' -f 3  |  base64 -d | hexdump -v -e '/1 "%02x"'`
    


    if [[ "$ON_PREM_MD5" != "$ON_AZURE_MD5" ]]; then
        echo "The checksums do not match. Azure: $ON_AZURE_MD5, local: $ON_PREM_MD5"
        echo -e "$line\t$ON_PREM_MD5\t$ON_AZURE_MD5\tFAIL\n" | tee -a $out
    else
        echo "The checksums match."
        echo -e "$line\t$ON_PREM_MD5\t$ON_AZURE_MD5\tPASS\n" | tee -a $out
    fi
done