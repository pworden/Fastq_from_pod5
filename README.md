# dorado_batch.sh

## A wrapper script using Oxford Nanopore's dorado app to convert pod5 files to fastq

<https://github.com/nanoporetech/dorado>

Run the script as follows:

```bash
bash dorado_batch.sh
```

1. Open the bash script in a text editor and add the appropriate information to the "User Input" section.
1. For the first line of the input section, write either "fast", "hac" or "sup".
   * The fastest conversion but lowest quality is "fast"
   * Intermediate is "hac"
   * The slowest conversion but highest quality is "sup"
1. For the **input** (second line in input section) add the path to the parent directory holding all the barcodes of the run.
1. For the **output** (third line in the input section) add the path of an existing directory that will serve as the parent output directory.

Given a parent input directory this script will then look for all barcode directories containing pod5 files, create the same barcode directories to hold the output, and then convert all input pod5 files into fastq files.

`Note: There are many other methods to obtain output, including different file types, which are described in the link above.`
