from pathlib import Path
import subprocess

for filename in Path('csv_data_directory/').rglob('*.csv'):
    print(filename)
    parquet_filename = str(filename).replace('.csv', '.parquet')
    print(parquet_filename)
    bashCommand = f"./csv_data_directory/csv2parquet --max-read-records=0 --header=true --compression=snappy {filename} {parquet_filename}"
    process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
    output, error = process.communicate()
    print("Outuput: ", output)
    print("Error: ", error)