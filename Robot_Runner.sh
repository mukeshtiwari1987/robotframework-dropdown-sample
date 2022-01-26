hub_url=${1}
outputdir=${2}
Test_path=${3}

echo hub_url = ${1}
echo outputdir = ${2}
echo Test_path = ${3}

pabot --removekeywords wuks --suitestatlevel 3 --variable hub_url:${hub_url} --outputdir ${outputdir} ${Test_path}
