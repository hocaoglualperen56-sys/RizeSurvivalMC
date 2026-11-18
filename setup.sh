#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
command -v java >/dev/null || { echo "Java 25+ kur: https://adoptium.net/" >&2; exit 1; }
JAVA_VERSION="$(java -version 2>&1 | head -n 1 | sed -E 's/.*version "([0-9]+).*/\1/')"
[[ "$JAVA_VERSION" -ge 25 ]] || { echo "Java 25+ gerekli. Bulunan: $JAVA_VERSION" >&2; exit 1; }
command -v curl >/dev/null
command -v python3 >/dev/null
META="$(curl -fsSL https://api.papermc.io/v2/projects/paper)"
VERSION="$(python3 -c 'import json,sys; print(json.load(sys.stdin)["versions"][-1])' <<< "$META")"
if [[ ! -f paper.jar ]]; then
  BUILDS="$(curl -fsSL "https://api.papermc.io/v2/projects/paper/versions/$VERSION/builds")"
  BUILD="$(python3 -c 'import json,sys; b=[x for x in json.load(sys.stdin)["builds"] if x.get("channel")=="default"]; print(b[-1]["build"])' <<< "$BUILDS")"
  NAME="$(python3 -c 'import json,sys; b=[x for x in json.load(sys.stdin)["builds"] if x.get("channel")=="default"]; print(b[-1]["downloads"]["application"]["name"])' <<< "$BUILDS")"
  curl -fL "https://api.papermc.io/v2/projects/paper/versions/$VERSION/builds/$BUILD/downloads/$NAME" -o paper.jar
fi
mkdir -p plugins
curl -fL https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot -o plugins/Geyser-Spigot.jar
curl -fL https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot -o plugins/floodgate-spigot.jar
python3 - "$VERSION" <<'PY'
import json,sys,urllib.parse,urllib.request,pathlib
mc=sys.argv[1]
for slug in ["luckperms","essentialsx","vault","coreprotect","griefprevention","worldedit","worldguard","chunky","spark"]:
    query=urllib.parse.urlencode({"loaders":json.dumps(["paper"]),"game_versions":json.dumps([mc])})
    url=f"https://api.modrinth.com/v2/project/{slug}/version?{query}"
    try:
        req=urllib.request.Request(url,headers={"User-Agent":"RizeSurvivalMC/1.0"})
        with urllib.request.urlopen(req,timeout=30) as response: versions=json.load(response)
        if not versions:
            print(f"UYARI: {slug}: {mc} icin uyumlu surum bulunamadi; atlandi.")
            continue
        files=versions[0].get("files",[])
        file=next((x for x in files if x.get("primary")),files[0] if files else None)
        if not file:
            print(f"UYARI: {slug}: dosya bulunamadi; atlandi.")
            continue
        print(f"Indiriliyor: {slug} {versions[0].get('version_number','')}")
        urllib.request.urlretrieve(file["url"],pathlib.Path("plugins")/file["filename"])
    except Exception as exc:
        print(f"UYARI: {slug} indirilemedi: {exc}")
PY
if [[ ! -f server.properties ]]; then cp server.properties.example server.properties; fi
echo "Kurulum tamamlandi. plugins klasorunu kontrol et; ./start.sh ile baslat."
echo "Ilk acilista EULA'yi okuyup kabul ediyorsan eula=true yap."
