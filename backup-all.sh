# /bin/bash

# parameters
dir="mysql-backup-$(date '+%Y-%m-%d_%Hh%M')"

echo "creatig temporary dir $dir"
mkdir $dir

echo "listing databases"
dbList=`mysql -h $DB_HOST -u $DB_USERNAME -p"$DB_PASSWORD" -e'show databases;'`
dbList=${dbList##Database}

echo "authenticating with backblaze"
b2 authorize-account $B2_KEY_ID $B2_KEY

for DB in $dbList;
do
echo "---"
echo "start processing $DB"

filename=${DB}.sql.gz
remoteFilename="${DB}_$(date '+%Y-%m-%d_%Hh%M').sql.gz"
remoteFilePath="$(date '+%Y')/$(date '+%B')/$(date '+%d')/$(date '+%Hh%M')/${remoteFilename}"

echo "exporting"
mysqldump -h $DB_HOST -u $DB_USERNAME -p"$DB_PASSWORD" $DB --single-transaction | gzip > $dir/$filename

echo 'uploading to backblaze B2'
b2 upload-file $B2_BUCKET $dir/$filename $remoteFilePath

echo "done"
done

echo "---"

echo "removing temporary dir $dir"
rm -r $dir
