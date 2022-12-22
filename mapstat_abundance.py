#!/usr/bin/env python3

import pandas as pd
from pathlib import Path

# Path to dir with mapstat files
PATH = ''

mapstat_files = [] 
for mfile in Path(PATH).glob('*.mapstat'):
    df = pd.read_csv(mfile, skiprows=6, sep='\t')
    cols = list(df.columns)
    # strip trailing hash from columns
    cols[0] = cols[0].replace('# ', '')
    df.columns = cols
    # add sample name to mapstat file
    df['sample_name'] = mfile.name.replace('.mapstat', '')
    mapstat_files.append(df)
# concatinate tables
catmapstat = pd.concat(mapstat_files)
# create a pivot table with samples as rows and features as columns
abundance_tbl = catmapstat.pivot(index='sample_name', columns='refSequence', values='fragmentCountAln')
# replace null values with zeros
abundance_tbl = abundance_tbl.fillna(0)

abundance_tbl.to_csv(r'.csv', index = False, 
header=True)
