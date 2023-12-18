#!/bin/bash

# --------------------------------------------------------------------------------
# ---------------------------------- USER INPUT ----------------------------------
model="sup" # Choose from "fast", "hac" or "sup"
outputBaseDir="/data/sequencing_data/P_larvae__M_plutonius_12-12-23/P_larvae__M_plutonius_12-12-23/20231212_1539_X2_FAX39573_9ecace85"
inputBarcodeDir="/data/sequencing_data/P_larvae__M_plutonius_12-12-23/P_larvae__M_plutonius_12-12-23/20231212_1539_X2_FAX39573_9ecace85/pod5_pass"
# -------------------------------- End User Input --------------------------------
# --------------------------------------------------------------------------------
outputParentDirName=$model"_fastq_pass"
outputDir=$outputBaseDir/$outputParentDirName

# For the outer loop the barcode directory pathways are discovered using find
barcodeNumPaths=($(find $inputBarcodeDir -maxdepth 2 -type d -name *"barcode"*))
# First loop through the input barcode directories and write output parent directory 
# and the output barcode directories
	# Then get the input pod5 files for each barcode directory
	# - Create a parent output directory
	# - Create directories for each barcode and output all fastq files for that barcode
		# Fastq files converted from pod5 using "dorado basecaller"
for Pod5Barcodes in "${barcodeNumPaths[@]}"; do
    # Output Directory
    barcodeOutName=${Pod5Barcodes##*/}
    outputBarcodeDir=$outputDir/$barcodeOutName
    if [ -e "$outputBarcodeDir" ]; then
        echo "Folder exists!"
    else
        mkdir -p "$outputBarcodeDir"
        if [ $? -eq 0 ]; then
            echo "Creating folder: $outputBarcodeDir"
        else
            echo "Error creating folder: $outputBarcodeDir"
            exit 1
        fi
    fi

    # The input pod5 files for each barcode
    pod5Files=($(find "$Pod5Barcodes" -maxdepth 2 -type f -name *".pod5"))
    for currentPod5File in "${pod5Files[@]}"; do
        echo $currentPod5File
        outputFileNameBase=${currentPod5File##*/}
        outputFileName=${outputFileNameBase%.pod5}.fastq
        outputFastqPath=$outputBarcodeDir/$outputFileName

        dorado basecaller $model $currentPod5File --emit-fastq > $outputFastqPath
			# # The below code is just for testing
			# echo "dorado basecaller $model $currentPod5File --emit-fastq > $outputFastqPath"
    done
done

