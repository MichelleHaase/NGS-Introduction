nextflow.enable.dsl=2


params.url = null
params.infile = null
params.out = "$projectDir/outfiles"
params.name = "exampleFile"
params.temp = "$projectDir"

process download
{
	storeDir params.temp
	input:
		val params.url 
	output:
		path "${params.name}.sam"
		
	"""
	wget ${params.url} -O ${params.name}.sam
	"""
}

process sort
{
	input: 
		val infile
	output:
		path "${params.name}_singleSeqs_${infile}.sam"
	"""
	grep -o -v "^@" $infile | 
	"""

}

workflow
{
	if(params.url != null && params.infile == null)
	{
		samfile = download(params.url)
	}
	else if (params.infile != null && params.url == null)
	{
		samfile = Channel.fromPath(params.infile)
	}
	else
	{
		print " input either --url or --infile"
		System.exit(0)
	}
channel_split= samfile.splitText()
channel_filtered= channel_split.filter { it[0] != "@" }.map { it.tokenize("\t")
channel_mapped= channel.filtered.map()

} 