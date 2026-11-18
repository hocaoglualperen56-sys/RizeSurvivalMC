#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if ! command -v java >/dev/null 2>&1; then
  echo "Java bulunamadi. Java 25 veya ustunu kur: https://adoptium.net/" >&2
  exit 1
fi
JAVA_VERSION="$(java -version 2>&1 | head -n 1 | sed -E 's/.*version "([0-9]+).*/\1/')"
if [[ "$JAVA_VERSION" -lt 25 ]]; then
  echo "Paper 26.1+ icin Java 25+ gerekli. Bulunan: $JAVA_VERSION" >&2
  exit 1
fi

if [[ ! -f paper.jar ]]; then
  META="$(curl -fsSL https://api.papermc.io/v2/projects/paper)"
  VERSION="$(python3 -c 'import json,sys; print(json.load(sys.stdin)["versions"][-1])' <<< "$META")"
  BUILDS="$(curl -fsSL "https://api.papermc.io/v2/projects/paper/versions/$VERSION/builds")"
  BUILD="$(python3 -c 'import json,sys; b=[x for x in json.load(sys.stdin)["builds"] if x.get("channel")=="default"]; print(b[-1]["build"])' <<< "$BUILDS")"
  NAME="$(python3 -c 'import json,sys; b=[x for x in json.load(sys.stdin)["builds"] if x.get("channel")=="default"]; print(b[-1]["downloads"]["application"]["name"])' <<< "$BUILDS")"
  curl -fL "https://api.papermc.io/v2/projects/paper/versions/$VERSION/builds/$BUILD/downloads/$NAME" -o paper.jar
else
  echo "paper.jar zaten var; tekrar indirilmedi."
fi

mkdir -p plugins
curl -fL https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot -o plugins/Geyser-Spigot.jar
curl -fL https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot -o plugins/floodgate-spigot.jar

if [[ ! -f server.properties ]]; then cp server.properties.example server.properties; fi
echo "Kurulum tamamlandi. ./start.sh ile baslat."
echo "Ilk acilista eula.txt olusacak. EULA'yi okuyup kabul edersen eula=true yap."
