#!/bin/bash

# Étape 1 : Sécurité maximale. Arrêter immédiatement le script si une commande échoue (exit code != 0)
set -e

echo "=== 🚀 DÉBUT DU PROTOCOLE DE DÉPLOIEMENT H.S.C.100 ==="

# Étape 2 : Nettoyage d'anciens résidus éventuels du cache
echo "🧹 Nettoyage des répertoires temporaires..."
rm -rf build
rm -rf flutter_sdk

# Étape 3 : Téléchargement du SDK Flutter officiel (Version stable)
echo "📥 Téléchargement du SDK Flutter Stable depuis les serveurs officiels..."
# Utilisation de curl avec gestion des redirections (-L) et mode silencieux mais informatif (-sS)
curl -L -sS https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.22.2-stable.tar.xz -o flutter.tar.xz

echo "📦 Extraction du SDK Flutter..."
tar -xf flutter.tar.xz
rm flutter.tar.xz # Libère de l'espace disque immédiatement

# Étape 4 : Injection du binaire Flutter dans le PATH du terminal actuel
echo "⚙️ Configuration des variables d'environnement..."
export PATH="$PATH:$(pwd)/flutter/bin"

# Étape 5 : Désactivation des outils de tracking pour accélérer le processus de build
echo "🛡️ Configuration de Flutter..."
flutter config --no-analytics
flutter config --enable-web

# Étape 6 : Diagnostic rapide de l'environnement pour valider l'installation
echo "🔍 Vérification du statut de Flutter..."
flutter doctor -v

# Étape 7 : Installation des dépendances définies dans ton pubspec.yaml
echo "📥 Récupération des packages et dépendances Dart/Flutter..."
flutter pub get

# Étape 8 : Compilation finale vers l'architecture Web de production
echo "🏗️ Compilation du projet Flutter en mode Web (Release)..."
flutter build web --release --canvaskit

echo "=== 🎉 PROTOCOLE TERMINÉ AVEC SUCCÈS - PRÊT POUR LA MISE EN LIGNE ==="

