# Restore CT102 dumps into local Docker volumes and start the stack.
$ErrorActionPreference = "Stop"
$Infra = Split-Path -Parent $PSScriptRoot
Set-Location $Infra
$Data = Join-Path $Infra "local-data"
$Compose = "docker-compose.local.yaml"

function Test-Docker {
    cmd /c "docker info >nul 2>&1"
    if ($LASTEXITCODE -ne 0) {
        throw "Docker Desktop no esta corriendo. Abri Docker Desktop y reintenta."
    }
}

function Wait-Mysql {
    $deadline = (Get-Date).AddMinutes(2)
    do {
        cmd /c "docker exec mysql-db-local mysqladmin ping -h 127.0.0.1 -uroot -ppassword --silent >nul 2>&1"
        if ($LASTEXITCODE -eq 0) { return }
        if ((Get-Date) -gt $deadline) { throw "MySQL no contesto a tiempo." }
        Start-Sleep -Seconds 3
    } while ($true)
}

Test-Docker

$mysqlDump = Join-Path $Data "mysql-propinq.sql"
$mongoDump = Join-Path $Data "mongo.archive.gz"
$mbDump = Join-Path $Data "metabase.tgz"
if (-not (Test-Path $mysqlDump)) {
    throw "Falta $mysqlDump. Corre scripts\pull-homeserver-backup.ps1"
}

Write-Host "Starting MySQL and Mongo..."
docker compose -f $Compose up -d mysql-db mongodb
Wait-Mysql

Write-Host "Restoring MySQL propinq..."
cmd /c "docker exec -i mysql-db-local mysql -uroot -ppassword propinq < `"$mysqlDump`""
if ($LASTEXITCODE -ne 0) { throw "Fallo el restore de MySQL." }

if (Test-Path $mongoDump) {
    Write-Host "Restoring Mongo..."
    cmd /c "docker exec -i mongodb-local mongorestore --archive --gzip < `"$mongoDump`""
}

if (Test-Path $mbDump) {
    Write-Host "Restoring Metabase volume..."
    docker compose -f $Compose up -d metabase
    Start-Sleep -Seconds 4
    docker compose -f $Compose stop metabase
    docker run --rm `
      -v propinq-local_metabase-data:/data `
      -v "${Data}:/backup:ro" `
      alpine sh -c "find /data -mindepth 1 -delete; tar xzf /backup/metabase.tgz -C /data"
}

Write-Host "Starting full stack..."
docker compose -f $Compose up -d

Write-Host ""
Write-Host "App:      http://localhost:8088"
Write-Host "API:      http://localhost:8080"
Write-Host "Metabase: http://localhost:3030"
Write-Host "Espera ~1 min a que arranque Spring Boot."
