# Kurulum Rehberi

## Ön Gereksinimler

### 1. Node.js ve npm Kurulumu
```bash
# Node.js versiyonunu kontrol edin
node --version  # v18.0.0 veya üzeri olmalı
npm --version   # v8.0.0 veya üzeri olmalı
```

### 2. Git Kurulumu
```bash
git --version
```

### 3. Docker Kurulumu (Opsiyonel)
```bash
docker --version
docker-compose --version
```

## Google Drive API Kurulumu

### 1. Google Cloud Console'da Proje Oluşturma
1. [Google Cloud Console](https://console.cloud.google.com/) adresine gidin
2. Yeni proje oluşturun veya mevcut projeyi seçin
3. "APIs & Services" > "Library" bölümüne gidin
4. "Google Drive API"yi arayın ve etkinleştirin

### 2. OAuth 2.0 Kimlik Bilgileri Oluşturma
1. "APIs & Services" > "Credentials" bölümüne gidin
2. "Create Credentials" > "OAuth 2.0 Client IDs" seçin
3. Application type: "Web application" seçin
4. Authorized redirect URIs ekleyin:
   - `http://localhost:5678/rest/oauth2-credential/callback`
5. Client ID ve Client Secret'ı kaydedin

### 3. Test Kullanıcıları Ekleme (Development Mode)
1. "APIs & Services" > "OAuth consent screen" bölümüne gidin
2. "Test users" bölümüne kendi e-posta adresinizi ekleyin

## Proje Kurulumu

### Yöntem 1: Manuel Kurulum

#### 1. Projeyi İndirin
```bash
cd /Users/neo/Desktop/PROJELER/n8n-murat
```

#### 2. Bağımlılıkları Yükleyin
```bash
npm install
```

#### 3. Çevre Değişkenlerini Ayarlayın
```bash
# .env.example dosyasını kopyalayın
cp .env.example .env

# .env dosyasını düzenleyin
nano .env
```

#### 4. n8n'i Başlatın
```bash
npm start
```

### Yöntem 2: Docker ile Kurulum

#### 1. Çevre Değişkenlerini Ayarlayın
```bash
cp .env.example .env
# .env dosyasını düzenleyin
```

#### 2. Docker Container'ları Başlatın
```bash
# Development için
docker-compose up -d

# Production için (PostgreSQL ile)
docker-compose --profile production up -d
```

## n8n Konfigürasyonu

### 1. n8n Arayüzüne Erişim
- Tarayıcınızda `http://localhost:5678` adresine gidin
- Kullanıcı adı: `admin`
- Şifre: `.env` dosyasında belirlediğiniz şifre

### 2. Google Drive Credential Oluşturma
1. n8n arayüzünde "Credentials" bölümüne gidin
2. "Create New" > "Google Drive OAuth2 API" seçin
3. Google Cloud Console'dan aldığınız bilgileri girin:
   - Client ID
   - Client Secret
   - Scope: `https://www.googleapis.com/auth/drive`
4. "Connect my account" butonuna tıklayın
5. Google hesabınızla yetkilendirme yapın

### 3. Workflow'ları İçe Aktarma
```bash
# Workflow'ları otomatik olarak içe aktarın
npm run import
```

## Konfigürasyon Dosyaları

### .env Dosyası Ayarları
Aşağıdaki değerleri mutlaka doldurun:

```env
# Temel Kimlik Doğrulama
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=güçlü_şifre_buraya

# Google Drive API
GOOGLE_CLIENT_ID=google_client_id_buraya
GOOGLE_CLIENT_SECRET=google_client_secret_buraya

# Şifreleme Anahtarı (32 karakter)
N8N_ENCRYPTION_KEY=32_karakterlik_güvenli_anahtar_buraya

# Google Drive Klasör ID'leri
ORGANIZATION_ROOT_FOLDER_ID=ana_klasör_id_buraya
BACKUP_FOLDER_ID=yedek_klasör_id_buraya
```

## Doğrulama

### 1. n8n Servisini Kontrol Edin
```bash
# Manuel kurulum için
curl http://localhost:5678/healthz

# Docker kurulum için
docker-compose ps
```

### 2. Google Drive Bağlantısını Test Edin
1. n8n arayüzünde "Test Workflow" oluşturun
2. Google Drive node ekleyin
3. "List Files" operasyonunu test edin

### 3. Workflow'ları Kontrol Edin
1. "Workflows" bölümünde 3 workflow olmalı:
   - Main Organizer
   - Duplicate Detector
   - Cleanup Scheduler

## Sorun Giderme

### Port Çakışması
```bash
# 5678 portunu kullanan işlemi bulun
lsof -i :5678

# İşlemi sonlandırın
kill -9 <PID>
```

### Docker Sorunları
```bash
# Container'ları yeniden başlatın
docker-compose down
docker-compose up -d

# Log'ları kontrol edin
docker-compose logs n8n
```

### Google API Sorunları
1. API kotalarını kontrol edin
2. OAuth consent screen durumunu kontrol edin
3. Redirect URI'ların doğru olduğundan emin olun

## Güvenlik Notları

1. `.env` dosyasını asla paylaşmayın
2. Güçlü şifreler kullanın
3. Production'da HTTPS kullanın
4. Düzenli olarak API anahtarlarını yenileyin
5. n8n'i güvenlik duvarı arkasında çalıştırın

## Sonraki Adımlar

Kurulum tamamlandıktan sonra:
1. [Doldurulması Gereken Yerler](doldurulmasi-gereken-yerler.md) dosyasını inceleyin
2. [Çalıştırma Komutları](commands.md) dosyasına bakın
3. İlk test çalıştırmasını yapın