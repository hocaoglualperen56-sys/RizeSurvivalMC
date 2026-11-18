# RizeSurvivalMC

Java + Bedrock uyumlu, Survival odaklı Minecraft sunucusu. Hedef: 20–50 oyuncu.

## Gereksinimler
- Windows: PowerShell 5.1+ veya PowerShell 7
- **Java 25 veya üzeri** (Paper 26.1+ için)
- İlk kurulumda internet bağlantısı
- 20–50 oyuncu için başlangıçta 6–8 GB RAM ayırabilen, güçlü tek çekirdek performanslı CPU önerilir. Dünya ve eklentilere göre daha fazlası gerekebilir.

## Windows kurulumu
1. Bu depoyu bilgisayarına indir: **Code → Download ZIP** ve ZIP'i çıkar.
2. Klasörde PowerShell aç.
3. Şunu çalıştır:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\setup.ps1
   ```
4. Kurulum Paper sunucusunu ve Geyser + Floodgate eklentilerini indirir.
5. Sunucuyu ilk kez `start.bat` ile başlat. EULA dosyası oluşunca `eula.txt` içindeki `eula=false` değerini okuyup Minecraft EULA'sını kabul ediyorsan `true` yap.
6. Tekrar `start.bat` çalıştır.

## Linux kurulumu
```bash
chmod +x setup.sh start.sh
./setup.sh
./start.sh
```
İlk çalıştırmada oluşan `eula.txt` dosyasında EULA'yı okuyup kabul ediyorsan `eula=true` yap ve sunucuyu tekrar başlat.

## Bağlantı
- Java: sunucu-adresi, port **25565/TCP**
- Bedrock: aynı adres, port **19132** (Geyser'in yapılandırdığı TCP + UDP)
- Evden yayın yapacaksan güvenlik duvarı/yönlendiricide gerekli portları açman gerekir. Hosting alırsan sağlayıcının Bedrock için TCP ve UDP desteği verdiğini doğrula.
- İnternete açmadan önce güçlü bir yönetici parolası kullan; RCON varsayılan olarak kapalı kalsın.

## Önemli
- GitHub dosyaları saklar; sunucuyu 7/24 çalıştırmaz. Sunucunun açık kalması için kendi bilgisayarın veya Minecraft hosting gerekir.
- Dünya klasörleri, oyuncu verileri ve sunucu JAR'ı GitHub'a yüklenmez.
- `online-mode=true` açık kalır. Floodgate, Bedrock oyuncularının Java hesabı olmadan bağlanmasını sağlar; Bedrock oyuncularının Microsoft/Xbox hesabı gerekir.
- Eklentiler otomatik olarak GeyserMC'nin güncel indirme uç noktasından alınır. Güncelleme gerektiğinde `setup.ps1` / `setup.sh` tekrar çalıştırılabilir; mevcut dünya silinmez.

## Kaynaklar
- Paper: https://docs.papermc.io/paper/
- Geyser: https://geysermc.org/wiki/geyser/
- Floodgate: https://geysermc.org/wiki/floodgate/
