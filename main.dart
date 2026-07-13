import 'package:flutter/material.dart';

void main() {
  runApp(const HorizonSublimeCollegeApp());
}

class HorizonSublimeCollegeApp extends StatelessWidget {
  const HorizonSublimeCollegeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'H.S.C.100',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0D47A1),
        scaffoldBackgroundColor: const Color(0xFFF1F5F9),
        fontFamily: 'Roboto',
      ),
      home: const MainPortalScreen(),
    );
  }
}

class MainPortalScreen extends StatefulWidget {
  const MainPortalScreen({Key? key}) : super(key: key);

  @override
  State<MainPortalScreen> createState() => _MainPortalScreenState();
}

class _MainPortalScreenState extends State<MainPortalScreen> {
  int _currentIndex = 0;
  bool _isAdminMode = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(85),
        child: AppBar(
          backgroundColor: const Color(0xFF003060),
          elevation: 4,
          automaticallyImplyLeading: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "H.S.C.100.com",
                    style: TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.security, size: 14, color: Colors.greenAccent),
                      const SizedBox(width: 4),
                      Text(
                        _isAdminMode ? "PORTAIL COLLÈGE (ADMIN)" : "SÉCURITÉ MAXIMALE ACTIVÉE",
                        style: const TextStyle(fontSize: 11, color: Colors.white70),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                "HORIZON SUBLIME COLLEGE (H.S.C.)",
                style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: 0.5),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(_isAdminMode ? Icons.school : Icons.admin_panel_settings, color: Colors.amber),
              tooltip: "Bascule Étudiant / Admin",
              onPressed: () {
                setState(() {
                  _isAdminMode = !_isAdminMode;
                });
              },
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: Color(0xFFE3F2FD), shape: BoxShape.circle),
                  child: const Text("H", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("PRACTICE MAKES PERFECT.", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
                      Text("Plateforme Académique Officielle", style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                const Icon(Icons.workspace_premium, color: Color(0xFF0D47A1)),
              ],
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: [
                _buildAccueilTab(),
                _buildBudgetTab(),
                _buildPanouciaIaTab(),
                _buildProfilTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF0D47A1),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "ACCUEIL"),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "BUDGET"),
          BottomNavigationBarItem(icon: Icon(Icons.psychology), label: "PANOUCIA IA"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "PROFIL"),
        ],
      ),
    );
  }

  Widget _buildAccueilTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              "FORMATION PROGRESSIVE",
              style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF546E7A), fontSize: 12, letterSpacing: 1.2),
            ),
          ),
          _buildSun300Tile(
            icon: Icons.menu_book_rounded,
            iconColor: const Color(0xFF1E88E5),
            title: "1. COURS MAGISTRAUX",
            description: _isAdminMode ? "Publier et gérer les cours du collège" : "Suivi complet du programme sur 6 mois d'études.",
            trailing: _isAdminMode ? null : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(color: const Color(0xFFFFF3E0), borderRadius: BorderRadius.circular(20)),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lock_rounded, size: 14, color: Colors.orange),
                  SizedBox(width: 4),
                  Text("4\$ (9.400 CDF) / Mois", style: TextStyle(fontSize: 11, color: Colors.orange, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            onTap: () => _isAdminMode ? _openFeatureDetails("Espace de publication PDF") : _showUnlockModal(context),
          ),
          _buildSun300Tile(
            icon: Icons.calendar_today_rounded,
            iconColor: const Color(0xFF43A047),
            title: "2. HORAIRE DES COURS",
            description: "Calendrier académique officiel mis à jour mensuellement.",
            onTap: () => _openFeatureDetails("Ouverture du calendrier H.S.C.100..."),
          ),
          _buildSun300Tile(
            icon: Icons.error_outline_rounded,
            iconColor: const Color(0xFFE53935),
            title: "3. EXAMEN INTELLIGENT (IA)",
            description: "Disponible chaque 30 du mois. 10 questions (3 tentatives max).",
            trailing: const Badge(label: Text("IA"), backgroundColor: Colors.red),
            onTap: () => _openFeatureDetails("Initialisation du protocole anti-triche Panoucia..."),
          ),
          _buildSun300Tile(
            icon: Icons.campaign_rounded,
            iconColor: const Color(0xFFFB8C00),
            title: "4. ANNONCES DU COLLÈGE",
            description: "Retrouvez ici toutes les communications urgentes de l'administration.",
            onTap: () => _openFeatureDetails("Chargement des annonces récentes..."),
          ),
          _buildSun300Tile(
            icon: Icons.local_library_rounded,
            iconColor: const Color(0xFF8E24AA),
            title: "5. BIBLIOTHÈQUE H.S.C.",
            description: "Accès aux ouvrages de référence d'anglais pour 0.5\$.",
            onTap: () => _openFeatureDetails("Accès sécurisé à la bibliothèque..."),
          ),
          _buildSun300Tile(
            icon: Icons.format_quote_rounded,
            iconColor: const Color(0xFF00ACC1),
            title: "6. CITATIONS DU COACH",
            description: "Partagez instantanément sur Facebook, WhatsApp et Instagram.",
            onTap: () => _openFeatureDetails("Ouverture des citations de Coach Joseph B..."),
          ),
          _buildSun300Tile(
            icon: Icons.workspace_premium_rounded,
            iconColor: const Color(0xFFFFB300),
            title: "7. MON CERTIFICAT",
            description: "Téléchargement disponible après validation des 6 mois.",
            onTap: () => _openFeatureDetails("Vérification de votre éligibilité au certificat..."),
          ),
          const SizedBox(height: 14),
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              "COMMUNAUTÉ & SUPPORTS DIRECTS",
              style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF546E7A), fontSize: 12, letterSpacing: 1.2),
            ),
          ),
          _buildSun300Tile(
            icon: Icons.phone_android_rounded,
            iconColor: Colors.green,
            title: "8. WHATSAPP COACH JOSEPH B.",
            description: "Assistance et encadrement direct : 0906693229",
            onTap: () => _openFeatureDetails("Lancement de WhatsApp..."),
          ),
          _buildSun300Tile(
            icon: Icons.groups_rounded,
            iconColor: const Color(0xFF25D366),
            title: "9. CLUB D'ANGLAIS (WHATSAPP)",
            description: "Lien officiel d'intégration du groupe de discussion.",
            trailing: const Icon(Icons.open_in_new, size: 16, color: Colors.grey),
            onTap: () => _openFeatureDetails("Redirection Club WhatsApp..."),
          ),
          _buildSun300Tile(
            icon: Icons.telegram_rounded,
            iconColor: const Color(0xFF26A69A),
            title: "10. CLUB D'ANGLAIS (TELEGRAM)",
            description: "Rejoignez le canal officiel de l'académie H.S.C.",
            trailing: const Icon(Icons.open_in_new, size: 16, color: Colors.grey),
            onTap: () => _openFeatureDetails("Redirection Club Telegram..."),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFF003060), borderRadius: BorderRadius.circular(12)),
            child: Text(
              _isAdminMode ? "Historique global des reçus étudiants" : "Mon budget de l'année dans laquelle j'étudie",
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const CircleAvatar(radius: 45, backgroundColor: Colors.blueAccent, child: Icon(Icons.person, size: 50, color: Colors.white)),
                  const SizedBox(height: 12),
                  Text(
                    _isAdminMode ? "PANEL DE CONTRÔLE FINANCIER" : "HORIZON SUBLIME COLLÈGE",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _isAdminMode ? "Total perçu : Suivi automatique en CDF / USD" : "Nombres de mois payés et reçus automatiques lors du paiement",
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.check_circle, color: Colors.white),
                    label: const Text("Vérifier l'étudiant", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPanouciaIaTab() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          color: const Color(0xFF2196F3),
          child: const Text(
            "Je suis Panoucia IA, poses moi une question.",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    "L'IA Panoucia est développée à 100% par OSIL Digital et conçue pour accompagner l'utilisateur dans ses projets et cours.",
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: const Color(0xFFF1F5F9),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Écrivez votre message...",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: Colors.red,
                child: IconButton(icon: const Icon(Icons.delete, color: Colors.white), onPressed: () {}),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildProfilTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF0D47A1), Color(0xFF1976D2)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            child: Column(
              children: [
                const CircleAvatar(radius: 40, backgroundColor: Colors.white, child: Icon(Icons.school, size: 45, color: Color(0xFF0D47A1))),
                const SizedBox(height: 10),
                const Text(
                  "HORIZON SUBLIME COLLEGE",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(_isAdminMode ? "Totaux globaux des inscrits" : "Espace Universitaire", style: const TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                _buildProfilLine("LIEU ET DATE DE NAISSANCE", "RDC"),
                _buildProfilLine("ADRESSE", "Non spécifiée"),
                _buildProfilLine("EMAIL", "contact@hsc100.com"),
                _buildProfilLine("NUMÉRO DE TÉLÉPHONE", "+243 000 000 000"),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.contact_page, color: Color(0xFF0D47A1)),
                  title: const Text("Mes identités", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSun300Tile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF263238))),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(description, style: const TextStyle(fontSize: 11, color: Colors.blueGrey)),
        ),
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  Widget _buildProfilLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.blueGrey)),
          Text(value, style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  void _openFeatureDetails(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), duration: const Duration(seconds: 2)));
  }

  void _showUnlockModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Système My Airtel Money", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
              const SizedBox(height: 8),
              co
