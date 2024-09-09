import sys

## objectoriented
class Sequence:
    def __init__(self, name, seq):
        self.name =name
        self.seq= seq
    
    def __str__(self):
        res = ["Seq:"]
        res += [self.name]
        res += [self.seq]
        return "\n".join(res) 

def split_fasta(infileName):
    res=[]
    f= open(infileName, "r")
    for line in f.readlines():
        if line.startswith(">"):
            currentseq = Sequence(line[1:].strip(), "")
        else:
            currentseq.seq= line.strip()
            res += [currentseq]
        print(line.strip())
    f.close()
    return res

def write_seq (sequences, prefix):
    for seq in sequences:
        f= open(prefix + Sequence.name + ".fasta" ,"w")
        f.write(Sequence.get_fasta())
        f.close()

infile = sys.argv[1]
prefix = sys.argv[2]

split_fasta(infile)


## todo checkout argparse modul for Python 