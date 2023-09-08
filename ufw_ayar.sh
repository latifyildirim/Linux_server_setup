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
PORTS_TO_DENY=() 
declare -a PORTS_TO_ALLOW=("953" "53" "3030" "3306" "4190" "53" "37527" "12346" "53" "53" "80" "443" "8443" "143" "110" "32768" "22" "25" "7081" "7080")

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
