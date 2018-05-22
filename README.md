This is a README file describing how to use the `pull_variant.sh` script

Just input Chromosome, Position, and Output file name (without the file
extension) as the argument to the script, like so:

```
./pull_variant.sh 4 89052323 ABCG2_rs2231142
```

Please note that this script should be run on the server (literally anywhere on
the server), **via ssh/terminal**.
It won't work with the server mounted onto your computer (since the path to the
West Polynesian data sets are hard-coded in the script, based on the server's
directory structure).

If you want to run it for multiple variants, make a file like `input.txt` in
this directory, and run the following:

```
while read LINE; do ./pull_variant.sh $LINE; done < input.txt
```

This should output the ped/map files specified in your `input.txt` file
