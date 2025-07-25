#!/bin/bash

# n8n Google Drive 5S Organizer - Başlatma Script
# Bu script n8n'i başlatır ve gerekli kontrolleri yapar

set -e

# Renk kodları
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

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

# .env dosyası kontrolü
check_env() {
    if [ ! -f .env ]; then
        print_error ".env dosyası bulunamadı!"
        print_info "Lütfen önce 'npm run setup' komutunu çalıştırın"
        exit 1
    fi
    
    # Kritik değişkenleri kontrol et
    source .env
    
    if [ -z "$GOOGLE_CLIENT_ID" ] || [ "$GOOGLE_CLIENT_ID" = "your_google_client_id" ]; then
        print_error "GOOGLE_CLIENT_ID ayarlanmamış!"
        print_info "Lütfen .env dosyasını düzenleyin"
        exit 1
    fi
    
    if [ -z "$GOOGLE_CLIENT_SECRET" ] || [ "$GOOGLE_CLIENT_SECRET" = "your_google_client_secret" ]; then
        print_error "GOOGLE_CLIENT_SECRET ayarlanmamış!"
        print_info "Lütfen .env dosyasını düzenleyin"
        exit 1
    fi
    
    print_success "Çevre değişkenleri kontrol edildi"
}

# Port kontrolü
check_port() {
    PORT=${N8N_PORT:-5678}
    
    if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null ; then
        print_warning "Port $PORT kullanımda!"
        print_info "Mevcut süreci durdurmak için: npm run stop"
        read -p "Devam etmek istiyor musunuz? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
}

# n8n başlatma
start_n8n() {
    print_info "n8n başlatılıyor..."
    print_info "Arayüz: http://localhost:${N8N_PORT:-5678}"
    print_info "Durdurmak için: Ctrl+C veya npm run stop"
    echo ""
    
    # n8n'i başlat
    if command -v n8n &> /dev/null; then
        n8n start
    else
        print_error "n8n bulunamadı!"
        print_info "Lütfen 'npm run setup' komutunu çalıştırın"
        exit 1
    fi
}

# Ana fonksiyon
main() {
    echo "🚀 n8n Google Drive 5S Organizer Başlatılıyor..."
    echo "================================================"
    echo ""
    
    check_env
    check_port
    start_n8n
}

main "$@"