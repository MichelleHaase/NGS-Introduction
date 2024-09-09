nextflow.enable.dsl=2

params.out = "$launchDir/output"

process downloadFile 
{
	publishDir params.out, mode: "copy", overwrite: true
	output:
		path "batch1.fasta"
	"""
	wget https://tinyurl.com/cqbatch1 -O batch1.fasta
	"""
}
process countSequences
{
	publishDir params.out, mode: "copy", overwrite: true
	input:
		path infile
	output:
		path "numseqa.txt"
	"""
	grep ">" $infile | wc -l > numseqa.txt
	"""
}
process splitSeq
{
	publishDir params.out, mode: "copy", overwrite: true
	input:
		path infile
	output:
		path "split_*"
	"""
		split $infile --lines=2 --additional-suffix=.fasta split_
	"""
}

process countRepeats 
{
  publishDir params.out, mode: "copy", overwrite: true
  input:
    path infile 
  output:
    path "${infile.getSimpleName()}.repeatcount"
  """
  grep -o "GCCGCG" $infile | wc -l > ${infile.getSimpleName()}.repeatcount
  """
}

workflow
{
	downloadFile | splitSeq | flatten | countRepeats
}