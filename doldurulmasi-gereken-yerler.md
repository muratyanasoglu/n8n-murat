# Doldurulması Gereken Yerler

Bu dosya, n8n Google Drive 5S Düzenleyici projesini çalıştırmak için doldurmanız gereken tüm bilgileri içerir.

## 🔑 1. Google Cloud Console Ayarları

### Google Drive API Etkinleştirme

- [ ] Google Cloud Console'da yeni proje oluşturun
- [ ] Google Drive API'yi etkinleştirin
- [ ] OAuth 2.0 kimlik bilgileri oluşturun

### OAuth 2.0 Bilgileri

```
Client ID: ________________________
Client Secret: ____________________
```

**Nereden Alınır:**

1. [Google Cloud Console](https://console.cloud.google.com/) → APIs & Services → Credentials
2. "Create Credentials" → "OAuth 2.0 Client IDs"
3. Application type: "Web application"
4. Authorized redirect URIs: `http://localhost:5678/rest/oauth2-credential/callback`

## 🔐 2. .env Dosyası Ayarları

### Temel Kimlik Doğrulama

```env
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=____________________
```

**Doldurulacak:** Güçlü bir şifre belirleyin (en az 12 karakter, büyük/küçük harf, sayı, özel karakter)

### Google Drive API Bilgileri

```env
GOOGLE_CLIENT_ID=____________________
GOOGLE_CLIENT_SECRET=____________________
```

**Doldurulacak:** Google Cloud Console'dan aldığınız Client ID ve Secret

### Şifreleme Anahtarı

```env
N8N_ENCRYPTION_KEY=____________________
```

**Doldurulacak:** 32 karakterlik rastgele anahtar
**Örnek:** `a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6`

### Google Drive Klasör ID'leri

```env
ORGANIZATION_ROOT_FOLDER_ID=____________________
BACKUP_FOLDER_ID=____________________
```

**Klasör ID'si Nasıl Bulunur:**

1. Google Drive'da klasörü açın
2. URL'deki son kısmı kopyalayın
3. Örnek: `https://drive.google.com/drive/folders/1ABC123DEF456` → ID: `1ABC123DEF456`

## 📁 3. Google Drive Klasör Yapısı

### Oluşturmanız Gereken Klasörler

- [ ] **Ana Düzenleme Klasörü** (ORGANIZATION_ROOT_FOLDER_ID)

  - [ ] `01_Belgeler`
    - [ ] `PDF_Dosyalar`
    - [ ] `Word_Dosyalar`
    - [ ] `Metin_Dosyalar`
  - [ ] `02_Tablolar`
    - [ ] `Excel_Dosyalar`
    - [ ] `CSV_Dosyalar`
  - [ ] `03_Sunumlar`
    - [ ] `PowerPoint_Dosyalar`
  - [ ] `04_Medya`
    - [ ] `Resimler`
    - [ ] `Videolar`
    - [ ] `Ses_Dosyalar`
  - [ ] `05_Arsiv`
    - [ ] `Eski_Dosyalar`
  - [ ] `06_Duplicates`
    - [ ] `Tekrar_Eden_Dosyalar`
- [ ] **Yedek Klasörü** (BACKUP_FOLDER_ID)

  - [ ] `Yedekler`

## 🎯 4. 5S Konfigürasyon Ayarları

### Dosya Türü Kategorileri (İsteğe Bağlı Düzenleme)

```env
DOCUMENT_EXTENSIONS=pdf,doc,docx,txt,rtf
SPREADSHEET_EXTENSIONS=xls,xlsx,csv,ods
PRESENTATION_EXTENSIONS=ppt,pptx,odp
IMAGE_EXTENSIONS=jpg,jpeg,png,gif,bmp,svg,webp
VIDEO_EXTENSIONS=mp4,avi,mov,wmv,flv,mkv
AUDIO_EXTENSIONS=mp3,wav,flac,aac,ogg
ARCHIVE_EXTENSIONS=zip,rar,7z,tar,gz
```

### 5S Modül Ayarları

```env
ENABLE_SEIRI=true      # Gereksiz dosya tespiti
ENABLE_SEITON=true     # Dosya kategorilendirme
ENABLE_SEISO=true      # Duplicate temizleme
ENABLE_SEIKETSU=true   # Adlandırma standartları
ENABLE_SHITSUKE=true   # Düzenli bakım
```

## 📧 5. E-posta Bildirimleri (Opsiyonel)

### SMTP Ayarları

```env
SMTP_HOST=____________________
SMTP_PORT=____________________
SMTP_USER=____________________
SMTP_PASSWORD=____________________
NOTIFICATION_EMAIL=____________________
```

**Popüler SMTP Ayarları:**

- **Gmail:** smtp.gmail.com:587
- **Outlook:** smtp-mail.outlook.com:587
- **Yahoo:** smtp.mail.yahoo.com:587

## 🔄 6. Zamanlama Ayarları

### Otomatik Çalıştırma Zamanları

```env
DAILY_CLEANUP_TIME=02:00    # Günlük temizlik saati (24 saat formatı)
WEEKLY_REPORT_DAY=sunday    # Haftalık rapor günü
MONTHLY_ARCHIVE_DAY=1       # Aylık arşivleme günü
```

## 🗄️ 7. Veritabanı Ayarları (Production için)

### PostgreSQL Ayarları (Opsiyonel)

```env
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=localhost
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_DATABASE=n8n
DB_POSTGRESDB_USER=n8n
DB_POSTGRESDB_PASSWORD=____________________
```

## ✅ Kontrol Listesi

### Kurulum Öncesi

- [ ] Node.js 18+ kurulu
- [ ] npm 8+ kurulu
- [ ] Google Cloud Console hesabı mevcut
- [ ] Google Drive erişimi var

### Google Cloud Console

- [ ] Yeni proje oluşturuldu
- [ ] Google Drive API etkinleştirildi
- [ ] OAuth 2.0 kimlik bilgileri oluşturuldu
- [ ] Test kullanıcısı eklendi
- [ ] Client ID ve Secret kaydedildi

### Google Drive

- [ ] Ana düzenleme klasörü oluşturuldu
- [ ] Alt klasörler oluşturuldu
- [ ] Yedek klasörü oluşturuldu
- [ ] Klasör ID'leri kaydedildi

### .env Dosyası

- [ ] .env.example kopyalandı
- [ ] Tüm gerekli alanlar dolduruldu
- [ ] Şifreleme anahtarı oluşturuldu
- [ ] Google API bilgileri eklendi
- [ ] Klasör ID'leri eklendi

### n8n Konfigürasyonu

- [ ] n8n başlatıldı
- [ ] Admin paneline erişim sağlandı
- [ ] Google Drive credential oluşturuldu
- [ ] Workflow'lar içe aktarıldı

## 🚨 Güvenlik Uyarıları

1. **Asla paylaşmayın:**

   - Client Secret
   - Şifreleme anahtarı
   - Admin şifresi
   - .env dosyası
2. **Güçlü şifreler kullanın:**

   - En az 12 karakter
   - Büyük/küçük harf karışımı
   - Sayı ve özel karakter
3. **Düzenli güncelleyin:**

   - API anahtarları (6 ayda bir)
   - Admin şifresi (3 ayda bir)
   - Şifreleme anahtarı (yılda bir)

## 📞 Yardım

Herhangi bir alanda takılırsanız:

1. [Kurulum Rehberi](kurulum.md) dosyasını kontrol edin
2. [Çalıştırma Komutları](commands.md) dosyasına bakın
3. Google Cloud Console dokümantasyonunu inceleyin
4. n8n resmi dokümantasyonunu kontrol edin

## 📝 Notlar

- Tüm ID'ler ve anahtarlar büyük/küçük harfe duyarlıdır
- Klasör ID'leri Google Drive URL'sinden alınır
- Test ortamında önce küçük bir klasörle deneme yapın
- Production'a geçmeden önce yedek alın
