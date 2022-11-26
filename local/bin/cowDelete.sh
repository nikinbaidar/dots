#! /bin/bash
lightBlue='\033[1;34m'
lightPurple='\033[1;35m'

bold=$(tput bold)

python -c "print('\n'*35)"
echo -e "${lightPurple}"

for file in "$@"
do
	fileName=$(basename "$file")

	if [ -d "$file" ]
	then
		echo -e " $fileName  $(du -sh "$file" | awk '{print $1}')"
		continue
	fi

	case "${fileName##*.}" in
		*) echo -e " ${fileName}" ;;
	esac
done | cowsay -n

echo -e "${lightBlue}"
read -p "${bold}So you want to delete them?[y/n]: " ans

if [[ "${ans}" = "Y" || "${ans}" = y ]] ; then
	for file in "$@"
	do
		rm -rf "${file}"
	done
fi

clear -x
