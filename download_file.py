# Téléchargement des fichier csv
import requests
import gzip
import shutil

url_template = 'https://files.data.gouv.fr/geo-dvf/latest/csv/{}/full.csv.gz'
start_year = 2018
end_year = 2022

for year in range(start_year, end_year+1):
    url = url_template.format(year)
    response = requests.get(url, stream=True)
    file_name = f'{year}.csv.gz'
    with open(file_name, 'wb') as f:
        for chunk in response.iter_content(chunk_size=128):
            f.write(chunk)
    with gzip.open(file_name, 'rb') as f_in:
        with open(f'{year}.csv', 'wb') as f_out:
            shutil.copyfileobj(f_in, f_out)
    print(f'Finished downloading and decompressing {year}.csv.gz')
