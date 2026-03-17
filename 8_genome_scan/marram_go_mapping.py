from collections import defaultdict
import argparse

parser = argparse.ArgumentParser(
    description="Map Marram genes to GO terms via UniProt IDs"
)

parser.add_argument(
    "-u", "--uniprot2go",
    required=True,
    help="File mapping UniProt IDs to GO terms"
)

parser.add_argument(
    "-m", "--marram2uniprot",
    required=True,
    help="File mapping Marram genes to UniProt IDs"
)

parser.add_argument(
    "-o", "--output",
    required=True,
    help="Output file for Marram gene to GO term mapping"
)

args = parser.parse_args()

# load uniprot-to-GO terms
uniprot2go = defaultdict(set)
with open(args.uniprot2go) as f:
    for line in f:
        u, go = line.strip().split()
        uniprot2go[u].add(go)

# load marram genes-to-uniprot
marram2uniprot = {}
with open(args.marram2uniprot) as f:
    for line in f:
        m, u = line.strip().split()
        marram2uniprot[m] = u

# build marram genes-to-GO terms
marram2go = defaultdict(set)
for m, u in marram2uniprot.items():
    marram2go[m].update(uniprot2go.get(u, []))

# write output
with open(args.output, "w") as out:
    for gene, gos in marram2go.items():
        if gos:
            out.write(gene + "\t" + ",".join(sorted(gos)) + "\n")