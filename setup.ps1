# RizeSurvivalMC Windows installer
$ErrorActionPreference = "Stop"
Set-Location (Split-Path -Parent $MyInvocation.MyCommand.Path)
$java = (& java -version 2>&1 | Select-Object -First 1)
if (-not $java -or $java -notmatch '"(\d+)' -or [int]$Matches[1] -lt 25) { throw "Java 25+ gerekli: https://adoptium.net/" }
function Get-Download($url,$path) { Write-Host "Indiriliyor: $path"; Invoke-WebRequest -Uri $url -OutFile $path }
$meta = Invoke-RestMethod "https://api.papermc.io/v2/projects/paper"
$mc = $meta.versions[-1]
$builds = Invoke-RestMethod "https://api.papermc.io/v2/projects/paper/versions/$mc/builds"
$b = $builds.builds | Where-Object { $_.channel -eq "default" } | Select-Object -Last 1
if (-not (Test-Path "paper.jar")) { Get-Download "https://api.papermc.io/v2/projects/paper/versions/$mc/builds/$($b.build)/downloads/$($b.downloads.application.name)" "paper.jar" }
New-Item -ItemType Directory -Force plugins | Out-Null
Get-Download "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot" "plugins/Geyser-Spigot.jar"
Get-Download "https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot" "plugins/floodgate-spigot.jar"
$loader = [uri]::EscapeDataString('["paper"]')
$game = [uri]::EscapeDataString('["' + $mc + '"]')
foreach ($slug in @("luckperms","essentialsx","vault","coreprotect","griefprevention","worldedit","worldguard","chunky","spark")) {
  try {
    $versions = Invoke-RestMethod "https://api.modrinth.com/v2/project/$slug/version?loaders=$loader&game_versions=$game"
    $v = $versions | Select-Object -First 1
    if (-not $v) { Write-Warning "$slug icin $mc uyumlu surum bulunamadi."; continue }
    $f = $v.files | Where-Object { $_.primary } | Select-Object -First 1
    if (-not $f) { $f = $v.files | Select-Object -First 1 }
    Get-Download $f.url ("plugins/" + $f.filename)
  } catch { Write-Warning "$slug indirilemedi: $($_.Exception.Message)" }
}
if (-not (Test-Path "server.properties")) { Copy-Item "server.properties.example" "server.properties" }
Write-Host "Kurulum tamamlandi. plugins klasorunu kontrol et; start.bat ile baslat."
