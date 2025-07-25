# Google Drive 5S Dosya Düzenleyici - n8n Projesi

## Proje Açıklaması

Bu n8n projesi, Google Drive'daki dosyalarınızı 5S metodolojisine uygun şekilde otomatik olarak düzenler. 5S metodolojisi (Seiri, Seiton, Seiso, Seiketsu, Shitsuke) kullanılarak dosyalarınız sistematik bir şekilde organize edilir.

## 5S Metodolojisi Nedir?

- **Seiri (整理) - Ayıklama**: Gereksiz dosyaları belirleme ve kaldırma
- **Seiton (整頓) - Düzenleme**: Dosyaları kategorilere göre düzenleme
- **Seiso (清掃) - Temizleme**: Duplicate dosyaları temizleme
- **Seiketsu (清潔) - Standartlaştırma**: Dosya adlandırma standartları uygulama
- **Shitsuke (躾) - Sürdürme**: Düzenli kontrol ve bakım

## Özellikler

### 🗂️ Otomatik Dosya Kategorilendirme
- Dosya türlerine göre otomatik klasörleme
- Özelleştirilebilir kategori kuralları
- Tarih bazlı arşivleme

### 🔍 Duplicate Dosya Tespiti
- Aynı isimli dosyaları bulma
- Boyut ve hash karşılaştırması
- Otomatik duplicate klasörüne taşıma

### 📝 Dosya Adlandırma Standartları
- Tutarlı dosya adlandırma
- Özel karakter temizleme
- Tarih formatı standardizasyonu

### 🧹 Otomatik Temizlik
- Boş klasörleri silme
- Eski dosyaları arşivleme
- Geçici dosyaları temizleme

### 📊 Raporlama
- Düzenleme işlemi raporları
- İstatistiksel analiz
- E-posta bildirimleri

## Proje Yapısı

```
n8n-murat/
├── package.json              # Node.js bağımlılıkları
├── docker-compose.yml        # Docker konfigürasyonu
├── .env.example              # Çevre değişkenleri örneği
├── workflows/                # n8n workflow dosyaları
│   ├── main-organizer.json   # Ana düzenleme workflow'u
│   ├── duplicate-detector.json # Duplicate tespit workflow'u
│   └── cleanup-scheduler.json # Temizlik zamanlayıcısı
├── credentials/              # API kimlik bilgileri
├── docs/                     # Dokümantasyon
├── scripts/                  # Yardımcı scriptler
└── README.md                # Bu dosya
```

## Sistem Gereksinimleri

- Node.js 18.0.0 veya üzeri
- npm 8.0.0 veya üzeri
- Docker ve Docker Compose (opsiyonel)
- Google Drive API erişimi
- Minimum 2GB RAM
- 10GB boş disk alanı

## Güvenlik Özellikleri

- OAuth 2.0 ile güvenli Google Drive erişimi
- Şifrelenmiş kimlik bilgileri saklama
- Basic Auth ile n8n arayüz koruması
- Webhook güvenlik doğrulaması
- Audit log kayıtları

## Lisans

MIT License - Detaylar için LICENSE dosyasına bakınız.

## Destek

Herhangi bir sorun yaşarsanız:
1. Önce dokümantasyonu kontrol edin
2. GitHub Issues bölümünde arama yapın
3. Yeni bir issue oluşturun

## Katkıda Bulunma

1. Fork yapın
2. Feature branch oluşturun
3. Değişikliklerinizi commit edin
4. Pull request gönderin