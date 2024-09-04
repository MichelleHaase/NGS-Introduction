nextflow.enable.dsl=2

process downloadFile 
{
	publishDir "/home/michelle/Modul_5_NGS_Git/NGS-Introduction", mode: "copy", overwrite: true
	output:
		path "batch1.fasta"
	"""
	wget https://tinyurl.com/cqbatch1 -O batch1.fasta
	"""
}

workflow
{
	downloadFile()
}