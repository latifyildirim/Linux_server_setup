Azure Container Registry (ACR) ve Azure Kubernetes Service (AKS) gibi Azure hizmetleri, başlangıçta birlikte kullanıldığında, AKS'nin ACR'den Docker imajlarını çekebilmesi için entegre bir şekilde çalışır. Ancak bu işlem için belirli yetkilendirmelerin yapılması gerekmektedir. İşte bu yetkilendirmeleri yapma süreci:

1. **ACR Yetkilendirmesi:**
   - İlk adım olarak, AKS'nin ACR ile iletişim kurabilmesi için bir "Service Principal" oluşturmalısınız. Service Principal, ACR'deki imajlara erişim yetkisine sahip bir kimlik doğrulama yöntemidir.
   - Azure Portal'da ACR'ye gidin ve ACR'yi seçin.
   - "Access control (IAM)" bölümüne gidin ve "Add a role assignment" düğmesine tıklayarak Service Principal'a roller atayın. Örneğin, "AcrPull" rolünü atayabilirsiniz.

2. **AKS Ayarları:**
   - AKS kümenize ait bir Kubernetes secret oluşturmalısınız. Bu secret, ACR kimlik bilgilerinizi depolayacaktır.
   - Aşağıdaki komut ile Kubernetes secret oluşturabilirsiniz:
     ```
     kubectl create secret docker-registry acr-secret --docker-server=myregistry.azurecr.io --docker-username=ACR_KULLANICI_ADI --docker-password=ACR_PAROLA --docker-email=ACR_EMAIL
     ```
     Burada, `myregistry.azurecr.io` ACR adresinizi, `ACR_KULLANICI_ADI` ACR kullanıcı adınızı, `ACR_PAROLA` ACR şifrenizi ve `ACR_EMAIL` ACR ile ilişkilendirilmiş bir e-posta adresini temsil etmelidir.

3. **Deployment YAML Ayarları:**
   - Kubernetes Deployment YAML dosyanızda, kullanmak istediğiniz Docker imajını doğru şekilde belirtmelisiniz.
   - Aynı zamanda Deployment YAML dosyanızın `spec.containers.imagePullSecrets` alanını oluşturduğunuz secret ile doldurmalısınız.
   
   Örnek:
   ```
   spec:
     containers:
     - name: myapp-container
       image: myregistry.azurecr.io/myapp:v1
     imagePullSecrets:
     - name: acr-secret
   ```

Bu ayarlar, AKS'nin ACR'den Docker imajlarını çekebilmesi için gerekli olan temel yapılandırmalardır. İmajların doğru bir şekilde çekilmesini sağlamak için bu adımları takip etmelisiniz.
