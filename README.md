## A simple docker image with a script to backup a database to a b2 backblaze cloud.

### Required environment variables :
- DB_HOST : the mysql server's address
- DB_DATABASE : the database you wish to backup
- DB_USERNAME : a user that have access to the said database, preferably read only
- DB_PASSWORD : the user's password
- B2_BUCKET : the backblaze b2 bucket you wish to backup to
- B2_KEY_ID : the b2 key id
- B2_KEY : the b2 key

### Usage :
inside the instance : 
``` bash backup.sh ```