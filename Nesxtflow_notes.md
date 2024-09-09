# 04.09.24  NGS

**FAIR Data** -> Findable Accessible Interoperable Reusable

**Pipelining** using Pipeline ensures reproducible Results or at least Analysis 

**Nextflow** Domain specific Language based on Groovy three parts Channels in 
and output of Datasets, Processes are the programs executing on the datasets,  
Workflow describes the interactions between Channels an d Processes. 
documentation Link https://www.nextflow.io/docs/latest/index.html
helpful patterns https://nextflow-io.github.io/patterns/index.html

**scripts** have the ending .nf 
processes are created like this they usually hold a unit of commands that are one logical logic. 
separate Processes can be run simultaneity on different CPU Cores only if they are separate Processes.
Var writing to execute in Bash and Nextflow. Inside the Nextflow script but outside of Bash code blocks ''' ''' 
plainly written Varnames are executed, inside of "" $ is needed to differentiate between text and code. 
inside a Bash Codeblock ''' ''' $ is always needed to mark Vars.

```
process ProcessName 
{
	"""
	Command to be executed 
	"""
}
```
they are organised in the workflow like
```
workflow
{
	ProcessName
}
```
to have eg a downloaded file in a certain dir
process downloadFile 
```
{
	publishDir "/home/michelle/Modul_5_NGS_Git/NGS-Introduction", mode: "copy", overwrite: true
	output:
		path "batch1.fasta"
	"""
	wget https:LINK -O batch1.fasta
	"""
}
```
publishDir -> path where to save, 
mode "copy" -> default mode "link" just a softlink is created that 
points to the copy in the workingDir (where the pipeline gets the 
Data and keeps processing it), mode "move" only leaves a copy in the 
given path not the workingDir

overwrite: true to overwrite the file if it already exists.
the -O for wget defines the output file

assigning channels to processes 

Since both processes create their own tmp workDir, countSequences 
does not get an input since its in the WDir from downloadFile not 
its own, so those processes need to be connected with a Channel
(fastachannel)

* in the workflow
```
	workflow
{
	fastachannel= downloadFile()  (Channelname freely chosen)
	countSequences(fastachannel)
}
```
* in the Process
```
process countSequences
{
	publishDir "/home/michelle/Modul_5_NGS_Git/NGS-Introduction", mode: "copy", overwrite: true
	input:
		path infile (free chosen Name for Variable)
	output:
		path "numseqa.txt"
	"""
	grep ">" $infile | wc -l > numseqa.txt 
	(the $ is necessary so Bash sees it as a Variable not just Text 
	inside the ''' ''' since this means its a Bash code Block )
	"""
}
```
This all is necessary because if no input is stated no input will be 
accepted thru fastachannel

# params.out
having Local paths in the file makes it impossiible for others to 
use it

so this 
```
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
```
should be liike this:
```
nextflow.enable.dsl=2

params.out = "$launchDir/output" 
```
(params is a dictonary containing several parameters, using params.
out instead of just a Variable is advantageous because you can 
overwrite it with --out on the commandline if needed)

(launchDir is the standard Dir where the script is launched from, $ 
because it should be substituted by the actual file and its in"")
```
process downloadFile 
{
	publishDir params.out, mode: "copy", overwrite: true
(path for publishDir replaced with params.out)
	output:
		path "batch1.fasta"
	"""
	wget https://tinyurl.com/cqbatch1 -O batch1.fasta
	"""
}
```
implicit vars is not declared because the type is assumed by the operators

# Python in Bash
  """
  python $projectDir/split.py $infile seq_
  """
  $projectDir because thats where the python script is its not in the workDir 
  of the process

# flatten
is a operation used inside the workflow {} statement it splits the channel 
input so that several files (the input has to be several files it doesn't 
split) can be processes after each other, not as one Chunk

# collect
is the counterpart to flatten it collects all inputs in a channel and only 
starts to execute after all inputs are created.