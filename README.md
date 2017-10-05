To install the database:
1. Download the 'Pagila Database' folder, and extract the zip file.
2. In your command line, change your directory to the folder.
3. Create a database named 'Pagila' in postgres
4. Run psql in the command line (psql -u postgres)
5. Connect to the Pagila database in postgres (\c pagila)
6. Insert the files into the database in this exact order: pagilaschema.sql > pagilainsertdata.sql > pagiladata.sql (\i filename.sql)
7. Done. \q to quit.
