mkdir five_fungi
cd five_fungi

# download all the data
for pth in ftp://ftp.ensemblgenomes.org/pub/fungi/release-59/fasta/fungi_microsporidia1_collection/encephalitozoon_cuniculi_ecuniii_l_gca_001078035/dna/Encephalitozoon_cuniculi_ecuniii_l_gca_001078035.ECIIIL.dna_sm.toplevel.fa.gz \
ftp://ftp.ensemblgenomes.ebi.ac.uk/pub/fungi/release-59/gff3/fungi_microsporidia1_collection/encephalitozoon_cuniculi_ecuniii_l_gca_001078035/Encephalitozoon_cuniculi_ecuniii_l_gca_001078035.ECIIIL.59.gff3.gz \
ftp://ftp.ensemblgenomes.org/pub/fungi/release-59/fasta/fungi_microsporidia1_collection/nosema_ceranae_gca_000988165/dna/Nosema_ceranae_gca_000988165.ASM98816v1.dna_sm.toplevel.fa.gz \
ftp://ftp.ensemblgenomes.ebi.ac.uk/pub/fungi/release-59/gff3/fungi_microsporidia1_collection/nosema_ceranae_gca_000988165/Nosema_ceranae_gca_000988165.ASM98816v1.59.gff3.gz \
ftp://ftp.ensemblgenomes.org/pub/fungi/release-59/fasta/fungi_rozellomycota1_collection/rozella_allomycis_csf55_gca_000442015/dna/Rozella_allomycis_csf55_gca_000442015.Rozella_k41_t100.dna_sm.toplevel.fa.gz \
ftp://ftp.ensemblgenomes.ebi.ac.uk/pub/fungi/release-59/gff3/fungi_rozellomycota1_collection/rozella_allomycis_csf55_gca_000442015/Rozella_allomycis_csf55_gca_000442015.Rozella_k41_t100.59.gff3.gz \
ftp://ftp.ensemblgenomes.org/pub/fungi/release-59/fasta/candida_parapsilosis/dna/Candida_parapsilosis.GCA000182765v2.dna_sm.toplevel.fa.gz \
ftp://ftp.ensemblgenomes.ebi.ac.uk/pub/fungi/release-59/gff3/candida_parapsilosis/Candida_parapsilosis.GCA000182765v2.59.gff3.gz \
ftp://ftp.ensemblgenomes.org/pub/fungi/release-59/fasta/fungi_ascomycota3_collection/pneumocystis_jirovecii_ru7_gca_001477535/dna/Pneumocystis_jirovecii_ru7_gca_001477535.Pneu_jiro_RU7_V2.dna_sm.toplevel.fa.gz \
ftp://ftp.ensemblgenomes.ebi.ac.uk/pub/fungi/release-59/gff3/fungi_ascomycota3_collection/pneumocystis_jirovecii_ru7_gca_001477535/Pneumocystis_jirovecii_ru7_gca_001477535.Pneu_jiro_RU7_V2.59.gff3.gz 
do
  wget $pth
  sleep 0.4s
done

# uncompress the data
gunzip *.gz

# put the data in the format compatible with the --basedir parameter
# basically --basedir needs a folder <your_species>
# with a subfolder <your_species>/input containing a (compressed) gff3 annotation and fasta genome file.
# The results will then be located in <your_species>/output
# If desired, you can alternatively specify all file parameters individually
# --gff3 <your.gff3> --fasta <your.fa> --db-path <your_output_genuff.sqlite3> --log-file <your_output.log>
species="encephalitozoon_cuniculi_ecuniii nosema_ceranae rozella_allomycis candida_parapsilosis pneumocystis_jirovecii"

for sp in $species
do
  spdir=$sp/input
  mkdir -p $spdir
  mv ${sp}.* $spdir/
done

# import into databases (the main output will land in <basedir>/output/<species>.sqlite3
for sp in $species
do
  import2geenuff.py --basedir $sp --species $sp
done
cd ..
