 nextflow.enable.dsl = 2

params.storeDir="${launchDir}/cache"
params.accession="SRR16641653"
params.out="${launchDir}/out"
params.style = 
process prefetch 
{
	storeDir params.storeDir
	container "https://depot.galaxyproject.org/singularity/sra-tools%3A2.11.0--pl5321ha49a11a_3"
	input:
		val accession
	output:
		path accession
	"""
	prefetch $accession 
	"""
}
process fasterdump
{
	container "https://depot.galaxyproject.org/singularity/sra-tools%3A2.11.0--pl5321ha49a11a_3"
	input: 
		path infile
	output: 
		path "${infile}.fastq"
	"""
	fasterq-dump ${infile}
	"""
	
}
process NGSUtils_stats
{
	publishDir params.out, mode: "copy", overwrite: true
	container "https://depot.galaxyproject.org/singularity/ngsutils%3A0.5.9--py27h9801fc8_5"
	input:
		path infile
	output:
		path "results.txt"
	"""
	fastqutils stats ${infile} > results.txt
	"""
}

process FastGC_stats
{
	publishDir params.out, mode: "copy", overwrite: true
	container "https://depot.galaxyproject.org/singularity/fastqc%3A0.12.1--hdfd78af_0"
	input:
		path infile
	output:
		path "fastqc"
	"""
	mkdir fastqc
	fastqc --noextract --nogroup -o fastqc ${infile}
	"""
}
workflow 
{
	// prefetch(Channel.from(params.accession))| fasterdump | NGSUtils_stats
	prefetch(Channel.from(params.accession))| fasterdump | FastGC_stats
}
/* 
if param.style == "NGSUtils"
	NGSUtils_stats
else if param.style == "FastQC"
	FastGC_stats
else 
	echo "please give one option for the preffered style -style \"NGSUtils\" or -style \"FastQC\" " 


*/