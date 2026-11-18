# RizeSurvivalMC

Java + Bedrock uyumlu profesyonel Survival/SMP sunucusu. Hedef: 20–50 oyuncu.

## Eklenti paketi
- Geyser + Floodgate: Bedrock oyuncularinin Java sunucusuna katilmasi.
- LuckPerms: Rütbe ve yetki yönetimi.
- EssentialsX: /spawn, /sethome, /home, /tpa, /warp ve temel yönetim komutlari.
- Vault: Ekonomi ve izin eklentileri arasinda entegrasyon köprüsü.
- CoreProtect: Blok degisikliklerini inceleme ve geri alma.
- GriefPrevention: Oyuncu arazi korumasi.
- WorldEdit + WorldGuard: Yetkililerin insa araçlari ve spawn/özel bölge korumasi.
- Chunky: Dünyayi önceden olusturarak kesif sirasindaki ani yükü azaltma.
- spark: TPS ve performans analizi.

Kurulum betikleri Modrinth API üzerinden sunucunun Minecraft sürümüyle uyumlu olarak listelenen Paper eklenti sürümlerini arar. Uyumlu sürüm yoksa eklentiyi atlar ve uyarı verir. Sunucuyu halka açmadan önce test et.

## Gereksinimler
- Windows PowerShell 5.1+ veya Linux
- Paper 26.1+ hedefi için Java 25+
- Linux kurulumunda curl ve Python 3
- 20–50 oyuncu için başlangıçta 6–8 GB sunucu RAM'i ve güçlü tek çekirdek performanslı CPU önerilir. Gerçek ihtiyaç dünya ve oyuncu yoğunluğuna göre değişir.

## Windows kurulumu
1. Depoyu Code → Download ZIP ile indirip çıkar.
2. Klasörde PowerShell aç.
3. powershell -ExecutionPolicy Bypass -File .\setup.ps1 komutunu çalıştır.
4. İndirme bitince plugins klasörünü kontrol et.
5. start.bat dosyasını aç. İlk açılışta eula.txt oluşur. Minecraft EULA'sını okuyup kabul ediyorsan eula=true yap.
6. start.bat dosyasını yeniden çalıştır.

## Linux kurulumu
    chmod +x setup.sh start.sh
    ./setup.sh
    ./start.sh

İlk açılışta eula.txt dosyasını okuyup kabul ediyorsan eula=true yap ve yeniden başlat.

## İlk yönetim ayarları
- Konsoldan kendini OP yap: op OYUNCU_ADIN.
- LuckPerms ile default, vip, moderator ve admin gruplarını oluştur; herkese OP verme.
- WorldGuard ile spawn alanını koru; WorldEdit erişimini yalnızca güvenilir yetkililere ver.
- GriefPrevention oyuncuların kendi arazilerini koruması içindir.
- CoreProtect kayıtlarını kontrol et; ayrıca dünya klasörlerinin ayrı yedeğini al.
- Ekonomi başlangıç bakiyesini ve oyuncu kazançlarını test etmeden sunucuyu açma.

## Bağlantı
- Java: sunucu adresi, 25565/TCP
- Bedrock: ayni adres, Geyser varsayilan portu 19132/UDP. Hosting panelinde UDP portunu ayır ve güvenlik duvarında aç.
- CGNAT varsa evden doğrudan port açmak çalışmayabilir; UDP destekli hosting/tünel kullan.
- online-mode=true açık kalmalı. Floodgate Bedrock kullanıcılarının Java hesabı olmadan katılmasını sağlar; Microsoft/Xbox hesabı gerekir.

## Güvenlik ve yedek
- GitHub sunucuyu 7/24 çalıştırmaz; bilgisayar veya Minecraft hosting gerekir.
- Dünya, oyuncu verileri ve JAR dosyalarını GitHub'a yükleme.
- RCON varsayılan olarak kapalı kalsın; OP yetkisini sınırlı tut.
- Her gün otomatik yedek ve farklı bir konumda kopya tut.
- Önce test dünyasında izinleri, arazi korumasını, geri almayı ve Bedrock girişini dene.

## Kaynaklar
- Paper: https://docs.papermc.io/paper/
- Geyser: https://geysermc.org/wiki/geyser/
- Floodgate: https://geysermc.org/wiki/floodgate/
- Modrinth API: https://docs.modrinth.com/api/


## Başlangıç menüsü ve NPC'ler
- Ana menü YAML dosyası: configs/CommandPanels/panels/menu.yml
- Kurulum betikleri menüyü plugins/CommandPanels/panels/menu.yml konumuna kopyalar.
- Oyuncular /menu komutuyla ana menüyü açabilir.
- CommandPanels, menüyü Java ve Floodgate üzerinden Bedrock oyuncularına uygun biçimde yönlendirecek Floodgate panel özelliğine sahiptir; bu projedeki ilk menü klasik envanter GUI'sidir. Bedrock istemcilerinde görsel uyumu ayrıca test et.
- FancyNpcs ile skinli NPC'ler kurulur. Oyuncunun bulunduğu spawn noktasında NPC oluşturmak için NPC_SETUP.md dosyasındaki komutları oyunda OP olarak uygula.
- Örnek NPC skinleri: Notch, jeb_ ve Steve. İsimleri istersen kendi seçtiğin Minecraft oyuncu adlarıyla değiştirebilirsin.
- İlk kurulumda /setspawn komutuyla spawn noktasını belirle.

## İlave eklentiler
CommandPanels: ana menü ve GUI panelleri.
FancyNpcs: skin, isim ve tıklama etkileşimli NPC'ler.
