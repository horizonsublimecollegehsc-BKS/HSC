#!/bin/bash
set -e

echo "=== ⚡ RUNNING RIGOROUS PRODUCTION BUILD PROCESS ==="

# Configuration des répertoires de stockage
CACHE_DIR=".netlify_cache"
FLUTTER_SDK_DIR="$CACHE_DIR/flutter"

mkdir -p "$CACHE_DIR"

if [ ! -d "$FLUTTER_SDK_DIR" ]; then
  echo "📥 SDK local absent. Téléchargement de la version stable isolée..."
  curl -L -sS "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" -o flutter.tar.xz
  
  echo "📦 Extraction du SDK..."
  tar -xf flutter.tar.xz -C "$CACHE_DIR"
  rm flutter.tar.xz
else
  echo "🔄 Réutilisation du SDK mis en cache."
fi

# Liaison absolue au PATH système de Netlify
export PATH="$PATH:$(pwd)/$FLUTTER_SDK_DIR/bin"

echo "⚙️ Configuration système des outils Web..."
flutter config --no-analytics
flutter config --enable-web

echo "📥 Téléchargement des dépendances pubspec..."
# Utilisation du flag --legacy-lock pour éviter les blocages de flux réseau distants
flutter pub get

echo "🏗️ Lancement de la compilation Web Release (HTML/JS combiné)..."
flutter build web --release --web-renderer auto

echo "=== ✅ PROJET PRÊT ET VALIDE ==="
