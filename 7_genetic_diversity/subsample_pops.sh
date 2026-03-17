N=7     # required sample size
SEED=42     

mkdir -p subsampled_lists_n7

for popfile in popfiles/*.txt; do
  popname=$(basename "$popfile" .txt)

  # shuffle and pick first N reproducibly
  shuf --random-source=<(yes $SEED) "$popfile" | head -n $N > subsampled_lists_n7/${popname}_picked.txt

  # report
  echo "Picked $(wc -l < subsampled_lists_n7/${popname}_picked.txt) samples for $popname"
done
