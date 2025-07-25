#!/bin/bash

# n8n Google Drive 5S Organizer - Setup Script
# Bu script projeyi otomatik olarak kurar ve yapılandırır

set -e

echo "🚀 n8n Google Drive 5S Organizer Kurulum Başlıyor..."

# Renk kodları
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fonksiyonlar
print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Gereksinimler kontrolü
check_requirements() {
    print_info "Sistem gereksinimleri kontrol ediliyor..."
    
    # Node.js kontrolü
    if ! command -v node &> /dev/null; then
        print_error "Node.js bulunamadı. Lütfen Node.js 18+ yükleyin."
        exit 1
    fi
    
    NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -lt 18 ]; then
        print_error "Node.js 18+ gerekli. Mevcut versiyon: $(node -v)"
        exit 1
    fi
    print_success "Node.js $(node -v) ✓"
    
    # npm kontrolü
    if ! command -v npm &> /dev/null; then
        print_error "npm bulunamadı."
        exit 1
    fi
    print_success "npm $(npm -v) ✓"
    
    # Git kontrolü (opsiyonel)
    if command -v git &> /dev/null; then
        print_success "Git $(git --version | cut -d' ' -f3) ✓"
    else
        print_warning "Git bulunamadı (opsiyonel)"
    fi
}

# .env dosyası oluşturma
setup_env() {
    print_info ".env dosyası yapılandırılıyor..."
    
    if [ ! -f .env ]; then
        cp .env.example .env
        print_success ".env dosyası oluşturuldu"
        print_warning "Lütfen .env dosyasını düzenleyerek gerekli bilgileri doldurun!"
        print_info "Detaylar için 'doldurulmasi-gereken-yerler.md' dosyasına bakın"
    else
        print_warning ".env dosyası zaten mevcut"
    fi
}

# Bağımlılıkları yükleme
install_dependencies() {
    print_info "Bağımlılıklar yükleniyor..."
    
    npm install
    print_success "Bağımlılıklar yüklendi"
}

# Klasör yapısını kontrol etme
check_directories() {
    print_info "Klasör yapısı kontrol ediliyor..."
    
    REQUIRED_DIRS=("workflows" "credentials" "docs" "scripts")
    
    for dir in "${REQUIRED_DIRS[@]}"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
            print_success "Klasör oluşturuldu: $dir"
        fi
    done
}

# Docker kontrolü
check_docker() {
    if command -v docker &> /dev/null && command -v docker-compose &> /dev/null; then
        print_success "Docker ve Docker Compose mevcut"
        print_info "Docker ile çalıştırmak için: docker-compose up -d"
        return 0
    else
        print_warning "Docker bulunamadı. Manuel kurulum yapılacak."
        return 1
    fi
}

# n8n kurulumu
install_n8n() {
    print_info "n8n kurulumu kontrol ediliyor..."
    
    if ! command -v n8n &> /dev/null; then
        print_info "n8n global olarak yükleniyor..."
        npm install -g n8n
        print_success "n8n global olarak yüklendi"
    else
        print_success "n8n zaten yüklü: $(n8n --version)"
    fi
}

# Güvenlik anahtarı oluşturma
generate_encryption_key() {
    if [ ! -f .env ] || ! grep -q "N8N_ENCRYPTION_KEY=" .env || grep -q "N8N_ENCRYPTION_KEY=your_32_character_encryption_key_here" .env; then
        print_info "Şifreleme anahtarı oluşturuluyor..."
        
        if command -v openssl &> /dev/null; then
            ENCRYPTION_KEY=$(openssl rand -hex 16)
            sed -i.bak "s/N8N_ENCRYPTION_KEY=your_32_character_encryption_key_here/N8N_ENCRYPTION_KEY=$ENCRYPTION_KEY/" .env
            print_success "Şifreleme anahtarı oluşturuldu"
        else
            print_warning "OpenSSL bulunamadı. Şifreleme anahtarını manuel olarak oluşturun."
        fi
    fi
}

# Kurulum özeti
print_summary() {
    echo ""
    echo "🎉 Kurulum Tamamlandı!"
    echo "===================="
    echo ""
    print_info "Sonraki adımlar:"
    echo "1. 📝 'doldurulmasi-gereken-yerler.md' dosyasını inceleyin"
    echo "2. ⚙️  .env dosyasını düzenleyin"
    echo "3. 🔑 Google Drive API kimlik bilgilerini ekleyin"
    echo "4. 🚀 Projeyi başlatın: npm start"
    echo ""
    print_info "Yardım için:"
    echo "- 📖 Kurulum: docs/kurulum.md"
    echo "- 💻 Komutlar: commands.md"
    echo "- 🌐 n8n Arayüz: http://localhost:5678"
    echo ""
}

# Ana kurulum fonksiyonu
main() {
    echo "🔧 n8n Google Drive 5S Organizer"
    echo "================================="
    echo ""
    
    check_requirements
    check_directories
    setup_env
    install_dependencies
    
    if check_docker; then
        print_info "Docker kurulumu mevcut. Manuel kurulum atlanıyor."
    else
        install_n8n
    fi
    
    generate_encryption_key
    print_summary
}

# Script'i çalıştır
main "$@"