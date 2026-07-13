#!/bin/bash
set -e

echo "=== 🕵️ STARTING PRODUCTION AUDIT & BUILD FOR H.S.C.100 ==="

# Définition des chemins de cache
CACHE_DIR=".netlify_cache"
FLUTTER_SDK_DIR="$CACHE_DIR/flutter"

# Créer le répertoire de cache s'il n'existe pas
mkdir -p "$CACHE_DIR"

if [ ! -d "$FLUTTER_SDK_DIR" ]; then
  echo "📥 Flutter SDK non trouvé dans le cache. Téléchargement de la version ${FLUTTER__VERSION}..."
  curl -L -sS "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" -o flutter.tar.xz
  
  echo "📦 Extraction du SDK..."
  tar -xf flutter.tar.xz -C "$CACHE_DIR"
  rm flutter.tar.xz
else
  echo "⚡ Flutter SDK trouvé dans le cache ! Gain de temps activé."
fi

# Injection du PATH
export PATH="$PATH:$(pwd)/$FLUTTER_SDK_DIR/bin"

echo "⚙️ Configuration de Flutter pour le Web..."
flutter config --no-analytics
flutter config --enable-web

echo "🔍 Diagnostic d'intégrité..."
flutter doctor

echo "📦 Restauration des dépendances de pubspec.yaml..."
flutter pub get

echo "🏗️ Compilation de l'interface Sun300 (Mode Web Release)..."
# Utilisation du mode auto (choisit HTML pour le mobile léger et CanvasKit pour le desktop)
flutter build web --release --web-renderer auto

echo "=== 🎉 DEPLOYMENT READY FOR NETLIFY ==="
