// =========================================================================
// PROJET : H.S.C.100 (Horizon Sublime College)
// COMPOSANT : main.dart (Flutter Main Entry Point)
// DESCRIPTION : Initialisation, Thème graphique H.S.C et Gestion des Routes
// DESIGN : Conçu pour s'adapter automatiquement sur PC (Full HD) et Smartphone
// =========================================================================

import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_dashboard_screen.dart';

void main() {
  // Optionnel : Initialisation des services natifs ou plugins web ici avant le lancement
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HorizonSublimeCollegeApp());
}

class HorizonSublimeCollegeApp extends StatelessWidget {
  const HorizonSublimeCollegeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'H.S.C.100 - Horizon Sublime College',
      debugShowCheckedModeBanner: false,

      // 1. DÉFINITION DE LA CHARTE GRAPHIQUE COMPLÈTE DE L'ÉTABLISSEMENT
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF1E3A8A), // Bleu Royal Premium
        scaffoldBackgroundColor: const Color(0xFFF1F5F9), // Fond Gris/Bleu ultra-clair standard
        
        // Configuration globale de la typographie
        fontFamily: 'Segoe UI',
        
        // Thème des barres d'applications (AppBar)
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF0F172A), // Texte ardoise foncé
          elevation: 0.5,
          iconTheme: IconThemeData(color: Color(0xFF1E3A8A)),
          titleTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E3A8A),
            letterSpacing: 0.5,
          ),
        ),

        // Style par défaut des boutons de l'application
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E3A8A),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Angles arrondis modernes
            ),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),

        // Thème des cartes de données
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 1,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      // 2. CONFIGURATION DU ROUTAGE CENTRALISÉ ET SÉCURISÉ
      initialRoute: '/login', // L'étudiant démarre toujours sur la page d'authentification matériel
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const HomeDashboardScreen(),
      },

      // Gestionnaire de routes dynamiques (Utile pour passer des paramètres aux 10 cadres vidéos)
      onGenerateRoute: (settings) {
        // Logique de secours ou routes complexes avec arguments à ajouter ici si nécessaire
        return null;
      },
    );
  }
}

