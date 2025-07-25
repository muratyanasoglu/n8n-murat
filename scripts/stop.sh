#!/bin/bash

# n8n Google Drive 5S Organizer - Durdurma Script
# Bu script çalışan n8n süreçlerini durdurur

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

# n8n süreçlerini durdur
stop_n8n() {
    print_info "n8n süreçleri durduruluyor..."
    
    # Port tabanlı durdurma
    PORT=${N8N_PORT:-5678}
    PID=$(lsof -ti:$PORT)
    
    if [ ! -z "$PID" ]; then
        kill -TERM $PID 2>/dev/null || true
        sleep 2
        
        # Hala çalışıyorsa zorla durdur
        if kill -0 $PID 2>/dev/null; then
            kill -KILL $PID 2>/dev/null || true
            print_warning "n8n zorla durduruldu (PID: $PID)"
        else
            print_success "n8n başarıyla durduruldu (PID: $PID)"
        fi
    else
        print_info "Port $PORT'ta çalışan süreç bulunamadı"
    fi
    
    # İsim tabanlı durdurma (yedek)
    pkill -f "n8n" 2>/dev/null || true
    
    print_success "Tüm n8n süreçleri durduruldu"
}

# Docker konteynerlerini durdur
stop_docker() {
    if [ -f docker-compose.yml ] && command -v docker-compose &> /dev/null; then
        print_info "Docker konteynerları durduruluyor..."
        docker-compose down
        print_success "Docker konteynerları durduruldu"
    fi
}

# Ana fonksiyon
main() {
    echo "🛑 n8n Google Drive 5S Organizer Durduruluyor..."
    echo "==============================================="
    echo ""
    
    stop_docker
    stop_n8n
    
    echo ""
    print_success "Tüm süreçler durduruldu!"
}

main "$@"