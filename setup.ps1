# RizeSurvivalMC Windows installer
$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $Root

$java = (& java -version 2>&1 | Select-Object -First 1)
if (-not $java) { throw "Java bulunamadi. Java 25 veya ustunu kurup PATH'e ekle: https://adoptium.net/" }
if ($java -notmatch '"(\d+)') { throw "Java surumu okunamadi: $java" }
$major = [int]$Matches[1]
if ($major -lt 25) { throw "Paper 26.1+ icin Java 25+ gerekli. Bulunan Java: $major" }

function Download-File($Url, $OutFile) {
  Write-Host "Indiriliyor: $OutFile"
  Invoke-WebRequest -Uri $Url -OutFile $OutFile
}

# Latest stable Paper release/build from the official PaperMC API
$project = Invoke-RestMethod "https://api.papermc.io/v2/projects/paper"
$version = $project.versions[-1]
$builds = Invoke-RestMethod "https://api.papermc.io/v2/projects/paper/versions/$version/builds"
$build = $builds.builds | Where-Object { $_.channel -eq "default" } | Select-Object -Last 1
if (-not $build) { throw "Paper icin kararlı build bulunamadi." }
$paperUrl = "https://api.papermc.io/v2/projects/paper/versions/$version/builds/$($build.build)/downloads/$($build.downloads.application.name)"
if (-not (Test-Path "paper.jar")) { Download-File $paperUrl "paper.jar" } else { Write-Host "paper.jar zaten var; tekrar indirilmedi." }

New-Item -ItemType Directory -Force -Path "plugins" | Out-Null
$geyser = "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot"
$floodgate = "https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot"
Download-File $geyser "plugins/Geyser-Spigot.jar"
Download-File $floodgate "plugins/floodgate-spigot.jar"

if (-not (Test-Path "server.properties")) {
  Copy-Item "server.properties.example" "server.properties"
}
Write-Host ""
Write-Host "Kurulum tamamlandi. start.bat dosyasini calistir."
Write-Host "Ilk acilista eula.txt olusacak. EULA'yi okuyup kabul edersen eula=true yap."
