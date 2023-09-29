#!/bin/bash

# Bu betik, belirtilen portları açık bırakacak şekilde ufw kurallarını ayarlar.

# Bu komutlar sadece root (sudo) yetkileri ile çalıştırılabilir.
if [ "$EUID" -ne 0 ]; then
  echo "Bu scripti çalıştırmak için root (sudo) yetkilerine sahip olmalısınız."
  exit 1
fi

# UFW'yi etkinleştir
ufw enable

# Etkinleştirilmiş tüm ufw kurallarını temizle (mevcut kuralları kaldırmak için)
ufw --force reset

# Kapatmak veya açmak istediğiniz portları buraya ekleyin.
# Örnek: Kapatmak istediğiniz portlar -> PORTS_TO_DENY=(53 80)
#        Açmak istediğiniz portlar -> PORTS_TO_ALLOW=(8080 9000)
PORTS_TO_DENY=(32768) 
declare -a PORTS_TO_ALLOW=("21" "22" "25" "53" "106" "110" "143" "465" "953" "993" "995" "3030" "3306" "4190" "7080" "7081" "8443" "8880" "12346" "12768" "35799" "40785")

# Bağlantıları kaptmak için döngü
for port in "${PORTS_TO_DENY[@]}"
do
  echo "Port $port kapatılıyor..."
  ufw deny "$port"/tcp
  ufw deny "$port"/udp
done

# Bağlantıları eklemek için döngü
for port in "${PORTS_TO_ALLOW[@]}"
do
    # TCP bağlantıları
    ufw allow $port/tcp  
done
ufw allow 53/udp

# UFW'yi yeniden yükle
ufw reload
ufw enable
ufw status
echo "UFW kuralları başarıyla güncellendi."

