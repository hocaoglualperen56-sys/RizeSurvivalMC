# RizeSurvivalMC - Spawn NPC kurulumu

Bu adımlar sunucu ilk kez açıldıktan sonra oyunda OP olan hesapla yapılır.
NPC'ler oyuncunun bulunduğu yere konur. Önce spawn alanında dur; sonra komutları sırayla uygula.

## 1) Ana menü NPC'si
/npc create rehber
/npc displayname rehber <gradient:#19d3ff:#8cffc7><bold>RIZE SURVIVAL</bold></gradient> <gray>• <white>Ana Menü</white>
/npc skin rehber Notch
/npc turn_to_player rehber true
/npc action rehber RIGHT_CLICK add player_command menu
/npc move_here rehber

## 2) Ekonomi NPC'si
/npc create ekonomi
/npc displayname ekonomi <gold><bold>EKONOMI</bold> <gray>• <yellow>Bakiyeni Gör
/npc skin ekonomi jeb_
/npc turn_to_player ekonomi true
/npc action ekonomi RIGHT_CLICK add player_command balance
/npc move_here ekonomi

## 3) Yardım NPC'si
/npc create yardim
/npc displayname yardim <aqua><bold>REHBER</bold> <gray>• <white>Komutlar
/npc skin yardim Steve
/npc turn_to_player yardim true
/npc action yardim RIGHT_CLICK add message <green>Hoş geldin! <white>/menu <gray>ana menüyü açar. <white>/spawn <gray>başlangıç alanına döndürür. <white>/sethome <gray>evini kaydeder.
/npc move_here yardim

## Önemli
- Notch, jeb_ ve Steve Minecraft oyuncu adları örnek skin kaynaklarıdır. Beğenmezsen /npc skin NPC_ADI OYUNCU_ADI ile değiştir.
- NPC'leri farklı yerlere yerleştirmek için her NPC'de /npc move_here NPC_ADI komutunu, o NPC'nin durmasını istediğin yerde çalıştır.
- Menü komutu /menu. Oyuncular sohbetten /menu yazarak da açabilir.
- Spawn konumunu belirlemek için spawn alanının ortasında durup /setspawn çalıştır. EssentialsX'te bu komut mevcut.
- FancyNpcs NPC'leri Paper üzerinde çalışır. Skin yüklenmesi için sunucunun internet erişimi olmalı.
- NPC komutlarını konsola değil, oyunda OP yetkili oyuncu olarak yaz. Böylece move_here bulunduğun konumu kullanır.
