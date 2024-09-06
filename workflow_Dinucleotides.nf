
/* processes read file from PC
			downd files 
			
channels	cat | splitting the dinuc fie
			combine --> array of dinuc snippets and the file each time

how can freq be calculated??? 
*/

nextflow.enable.dsl=2

params.name= "Genome1"
params.infile = "/home/michelle/Modul_5_NGS_Git/NGS-Introduction/Dinucs.txt"
params.out = "$projectDir/out"
params.url = "https://gitlab.com/dabrowskiw/cq-examples/-/raw/master/data/dinucleotides/homosapienscontig.fasta?inline=false"

process download
{
	publishDir params.out, mode: "copy", overwrite: true
	
	output:
		path "${params.name}.fasta"

	"""
	wget $params.url -O ${params.name}.fasta
	"""
}

process countDiNu 
{
	publishDir params.out, mode:'copy', overwrite: true
	input: 
		tuple val(DiNu), path(count)
	output: 
		path "${DiNu}_counts.txt"
	"""
	echo -n ${DiNu} > ${DiNu}_counts.txt
	echo -n ", " >> ${DiNu}_counts.txt
	grep -o ${DiNu} ${count} | wc -l >> ${DiNu}_counts.txt
	"""
}

process Report 
{
  publishDir params.out, mode: "copy", overwrite: true
  input:
		path infile 
  output:
    path "DiNuReport.csv"
  """
  cat * > counts.csv
  echo "# Dinucleotide, Num_repeats" > DiNuReport.csv
  cat counts.csv >> DiNuReport.csv
  """
}

workflow
{
infile_channel = download()
downloadChannel= Channel.fromPath(params.infile) | splitText | map { it.trim() } | combine(infile_channel) | countDiNu | collect | Report 

}
/*
input can be path or val 

echo vs cat? cat echo for files val is not file its a value so echo

take absolut numbers and do iy in R
*/