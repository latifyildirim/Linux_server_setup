# Linux_server_setup

[How to Setup SSH Passwordless Login in Linux ](https://www.tecmint.com/ssh-passwordless-login-using-ssh-keygen-in-5-easy-steps/)

 

### Yeni User ve Sudo yetkisi
```bash
sudo adduser yeni_kullanici_adi
sudo usermod -aG sudo yeni_kullanici_adi
```
 

### Kendi makinamizda Keygen olusturup bu adimlari takip ettik
```bash
ssh-keygen -t rsa      
ssh-copy-id username@server_ip
ssh username@server_ip "chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"
```
 

### Serverda Config dosyasini degistiriyoruz
```bash
sudo vi /etc/ssh/sshd_config  bu klasör altinda            
=> PubkeyAuthentication yes
=> PasswordAuthentication no 
sudo systemctl restart sshd   
```
### IPv6 devre dışı bırakma
```bash
sudo vi /etc/sysctl.conf
```
### Dosyanın sonuna aşağıdaki satırları ekleyin:
```bash
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
```
### Değişiklikleri Kaydetme ve Sisteme Yükleme:
```bash
sudo sysctl -p
```
### IPv6 Devre Dışı Bırakılmasını Doğrulama:
```bash
cat /proc/sys/net/ipv6/conf/all/disable_ipv6
```
#Eğer bu komut 1 çıktısı verirse, IPv6 başarıyla devre dışı bırakılmış demektir.
 
```bash
sudo crontab -e
* * * * * /path/to/your/command
sudo chmod 600 /etc/crontab #Sadece root kullanıcısının cron yapılandırmasını düzenleyebilmesi için,
                            #cron yapılandırma dosyasının erişimini sınırlandirir.
```
### Firewall setup
```bash
sudo ufw enable
sudo netstat -an | grep "LISTEN" # Açık olan portları daha kolay bulmak için
sudo apt-get install net-tools   # Eger “netstat” yüklü degilse
chmod +x ufw_ayar.sh             # ufw_ayar.sh dosyasini klasörde bulabilirsin.
./ufw_ayar.sh
```
### Task Manager Install (htop):
```bash
wget dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm rpm -ihv epel-release-7-11.noarch.rpm
sudo apt-get install htop
htop
```
### pm2 yüklemek icin nodejs in yüklü oldugundan emin olmali
### nodejs kurulumu
```bash
cd ~
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/nodesource-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/nodesource-archive-keyring.gpg] https://deb.nodesource.com/node_16.x $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/nodesource.list

sudo apt update
sudo apt install nodejs -y

node -v
npm -v
```
### Eger pakerletde sorun varsa düzeltme komutu kullan
```bash
sudo apt --fix-broken install
sudo apt-get autoremove # Bagli paketleri kaldirma
sudo apt update
sudo apt upgrade #Sistem güncelleme
sudo apt install aptitude #Sorun yasanmaya devam ederse paket yöneticisi degistirme
sudo aptitude install nodejs npm
node -v
npm -v
```
### pm2 yükleme ###
```bash
sudo npm install pm2 -g
pm2 --version
pm2 start app.js
```
