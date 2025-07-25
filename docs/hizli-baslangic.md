# 🔧 Hızlı Başlangıç Kılavuzu

Bu kılavuz, n8n Google Drive 5S Organizer projesini hızlıca çalıştırmanız için gerekli adımları içerir.

## ⚡ Hızlı Kurulum (5 Dakika)

### 1. Projeyi İndirin
```bash
git clone <repository-url>
cd n8n-murat
```

### 2. Otomatik Kurulum
```bash
npm run setup
```

### 3. Çevre Değişkenlerini Ayarlayın
```bash
# .env dosyasını düzenleyin
nano .env

# Minimum gerekli ayarlar:
GOOGLE_CLIENT_ID=your_google_client_id
GOOGLE_CLIENT_SECRET=your_google_client_secret
ORGANIZATION_ROOT_FOLDER_ID=your_root_folder_id
```

### 4. Projeyi Başlatın
```bash
npm start
```

### 5. n8n Arayüzüne Erişin
Tarayıcınızda: http://localhost:5678

## 🚀 Kullanım

### Workflow'ları İçe Aktarma
1. n8n arayüzünde "Import" butonuna tıklayın
2. `workflows/` klasöründeki JSON dosyalarını seçin
3. Workflow'ları aktifleştirin

### Google Drive Kimlik Bilgileri
1. n8n'de "Credentials" bölümüne gidin
2. "Google Drive OAuth2 API" seçin
3. Client ID ve Secret'ı girin
4. Google hesabınızla yetkilendirin

## 📁 Klasör Yapısı Oluşturma

Google Drive'ınızda şu klasörleri oluşturun:
```
📁 5S-Organize-Edilmis-Dosyalar/
├── 📁 01-Belgeler/
├── 📁 02-Elektronik-Tablolar/
├── 📁 03-Sunumlar/
├── 📁 04-Gorseller/
├── 📁 05-Videolar/
├── 📁 06-Ses-Dosyalari/
├── 📁 07-Arsiv-Dosyalari/
├── 📁 08-Kod-Dosyalari/
├── 📁 09-Kategorisiz/
├── 📁 Yedek/
│   ├── 📁 duplicates/
│   └── 📁 archive/
└── 📁 Raporlar/
```

## 🔄 Workflow'lar

### 1. Ana Organizatör (main-organizer.json)
- **Çalışma:** Her 6 saatte bir otomatik
- **İşlev:** Dosyaları kategorilere ayırır, duplikatları tespit eder

### 2. Duplikat Tespit (duplicate-detector.json)
- **Çalışma:** Webhook ile manuel
- **İşlev:** Gelişmiş duplikat analizi yapar

### 3. Temizlik Zamanlayıcı (cleanup-scheduler.json)
- **Çalışma:** Her gün saat 02:00
- **İşlev:** Eski dosyaları arşivler, geçici dosyaları temizler

### 4. Dosya Kategorilendirici (file-type-categorizer.json)
- **Çalışma:** Webhook ile manuel
- **İşlev:** Dosyaları türlerine göre kategorilere ayırır

## 🎯 5S Metodolojisi

### 1. Seiri (Ayıklama) ✅
- Gereksiz dosyaları tespit eder
- Eski dosyaları arşivler
- Geçici dosyaları temizler

### 2. Seiton (Düzenleme) ✅
- Dosyaları türlerine göre kategorilere ayırır
- Mantıklı klasör yapısı oluşturur
- Kolay erişim sağlar

### 3. Seiso (Temizlik) ✅
- Duplikat dosyaları tespit eder ve temizler
- Dosya adlarını standartlaştırır
- Özel karakterleri temizler

### 4. Seiketsu (Standartlaştırma) ✅
- Tutarlı adlandırma kuralları uygular
- Standart klasör yapısı kullanır
- Otomatik kategorilendirme sağlar

### 5. Shitsuke (Sürdürme) ✅
- Otomatik zamanlayıcılar çalıştırır
- Düzenli raporlar oluşturur
- Sürekli iyileştirme sağlar

## 🔧 Sorun Giderme

### Port Çakışması
```bash
# Farklı port kullanın
export N8N_PORT=5679
npm start
```

### Kimlik Bilgisi Hatası
```bash
# .env dosyasını kontrol edin
cat .env | grep GOOGLE
```

### Workflow İçe Aktarma Hatası
```bash
# Manuel import
npm run import:workflows
```

## 📞 Destek

- 📖 Detaylı kurulum: `docs/kurulum.md`
- 📝 Doldurulması gerekenler: `doldurulmasi-gereken-yerler.md`
- 💻 Tüm komutlar: `commands.md`

## 🎉 Başarılı Kurulum Kontrolü

Aşağıdaki adımları tamamladıysanız kurulum başarılıdır:

- ✅ n8n arayüzü açılıyor (http://localhost:5678)
- ✅ Google Drive kimlik bilgileri eklendi
- ✅ Workflow'lar içe aktarıldı
- ✅ Klasör yapısı oluşturuldu
- ✅ .env dosyası düzenlendi

**Artık Google Drive dosyalarınız 5S metodolojisine göre otomatik olarak organize edilecek!** 🚀