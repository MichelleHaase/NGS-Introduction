# Next gen sequencing
 * 1. Gen senger etc
 * 2. Gen much longer reads up to ~1 Billion
 * 3. Gen single-molecule sequencing

## 1st Gen
PCR - (Polymerase Chain reaction) replicates sequences according to 
primer, needs DNA(template), primer, reverse primer, oligopetides 
(buildingblocks), polymerase.

* the doublestrand is separated with Temperature, since primers bind
      faster that the whole strand(because of size) lowering the Tempbackdown 
      lets primer bind and polymerase work repeating this process gives a amount 
      of DNA copies with exponential replication rate.
    
* realtime PCR - needs probe that has a reporter and a quencher that give 
  a light feed back if destroyed, it binds inbetween the primer and
  reverse primer and gets destroyed by the Polymerase the reporter part
  then no longer quenched gives back a certain wavelength if activated
  (light) cT-val. - indicator for the amount of DNA was included, the higher 
  the Value the lower the DNA input since it took longer to get to a detectable 
  level of emitted light.

* Sanger Sequencing needs DNA, Primer, Polymerase, nucleotides(dNTPs - 
  dinucleotides Tri-Phosphates), ddNTPs where all types of nucleotides
  have different fluorescent marker attached eg A - Red, G - blue etc.
  first they sequence that needs to identified is multiplied(PCR)
  when a ddNTPs binds the strand ends since the polymerase cant keep
  building after a Fluo marker so different lenght pieces are made with
  a marker on the end correspomding to the last Base. those pieces are
  seperated in Chromatography(older Electrophoreses) so that they are ordered 
  by lenghth then the Bases are indentified by the fluo marker 
## 2nd Gen

* ilumina Seq as example the base concept are similar across most processes, 
  the library preperation processses vary everything after that is Ilumina
  and 2nd Gen sequencing
  
* trueseq :shotgun Sequencing start from double strand doesn't need to know primer
  Sequence. firstly the DNA is shredded (different forms exist) which leads to 
  fragmented pieces of DNA, ends are reapeared (blunted), then A-tailing is 
  done where an A is added to each end of the strand, since we now that all 
  strands have an overhanging A a known sequence with a overhanging T is introduced 
  (Nextterra adapters?) so now after the Nextterra Ligation each DNA fragment 
  ends and starts witch the known Sequence (Library) , to here the process is 
  called Library preperation. the library is washer on matrix so the known seq is 
  bound and therefore ends in a double strand stuck to matrix. now PCR with primer 
  for known seq, the polymerase will as usual stop at double strand. when the Temp 
  is lowered again the single strand part that was not bound to the matrix 
  (other side) binds to Matrix after a few reapeats a forest or cluster of the 
  unknown sequence stuck one side to the matrix with a known seq on the other
  (unbound) side(during high Temp). now dNTPS with markers(only those no unmarked 
  ones), primer and polymerase are added in each cycle the matrix is imaged. then 
  all fluo markers are flushed of, wich leaves the nucleotide bound and without 
  the marker able to have a nother  nuc bind in the next cycle. now each cluster 
  is analysed scince the clusters should be of the same seq. 

## 3rd Gen
* nanopor seq MinION - membrajn one side chared paticles other sind lot less -- 
  Electric gradient mampran has pores connected to meassuring so the current can 
  be meassured. Motorprotein pushes single strand DNA thru pore. at the narrwest 
  point in the point the charge is meassured and the amount of Ions corresponds 
  to the charge of the Base so with this does the charge thats mwassured. this 
  allows much bigger reads at once, so this is usually one-molecule-sequencing
  and no aplification or Librays are needed

* PacBio also uses fluo marker but with a immobilized polymerase the fluo is 
  meassured when the polymerase uses the dNTPs it emmites a small light pulse 
  for each discarded base and a longer one for a used one. the dNTPs are different
  from those used in 2nd Gen since the marker doesn't prevent further building the 
  strand.

