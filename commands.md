# Çalıştırma Komutları

Bu dosya, n8n Google Drive 5S Düzenleyici projesini çalıştırmak için kullanacağınız tüm komutları içerir.

## 🚀 Hızlı Başlangıç

### Tek Komutla Başlatma
```bash
# Proje dizinine gidin
cd /Users/neo/Desktop/PROJELER/n8n-murat

# Kurulum ve başlatma
npm run setup && npm start
```

## 📦 Kurulum Komutları

### Node.js ile Kurulum
```bash
# Bağımlılıkları yükle
npm install

# Geliştirme bağımlılıklarını yükle
npm install --dev

# Global n8n kurulumu (opsiyonel)
npm install -g n8n
```

### Docker ile Kurulum
```bash
# Docker container'ları indir ve başlat
docker-compose up -d

# Production modunda başlat (PostgreSQL ile)
docker-compose --profile production up -d

# Container'ları durdur
docker-compose down

# Container'ları sil ve yeniden oluştur
docker-compose down -v && docker-compose up -d
```

## 🔧 Konfigürasyon Komutları

### Çevre Değişkenleri
```bash
# .env dosyasını oluştur
cp .env.example .env

# .env dosyasını düzenle (macOS)
open -e .env

# .env dosyasını düzenle (Terminal)
nano .env
```

### Şifreleme Anahtarı Oluşturma
```bash
# 32 karakterlik rastgele anahtar oluştur
openssl rand -hex 16

# Alternatif yöntem
node -e "console.log(require('crypto').randomBytes(16).toString('hex'))"
```

## 🏃‍♂️ Çalıştırma Komutları

### Development Modu
```bash
# n8n'i development modunda başlat
npm run dev

# Tunnel ile başlat (webhook testleri için)
npm start -- --tunnel

# Belirli port ile başlat
npm start -- --port 3000
```

### Production Modu
```bash
# Production modunda başlat
npm start

# PM2 ile başlat (process manager)
pm2 start npm --name "n8n-organizer" -- start
pm2 save
pm2 startup
```

### Docker ile Çalıştırma
```bash
# Container'ları başlat
docker-compose up -d

# Log'ları takip et
docker-compose logs -f n8n

# Belirli container'ın log'unu görüntüle
docker-compose logs n8n
```

## 📊 Workflow Yönetimi

### Workflow İçe/Dışa Aktarma
```bash
# Tüm workflow'ları dışa aktar
npm run export

# Workflow'ları içe aktar
npm run import

# Belirli workflow'u dışa aktar
n8n export:workflow --id=1 --output=./workflows/

# Belirli workflow'u içe aktar
n8n import:workflow --input=./workflows/main-organizer.json
```

### Workflow Çalıştırma
```bash
# Workflow'u manuel çalıştır
n8n execute --id=1

# Workflow'u test modu ile çalıştır
n8n execute --id=1 --test
```

## 🔍 Monitoring ve Debug

### Log Görüntüleme
```bash
# n8n log'larını görüntüle
tail -f ~/.n8n/logs/n8n.log

# Docker log'larını görüntüle
docker-compose logs -f n8n

# Belirli seviyedeki log'ları filtrele
docker-compose logs n8n | grep ERROR
```

### Sistem Durumu Kontrolü
```bash
# n8n servis durumunu kontrol et
curl http://localhost:5678/healthz

# Port kullanımını kontrol et
lsof -i :5678

# Process'leri kontrol et
ps aux | grep n8n
```

### Database İşlemleri
```bash
# SQLite database'i kontrol et
sqlite3 ~/.n8n/database.sqlite ".tables"

# Database backup al
cp ~/.n8n/database.sqlite ./backup/database_$(date +%Y%m%d).sqlite

# PostgreSQL backup (Docker)
docker-compose exec postgres pg_dump -U n8n n8n > backup/postgres_$(date +%Y%m%d).sql
```

## 🧹 Temizlik ve Bakım

### Cache Temizleme
```bash
# npm cache temizle
npm cache clean --force

# n8n cache temizle
rm -rf ~/.n8n/cache/*

# Docker cache temizle
docker system prune -a
```

### Log Temizleme
```bash
# Eski log'ları sil (7 günden eski)
find ~/.n8n/logs/ -name "*.log" -mtime +7 -delete

# Docker log'larını temizle
docker-compose down && docker system prune -a
```

### Geçici Dosya Temizleme
```bash
# Geçici dosyaları sil
rm -rf /tmp/n8n-*

# Node modules yeniden yükle
rm -rf node_modules && npm install
```

## 🔄 Güncelleme Komutları

### n8n Güncelleme
```bash
# n8n'i güncelle
npm update n8n

# Belirli versiyona güncelle
npm install n8n@1.19.0

# Docker image güncelle
docker-compose pull && docker-compose up -d
```

### Bağımlılık Güncelleme
```bash
# Tüm bağımlılıkları güncelle
npm update

# Güvenlik açıklarını düzelt
npm audit fix

# Outdated paketleri kontrol et
npm outdated
```

## 🔐 Güvenlik Komutları

### SSL Sertifikası (Production)
```bash
# Let's Encrypt sertifikası al
certbot certonly --standalone -d yourdomain.com

# Sertifikayı yenile
certbot renew
```

### Backup İşlemleri
```bash
# Tam backup al
tar -czf backup/n8n-backup-$(date +%Y%m%d).tar.gz ~/.n8n/

# Sadece workflow'ları yedekle
cp -r ~/.n8n/workflows/ ./backup/workflows-$(date +%Y%m%d)/

# Credentials'ları yedekle (şifrelenmiş)
cp -r ~/.n8n/credentials/ ./backup/credentials-$(date +%Y%m%d)/
```

## 🧪 Test Komutları

### Bağlantı Testleri
```bash
# Google Drive API bağlantısını test et
curl -H "Authorization: Bearer YOUR_TOKEN" \
  "https://www.googleapis.com/drive/v3/files"

# n8n webhook'unu test et
curl -X POST http://localhost:5678/webhook/test

# Database bağlantısını test et
n8n db:test
```

### Workflow Testleri
```bash
# Test workflow'u çalıştır
n8n execute --file ./workflows/test-workflow.json

# Webhook test et
curl -X POST http://localhost:5678/webhook-test/google-drive-organizer
```

## 🚨 Acil Durum Komutları

### Servis Durdurma
```bash
# n8n'i durdur
pkill -f n8n

# Docker container'ları durdur
docker-compose down

# PM2 ile çalışan servisi durdur
pm2 stop n8n-organizer
```

### Hızlı Restart
```bash
# n8n'i yeniden başlat
npm run restart

# Docker'ı yeniden başlat
docker-compose restart

# PM2 ile yeniden başlat
pm2 restart n8n-organizer
```

### Rollback İşlemleri
```bash
# Önceki versiyona dön
npm install n8n@1.18.0

# Backup'tan geri yükle
cp ./backup/database_20231201.sqlite ~/.n8n/database.sqlite

# Workflow'ları geri yükle
cp -r ./backup/workflows-20231201/* ~/.n8n/workflows/
```

## 📋 Günlük Rutin Komutları

### Sabah Kontrolleri
```bash
# Sistem durumunu kontrol et
curl http://localhost:5678/healthz && echo "✅ n8n çalışıyor"

# Log'ları kontrol et
tail -20 ~/.n8n/logs/n8n.log

# Disk alanını kontrol et
df -h
```

### Haftalık Bakım
```bash
# Backup al
npm run backup

# Log'ları temizle
find ~/.n8n/logs/ -name "*.log" -mtime +7 -delete

# Güncelleme kontrol et
npm outdated
```

## 🔧 Troubleshooting Komutları

### Port Çakışması
```bash
# 5678 portunu kullanan process'i bul
lsof -i :5678

# Process'i sonlandır
kill -9 <PID>

# Alternatif port ile başlat
npm start -- --port 3000
```

### Memory Sorunları
```bash
# Memory kullanımını kontrol et
ps aux | grep n8n

# Node.js memory limit artır
node --max-old-space-size=4096 node_modules/.bin/n8n start
```

### Database Sorunları
```bash
# Database'i onar
sqlite3 ~/.n8n/database.sqlite "PRAGMA integrity_check;"

# Database'i yeniden oluştur
rm ~/.n8n/database.sqlite && npm start
```

## 📱 Mobil/Remote Erişim

### Tunnel Kurulumu
```bash
# ngrok ile tunnel aç
ngrok http 5678

# localtunnel ile tunnel aç
npx localtunnel --port 5678
```

### SSH Tunnel
```bash
# SSH tunnel oluştur
ssh -L 5678:localhost:5678 user@your-server.com
```

## 💡 İpuçları

1. **Alias'lar oluşturun:**
```bash
echo 'alias n8n-start="cd /Users/neo/Desktop/PROJELER/n8n-murat && npm start"' >> ~/.zshrc
echo 'alias n8n-logs="tail -f ~/.n8n/logs/n8n.log"' >> ~/.zshrc
```

2. **Cron job'lar ekleyin:**
```bash
# Günlük backup için crontab ekle
crontab -e
# 0 2 * * * cd /Users/neo/Desktop/PROJELER/n8n-murat && npm run backup
```

3. **Monitoring script'i:**
```bash
# n8n durumunu kontrol eden script
#!/bin/bash
if ! curl -s http://localhost:5678/healthz > /dev/null; then
    echo "n8n down, restarting..."
    npm start
fi
```