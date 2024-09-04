# 04.09.24  NGS

**FAIR Data** -> Findable Accessible Interoperable Reusable

**Pipelining** using Pipeline ensures reproducible Results or at least Analysis 

**Nextflow** Domain specific Language based on Groovy three parts Channels in and output of Datasets, Processes are the programs executing on the datasets,  Workflow describes the interactions between Channels an d Processes. 
documentation Link https://www.nextflow.io/docs/latest/index.html
helpful patterns https://nextflow-io.github.io/patterns/index.html

**scripts** have the ending .nf 
processes are created like this they usually hold a unit of commands that are one logical logic. separate Processes can be run simultaneity on different CPU Cores only if they are separate Processes.

process ProcessName 
{
	"""
	Command to be executed 
	"""
}

they are organised in the workflow like

workflow
{
	ProcessName
}

to have eg a downloaded file in a certain dir
process downloadFile 
{
	publishDir "/home/michelle/Modul_5_NGS_Git/NGS-Introduction", mode: "copy", overwrite: true
	output:
		path "batch1.fasta"
	"""
	wget https:LINK -O batch1.fasta
	"""
}
publishDir -> path where to save, 
mode "copy" -> default mode "link" just a softlink is created that points to the copy in the workingDir (where the pipeline gets the Data and keeps processing it), mode "move" only leaves a copy in the given path not the workingDir
overwrite: true to overwrite the file if it already exists.
the -O for wget TODO