# Linux_server_setup

[How to Setup SSH Passwordless Login in Linux ](https://www.tecmint.com/ssh-passwordless-login-using-ssh-keygen-in-5-easy-steps/)

 

Yeni User ve Sudo yetkisi
"""
$sudo adduser yeni_kullanici_adi
$sudo usermod -aG sudo yeni_kullanici_adi
"""
 

Kendi makinamizda Keygen olusturup bu adimlari takip ettik
$ssh-keygen -t rsa      
$ssh-copy-id username@server_ip
$ ssh username@server_ip "chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"

 

Serverda Config dosyasini degistiriyoruz

$sudo vi /etc/ssh/sshd_config  bu klasör altinda            
=> PubkeyAuthentication yes

=> PasswordAuthentication no 

$sudo systemctl restart sshd   

#IPv6 devre dışı bırakma

sudo vi /etc/sysctl.conf
// Dosyanın sonuna aşağıdaki satırları ekleyin:

net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1

// Değişiklikleri Kaydetme ve Sisteme Yükleme:
sudo sysctl -p

// IPv6 Devre Dışı Bırakılmasını Doğrulama:
cat /proc/sys/net/ipv6/conf/all/disable_ipv6
#Eğer bu komut 1 çıktısı verirse, IPv6 başarıyla devre dışı bırakılmış demektir.
 
