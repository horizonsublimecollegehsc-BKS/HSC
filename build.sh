#!/bin/bash
set -e

echo "=== ⚡ RUNNING ULTIMATE PRODUCTION BUILD PROCESS ==="

# Configuration des répertoires de stockage
CACHE_DIR=".netlify_cache"
FLUTTER_SDK_DIR="$CACHE_DIR/flutter"

mkdir -p "$CACHE_DIR"

if [ ! -d "$FLUTTER_SDK_DIR" ]; then
  echo "📥 SDK local absent. Téléchargement direct de la version stable 3.19.6..."
  # Lien direct et complet sans variable d'environnement externe
  curl -L -sS "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.6-stable.tar.xz" -o flutter.tar.xz
  
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
flutter pub get

echo "🏗️ Lancement de la compilation Web Release..."
flutter build web --release --web-renderer auto

echo "=== ✅ PROJET PRÊT ET VALIDE ==="
