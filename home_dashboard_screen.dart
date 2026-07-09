// =========================================================================
// PROJET : H.S.C.100 (Horizon Sublime College)
// COMPOSANT : home_dashboard_screen.dart (Flutter Scaffold Central)
// DESCRIPTION : Gestionnaire des 4 onglets requis et Tableau de bord principal
// ONGLETS : 1. Accueil (Les 6 mois) | 2. Budget (Paiements) | 3. Panoucia (IA) | 4. Profil
// =========================================================================

import 'package:flutter/material.dart';
import 'level_videos_screen.dart'; // Importation de l'espace 10 vidéos responsive
import 'budget_screen.dart';       // Futur onglet de comptabilité
import 'panoucia_chat_screen.dart'; // Futur onglet de l'IA OSIL Digital
import 'profile_screen.dart';      // Futur onglet du profil étudiant

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({Key? key}) : super(key: key);

  @override
  _HomeDashboardScreenState createState() => _LoginScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  int _currentIndex = 0; // Index de l'onglet actif

  // Liste des écrans correspondants aux 4 onglets requis
  final List<Widget> _tabs = [
    const AcademicHomeTab(),     // Onglet 1 : Accueil (Grille des 6 niveaux)
    const BudgetScreen(),        // Onglet 2 : Suivi financier & Reçus
    const PanouciaChatScreen(),  // Onglet 3 : Assistant IA interactif
    const ProfileScreen(),       // Onglet 4 : Fiche identitaire de l'étudiant
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 900;

    return Scaffold(
      // BARRE D'APPLICATIONS COMMUNE
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.school, color: Color(0xFF1E3A8A)),
            const SizedBox(width: 10),
            Text(isDesktop ? "HORIZON SUBLIME COLLEGE – COMPTE ÉTUDIANT" : "H.S.C.100"),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined, color: Colors.redAccent),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
          const SizedBox(width: 10),
        ],
      ),

      // CONTENU DE L'ONGLET ACTIF
      body: _tabs[_currentIndex],

      // NAVIGATEUR EN BARRE D'ONGLETS (Bottom Navigation Bar)
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF1E3A8A), // Bleu Royal actif
          unselectedItemColor: Colors.slate.shade400,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard_customize_outlined), activeIcon: Icon(Icons.dashboard_customize), label: 'Accueil'),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), activeIcon: Icon(Icons.account_balance_wallet), label: 'Budget'),
            BottomNavigationBarItem(icon: Icon(Icons.psychology_outlined), activeIcon: Icon(Icons.psychology), label: 'Panoucia IA'),
            BottomNavigationBarItem(icon: Icon(Icons.badge_outlined), activeIcon: Icon(Icons.badge), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// SOU S-COMPOSANT : L'ONGLET ACCUEIL (GRILLE DES 6 MOIS)
// =========================================================================
class AcademicHomeTab extends StatelessWidget {
  const AcademicHomeTab({Key? key}) : super(key: key);

  // Données structurelles des 6 mois de cursus
  final List<Map<String, dynamic>> _levels = const [
    {"num": 1, "desc": "Bases pratiques & Vocabulaire", "unlocked": true},
    {"num": 2, "desc": "Grammaire & Structures courantes", "unlocked": false},
    {"num": 3, "desc": "Fluence & Expressions d'affaires", "unlocked": false},
    {"num": 4, "desc": "Anglais Technique Avancé", "unlocked": false},
    {"num": 5, "desc": "Module VIP – Immersion Totale", "unlocked": false},
    {"num": 6, "desc": "Examen de Certification Finale", "unlocked": false},
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 1100 ? 3 : (screenWidth > 650 ? 2 : 1);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // BANNIÈRE DE BIENVENUE COMPORTEMENTALE
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Bienvenue sur votre espace d'étude !", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text("Suivez vos cours vidéos à vie, sans limite de visionnage. Activez chaque mois pour débloquer vos 10 nouveaux cadres de formation.", style: TextStyle(color: Colors.white80, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // TITRE DE LA GRILLE
          const Text("VOTRE PROGRAMME DE FORMATION (6 MOIS)", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          const SizedBox(height: 14),

          // GRILLE SÉCURISÉE DES 6 NIVEAUX
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.2,
            ),
            itemCount: _levels.length,
            itemBuilder: (context, index) {
              final lvl = _levels[index];
              bool isUnlocked = lvl["unlocked"];

              return Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    if (isUnlocked) {
                      // Ouverture directe de l'espace sécurisé des 10 vidéos
                      Navigator.push(context, MaterialPageRoute(builder: (_) => LevelVideosScreen(levelNumber: lvl["num"])));
                    } else {
                      // Message pédagogique invitant à régulariser le solde sur l'onglet Budget
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Le Mois ${lvl["num"]} est verrouillé. Veuillez activer ce niveau depuis l'onglet Budget."),
                        backgroundColor: Colors.amber.shade800,
                      ));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Indicateur visuel circulaire du numéro de niveau
                        Container(
                          width: 50, height: 50,
                          decoration: BoxDecoration(
                            color: isUnlocked ? const Color(0xFFEEF2FF) : Colors.grey.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text("${lvl["num"]}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isUnlocked ? const Color(0xFF1E3A8A) : Colors.grey)),
                          ),
                        ),
                        const SizedBox(width: 14),
                        
                        // Textes descriptifs du niveau
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("MOIS ${lvl["num"]}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isUnlocked ? const Color(0xFF1E3A8A) : Colors.grey.shade600)),
                              const SizedBox(height: 4),
                              Text(lvl["desc"], maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, color: Colors.slate)),
                            ],
                          ),
                        ),
                        
                        // Icône d'état d'accès matériel (Cadenas ou flèche)
                        Icon(isUnlocked ? Icons.arrow_forward_ios : Icons.lock_outline, size: 16, color: isUnlocked ? const Color(0xFF1E3A8A) : Colors.grey),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 30),

          // SECTION CANAUX SOCIAUX ET LIENS COMMU NAUTAIRES
          const Text("REJOINDRE LA COMMUNAUTÉ SCIENTIFIQUE", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildSocialButton(Icons.telegram, "Canal Telegram", Colors.blue),
              const SizedBox(width: 12),
              _buildSocialButton(Icons.forum_outlined, "Groupe d'entraide", Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  // Modèle responsive de bouton social intégré
  Widget _buildSocialButton(IconData icon, String text, Color color) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
        child: ListTile(
          leading: Icon(icon, color: color),
          title: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          trailing: const Icon(Icons.open_in_new, size: 14, color: Colors.grey),
          dense: true,
          onTap: () {
            // ICI : Implémentation du lancement d'URL externe vers tes canaux
          },
        ),
      ),
    );
  }
}

