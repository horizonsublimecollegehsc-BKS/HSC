// =========================================================================
// PROJET : H.S.C.100 (Horizon Sublime College)
// COMPOSANT : profile_screen.dart (Flutter Screen - Onglet Profil)
// DESCRIPTION : Fiche d'identité académique et transparence sécurité matériel
// =========================================================================

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  // Simulation des données de l'étudiant connecté (Provenant de PostgreSQL via le JWT)
  final Map<String, dynamic> _studentData = const {
    "firstName": "Arsène",
    "lastName": "Kabila",
    "registrationNumber": "HSC-2026-09482",
    "email": "arsene.kabila@hsc100.edu",
    "phoneNumber": "+243 971 234 567",
    "isVip": false,
    "linkedDevice": "ANDROID_HARDWARE_MOCK_ID_12345", // Empreinte matérielle stockée
    "joinDate": "08 Juillet 2026"
  };

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 800;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: isDesktop ? 700 : double.infinity),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. CARTE D'IDENTITÉ ACADÉMIQUE VISUELLE
                Card(
                  gradient: const LinearGradient(colors: [Color(0xFF1E3A8A), Color(0xFF111827)]), // Dégradé Bleu/Noir
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF1E3A8A), Color(0xFF0F172A)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 65, height: 65,
                              decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
                              child: const Icon(Icons.person, color: Colors.white, size: 35),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${_studentData['firstName']} ${_studentData['lastName']}",
                                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Matricule : ${_studentData['registrationNumber']}",
                                    style: const TextStyle(color: Colors.cyanAccent, fontFamily: 'Courier', fontSize: 13, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            // Badge de Statut (VIP ou Standard)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: _studentData['isVip'] ? Colors.amber : Colors.white12,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                _studentData['isVip'] ? "VIP MEMBER" : "STANDARD",
                                style: TextStyle(color: _studentData['isVip'] ? Colors.black : Colors.white70, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(color: Colors.white10, height: 1),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.between,
                          children: [
                            const Text("Établissement :", style: TextStyle(color: Colors.white60, fontSize: 12)),
                            const Text("Horizon Sublime College (H.S.C.100)", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 2. COORDONNÉES ET COORDONNÉES DE L'ÉTUDIANT
                const Text("INFORMATIONS PERSONNELLES", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                const SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.email_outlined, color: Color(0xFF1E3A8A)),
                          title: const Text("Email académique", style: TextStyle(fontSize: 11, color: Colors.grey)),
                          subtitle: Text(_studentData['email'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                          dense: true,
                        ),
                        const Divider(height: 1, indent: 50),
                        ListTile(
                          leading: const Icon(Icons.phone_outlined, color: Color(0xFF1E3A8A)),
                          title: const Text("Numéro WhatsApp / Airtel", style: TextStyle(fontSize: 11, color: Colors.grey)),
                          subtitle: Text(_studentData['phoneNumber'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                          dense: true,
                        ),
                        const Divider(height: 1, indent: 50),
                        ListTile(
                          leading: const Icon(Icons.calendar_today_outlined, color: Color(0xFF1E3A8A)),
                          title: const Text("Date d'inscription au collège", style: TextStyle(fontSize: 11, color: Colors.grey)),
                          subtitle: Text(_studentData['joinDate'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                          dense: true,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 3. BLOC TRANSPARENCE ANTIFRAU DE (SÉCURITÉ APPAREIL)
                const Text("PARAMÈTRES DE SÉCURITÉ MATÉRIELLE", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                const SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.lock_person_outlined, color: Colors.green, size: 20),
                            SizedBox(width: 10),
                            Text("Verrouillage Mono-Appareil Actif", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.green)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Pour empêcher le piratage et le partage illicite de compte, vos identifiants d'accès ont été scellés à la carte mère de votre premier smartphone. Toute connexion sur un second appareil entraînera le blocage immédiat du compte.",
                          style: TextStyle(fontSize: 12, color: Colors.slate, height: 1.4),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.between,
                            children: [
                              const Text("Empreinte Appareil Lié :", style: TextStyle(fontSize: 11, color: Colors.slate)),
                              Text(
                                _studentData['linkedDevice'],
                                style: const TextStyle(fontFamily: 'Courier', fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

