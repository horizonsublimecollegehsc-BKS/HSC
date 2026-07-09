// =========================================================================
// PROJET : H.S.C.100 (Horizon Sublime College)
// COMPOSANT : login_screen.dart (Flutter Screen)
// DESCRIPTION : Interface d'accès sécurisée (Responsive Universelle)
// SÉCURITÉ : Capture de l'empreinte matérielle brute unique de l'appareil (Anti-Fraude)
// =========================================================================

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
// Remarque : requiert l'ajout de 'device_info_plus' dans ton pubspec.yaml
// import 'package:device_info_plus/device_info_plus.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // MÉTHODE CRUCIALE : Récupération de l'empreinte matérielle unique (Device ID)
  Future<String> _getDeviceUniqueIdentifier() async {
    if (kIsWeb) {
      // Pour la version Web sur Netlify, on génère une empreinte basée sur le navigateur
      return "WEB_BROWSER_${_emailController.text.hashCode}";
    }
    
    try {
      // Simulation ou appel natif via device_info_plus
      // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        // return androidInfo.id; // UUID unique fourni par Android matériel
        return "ANDROID_HARDWARE_MOCK_ID_12345"; 
      } else if (Platform.isIOS) {
        // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        // return iosInfo.identifierForVendor ?? "UNKNOWN_IOS";
        return "IOS_HARDWARE_MOCK_ID_12345";
      }
    } catch (e) {
      return "FALLBACK_DEVICE_ID_9999";
    }
    return "UNKNOWN_DEVICE_ID";
  }

  // SOU MISSION ET SÉCURISATION DU FORMULAIRE
  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() { _isLoading = true; });

      // 1. Capture immédiate de l'identifiant du téléphone
      String deviceId = await _getDeviceUniqueIdentifier();
      
      // LOGIQUE SÉCURITÉ : Envoi des identifiants + deviceId à l'API NestJS
      // Dans le futur api_service.dart : authService.login(_emailController.text, _passwordController.text, deviceId)
      
      await Future.delayed(const Duration(seconds: 2)); // Simulation réseau

      setState(() { _isLoading = false; });

      // Routage vers le tableau de bord principal après validation NestJS
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 750; // Détection du mode ordinateur

    return Scaffold(
      body: Row(
        children: [
          // BANNIÈRE VISUELLE GAUCHE (Uniquement visible sur Ordinateur/PC)
          if (isDesktop)
            Expanded(
              flex: 1,
              child: Container(
                color: const Color(0xFF1E3A8A), // Bleu Royal H.S.C
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.school, size: 90, color: Colors.white),
                    SizedBox(height: 20),
                    Text(
                      "H.S.C.100",
                      style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                    Text(
                      "Horizon Sublime College",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

          // FORMULAIRE DE CONNEXION (S'adapte sur PC et prend tout l'écran sur Mobile)
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 420),
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (!isDesktop) ...[
                          const Icon(Icons.school, size: 60, color: Color(0xFF1E3A8A)),
                          const SizedBox(height: 12),
                          const Text(
                            "HORIZON SUBLIME COLLEGE",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Color(0xFF1E3A8A), fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 32),
                        ],
                        const Text(
                          "Portail Académique Etudiant",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Connectez-vous pour accéder à vos 6 mois de formation vidéo sécurisée.",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        const SizedBox(height: 28),

                        // CHAMP EMAIL ACADÉMIQUE
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Adresse Email Étudiant',
                            prefixIcon: const Icon(Icons.email_outlined, size: 20),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          validator: (value) => (value == null || !value.contains('@')) ? 'Veuillez entrer un email académique valide.' : null,
                        ),
                        const SizedBox(height: 18),

                        // CHAMP MOT DE PASSE CRYPTÉ
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: 'Mot de passe',
                            prefixIcon: const Icon(Icons.lock_outlined, size: 20),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 20),
                              onPressed: () => setState(() => _obscureText = !_obscureText),
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          validator: (value) => (value == null || value.length < 6) ? 'Le mot de passe doit faire au moins 6 caractères.' : null,
                        ),
                        const SizedBox(height: 24),

                        // BOUTON DE SOU MISSION ADAPTATIF
                        ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          child: _isLoading
                              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                              : const Text("ACCÉDER AU PORTAIL ACADÉMIQUE"),
                        ),
                        const SizedBox(height: 20),
                        
                        // NOTE INFORMATIVE DE SÉCURITÉ MATÉRIELLE
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: const Color(0xFFFEF2F2), borderRadius: BorderRadius.circular(8)),
                          child: const Row(
                            children: [
                              Icon(Icons.security, color: Colors.redAccent, size: 18),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "Avis Anti-Fraude : Ce compte sera définitivement lié au premier smartphone connecté. Multi-connexion interdite.",
                                  style: TextStyle(fontSize: 11, color: Color(0xFF991B1B), fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

