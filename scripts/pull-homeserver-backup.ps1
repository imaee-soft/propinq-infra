# Pull MySQL / Mongo / Metabase dumps from CT102 (servidor-propinq).
$ErrorActionPreference = "Stop"
$Infra = Split-Path -Parent $PSScriptRoot
$Dest = Join-Path $Infra "local-data"
New-Item -ItemType Directory -Force -Path $Dest | Out-Null

Write-Host "Dumping on servidor-propinq..."
ssh -o BatchMode=yes servidor-propinq @'
set -e
mkdir -p /tmp/propinq-local-backup
docker exec mysql-db-prod mysqldump -uroot -ppassword --single-transaction --routines --triggers --set-gtid-purged=OFF propinq > /tmp/propinq-local-backup/mysql-propinq.sql
docker exec mongodb-prod mongodump --archive=/tmp/mongo.archive.gz --gzip
docker cp mongodb-prod:/tmp/mongo.archive.gz /tmp/propinq-local-backup/mongo.archive.gz
docker run --rm -v infra_metabase-data:/data -v /tmp/propinq-local-backup:/backup alpine tar czf /backup/metabase.tgz -C /data .
ls -lh /tmp/propinq-local-backup
'@

Write-Host "Copying dumps..."
scp -o BatchMode=yes `
  servidor-propinq:/tmp/propinq-local-backup/mysql-propinq.sql `
  servidor-propinq:/tmp/propinq-local-backup/mongo.archive.gz `
  servidor-propinq:/tmp/propinq-local-backup/metabase.tgz `
  "$Dest/"

Get-ChildItem $Dest | Format-Table Name, Length
Write-Host "OK. Next: powershell -File scripts\restore-local.ps1"
