Widget _buildAccueilTab() {
  return SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ==========================================
        // SECTION FORMATION (Style Sun300 épuré)
        // ==========================================
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            "FORMATION PROGRESSIVE",
            style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF546E7A), fontSize: 12, letterSpacing: 1.2),
          ),
        ),

        // 1. MODULE COURS
        _buildSun300Tile(
          icon: Icons.menu_book_rounded,
          iconColor: const Color(0xFF1E88E5),
          title: "1. COURS MAGISTRAUX",
          description: "Suivi complet du programme sur 6 mois d'études.",
          trailing: Container(
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
          onTap: () => _showUnlockModal(context),
        ),

        // 2. HORAIRE MENSUEL
        _buildSun300Tile(
          icon: Icons.calendar_today_rounded,
          iconColor: const Color(0xFF43A047),
          title: "2. HORAIRE DES COURS",
          description: "Calendrier académique officiel mis à jour mensuellement.",
          onTap: () => _openFeatureDetails("Ouverture du calendrier H.S.C.100..."),
        ),

        // 3. EXAMENS IA GÉNÉRATIVE
        _buildSun300Tile(
          icon: Icons.error_outline_rounded,
          iconColor: const Color(0xFFE53935),
          title: "3. EXAMEN INTELLIGENT (IA)",
          description: "Disponible chaque 30 du mois. 10 questions (3 tentatives max).",
          trailing: const Badge(label: Text("IA"), backgroundColor: Colors.red),
          onTap: () => _openFeatureDetails("Initialisation du protocole anti-triche Panoucia..."),
        ),

        // 4. ANNONCES OFFICIELLES
        _buildSun300Tile(
          icon: Icons.campaign_rounded,
          iconColor: const Color(0xFFFB8C00),
          title: "4. ANNONCES DU COLLÈGE",
          description: "Retrouvez ici toutes les communications urgentes de l'administration.",
          onTap: () => _openFeatureDetails("Chargement des annonces récentes..."),
        ),

        // 5. BIBLIOTHÈQUE NUMÉRIQUE
        _buildSun300Tile(
          icon: Icons.local_library_rounded,
          iconColor: const Color(0xFF8E24AA),
          title: "5. BIBLIOTHÈQUE H.S.C.",
          description: "Accès aux ouvrages de référence d'anglais pour 0.5\$.",
          onTap: () => _openFeatureDetails("Accès sécurisé à la bibliothèque..."),
        ),

        // 6. CITATIONS DU COACH
        _buildSun300Tile(
          icon: Icons.format_quote_rounded,
          iconColor: const Color(0xFF00ACC1),
          title: "6. CITATIONS DU COACH",
          description: "Partagez instantanément sur Facebook, WhatsApp et Instagram.",
          onTap: () => _openFeatureDetails("Ouverture des citations de Coach Joseph B..."),
        ),

        // 7. MON CERTIFICAT FINAL
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

        // 8. WHATSAPP DU COACH
        _buildSun300Tile(
          icon: Icons.phone_android_rounded,
          iconColor: Colors.green,
          title: "8. WHATSAPP COACH JOSEPH B.",
          description: "Assistance et encadrement direct : 0906693229",
          onTap: () {},
        ),

        // 9. CLUB D'ANGLAIS WHATSAPP
        _buildSun300Tile(
          icon: Icons.groups_rounded,
          iconColor: const Color(0xFF25D366),
          title: "9. CLUB D'ANGLAIS (WHATSAPP)",
          description: "Lien officiel d'intégration du groupe de discussion.",
          trailing: const Icon(Icons.open_in_new, size: 16, color: Colors.grey),
          onTap: () {},
        ),

        // 10. CLUB D'ANGLAIS TELEGRAM
        _buildSun300Tile(
          icon: Icons.telegram_rounded,
          iconColor: const Color(0xFF26A69A),
          title: "10. CLUB D'ANGLAIS (TELEGRAM)",
          description: "Rejoignez le canal officiel de l'académie H.S.C.",
          trailing: const Icon(Icons.open_in_new, size: 16, color: Colors.grey),
          onTap: () {},
        ),
      ],
    ),
  );
}

// COMPOSANT GRAPHIQUE COMPATIBLE MAQUETTE SUN300
Widget _buildSun300Tile({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String description,
  Widget? trailing,
  required VoidCallback onTap,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10), // Correction appliquée ici !
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 2)),
      ],
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

// MODAL MY AIRTEL POUR LE PAIEMENT DES COMPTES
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
            const Text("Dépôt requis pour débloquer le mois sélectionné :", style: TextStyle(fontSize: 13, color: Colors.grey)),
            const Divider(height: 24),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Numéro destinataire :", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("0990652032", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Montant forfaitaire :"),
                Text("4.00 \$ (Taux : 2350 CDF)", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Équivalent automatique :"),
                Text("56.400 CDF (Total 6 mois)", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: const Size.fromHeight(48)),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Paiement validé ! Bouton 'OUVRIR LE COURS' disponible.")),
                );
              },
              child: const Text("LANCER LE DÉPÔT AIRTEL MONEY", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      );
    },
  );
}
