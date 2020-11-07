# /bin/bash

filename=dump.sql
remoteFilename="${DB_DATABASE}_$(date '+%Y-%m-%d_%Hh%M').sql.gz"
remoteFilePath="${DB_DATABASE}/$(date '+%Y')/$(date '+%B')/$(date '+%d')/${remoteFilename}"

echo "exporting $DB_DATABASE database"
mysqldump -h $DB_HOST -u $DB_USERNAME -p"$DB_PASSWORD" $DB_DATABASE > $filename -v

echo "compressing $filename"
gzip $filename

echo "authenticating with backblaze"
b2 authorize-account $B2_KEY_ID $B2_KEY

echo "uploading $remoteFilename to backblaze B2"
b2 upload-file $B2_BUCKET $filename.gz $remoteFilePath