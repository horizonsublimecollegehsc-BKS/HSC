// =========================================================================
// PROJET : H.S.C.100 (Horizon Sublime College)
// COMPOSANT : exam_secure_screen.dart (Flutter Ultra-Secure Screen)
// DESCRIPTION : Système d'examen du 30 du mois avec détection de triche
// ANTI-TRICHE : Interception du changement d'onglet ou sortie d'application
// =========================================================================

import 'package:flutter/material.dart';

class LevelVideosScreen extends StatefulWidget {
  final int levelNumber;
  const LevelVideosScreen({Key? key, required this.levelNumber}) : super(key: key);

  @override
  _LevelVideosScreenState createState() => _LevelVideosScreenState();
}

class _LevelVideosScreenState extends State<LevelVideosScreen> {
  // Simule les 10 cadres vidéos récupérés depuis le serveur Science
  final List<Map<String, String>> _videos = List.generate(10, (index) => {
    "title": "Cours ${index + 1} : Structure et Fluidité",
    "duration": "14:25",
    "url": "https://science.hsc100.edu/stream/v_${index + 1}.mp4"
  });

  int _activeVideoIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 850;

    return Scaffold(
      appBar: AppBar(
        title: Text("MOIS ${widget.levelNumber} - ESPACE VIDÉO SÉCURISÉ"),
        actions: [
          // Bouton d'accès à l'examen du 30 du mois
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC2626)), // Rouge Alerte
              icon: const Icon(Icons.assignment_late, size: 16, color: Colors.white),
              label: const Text("PASSER L'EXAMEN DU 30"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SecureExamScreen(monthIndex: widget.levelNumber)),
                );
              },
            ),
          )
        ],
      ),
      body: Flex(
        direction: isDesktop ? Axis.horizontal : Axis.vertical,
        children: [
          // ÉCRAN DE LECTURE (STREAMING PUR - SANS STOCKAGE CACHE)
          Expanded(
            flex: isDesktop ? 2 : 0,
            child: Container(
              color: Colors.black,
              aspectRatio: 16 / 9,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.play_circle_outline, size: 80, color: Colors.white60),
                    const SizedBox(height: 12),
                    Text(
                      "Streaming Direct : ${_videos[_activeVideoIndex]['title']}",
                      style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Sécurité H.S.C.100 : Enregistrement local et mise en cache interdits.",
                      style: TextStyle(color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // PLAYLIST DES 10 CADRES DE FORMATION
          Expanded(
            flex: isDesktop ? 1 : 1,
            child: Container(
              color: Colors.white,
              child: ListView.separated(
                itemCount: _videos.length,
                separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                itemBuilder: (context, index) {
                  bool isPlaying = index == _activeVideoIndex;
                  return ListTile(
                    tileColor: isPlaying ? const Color(0xFFEFF6FF) : Colors.white,
                    leading: Icon(
                      isPlaying ? Icons.play_arrow : Icons.video_library_outlined,
                      color: isPlaying ? const Color(0xFF1E3A8A) : Colors.slate,
                    ),
                    title: Text(
                      _videos[index]["title"]!,
                      style: TextStyle(
                        fontSize: 13, 
                        fontWeight: isPlaying ? FontWeight.bold : FontWeight.normal,
                        color: isPlaying ? const Color(0xFF1E3A8A) : const Color(0xFF334155),
                      ),
                    ),
                    subtitle: Text("Cadre ${index + 1} • ${_videos[index]['duration']}", style: const TextStyle(fontSize: 11)),
                    trailing: const Icon(Icons.lock_open, size: 14, color: Colors.green),
                    onTap: () => setState(() => _activeVideoIndex = index),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

// =========================================================================
// INTERFACE DE L'EXAMEN SÉCURISÉ (AVEC DÉTECTION DU CYCLE DE VIE)
// =========================================================================
class SecureExamScreen extends StatefulWidget {
  final int monthIndex;
  const SecureExamScreen({Key? key, required this.monthIndex}) : super(key: key);

  @override
  _SecureExamScreenState createState() => _SecureExamScreenState();
}

class _SecureExamScreenState extends State<SecureExamScreen> with WidgetsBindingObserver {
  int _cheatAttempts = 0;
  final int _maxAllowedAttempts = 2;
  bool _isExamCancelled = false;

  @override
  void initState() {
    super.initState();
    // Activation de la surveillance du cycle de vie du système
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // INTERCEPTION LOGIQUE UNIQUE : Détecte quand l'étudiant quitte l'onglet ou l'app
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_isExamCancelled) return;

    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      setState(() {
        _cheatAttempts++;
        if (_cheatAttempts >= _maxAllowedAttempts) {
          _isExamCancelled = true;
          _triggerBackendExamCancellation();
        } else {
          _showCheatWarningDialog();
        }
      });
    }
  }

  // Envoi instantané du flag de triche à l'API NestJS
  void _triggerBackendExamCancellation() {
    // ICI : Appeler apiService.post('/exam-ia/cancel', { monthIndex: widget.monthIndex })
    // Écrit automatiquement l'action 'EXAM_CANCELLED_TRICHE' dans activity_logs sur PostgreSQL
    debugPrint("ALERTE CRITIQUE : Examen annulé pour cause de triche.");
  }

  void _showCheatWarningDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 28),
            SizedBox(width: 10),
            Text("ALERTE TRICHE DETECTÉE", style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(
          "Sécurité H.S.C.100 : Vous avez tenté de changer d'onglet ou de quitter l'écran d'examen.\n\nAvertissement : $_cheatAttempts / $_maxAllowedAttempts. Au prochain essai, votre examen sera définitivement annulé (Note 00/20).",
          style: const TextStyle(fontSize: 13),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("RETOURNER À L'EXAMEN"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isExamCancelled) {
      return Scaffold(
        backgroundColor: const Color(0xFFFEF2F2),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.gavel, size: 90, color: Colors.red),
                const SizedBox(height: 20),
                const Text("EXAMEN ANNULÉ", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF991B1B))),
                const SizedBox(height: 12),
                const Text(
                  "Le protocole anti-triche a invalidé votre session car vous avez quitté l'environnement d'examen réglementaire. Cette tentative a été enregistrée et transmise à la direction générale.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Color(0xFF7F1D1D)),
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("RETOURNER AU TABLEAU DE BORD"),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ENTÊTE EN TEMPS REEL
              Row(
                mainAxisAlignment: MainAxisAlignment.between,
                children: [
                  Text("EXAMEN SÉCURISÉ – MOIS ${widget.monthIndex}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: const Color(0xFFFFF7ED), borderRadius: BorderRadius.circular(12)),
                    child: const Row(
                      children: [
                        Icon(Icons.timer, color: Colors.orange, size: 16),
                        SizedBox(width: 6),
                        Text("Temps restant : 45:00", style: TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 20),
              
              // FAUX QUESTIONNAIRE POUR LA COMPLÉTUDE GRAPHIQUE
              const Text("Question 1 : Complétez la phrase suivante avec le connecteur approprié :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text("\"We decided to finalize the software architecture ________ the client hadn't signed the contract yet.\"", style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: Colors.slate)),
              ),
              ...["A) In order to", "B) Although", "C) Despite", "D) Consequently"].map((option) => Card(
                elevation: 0,
                color: const Color(0xFFF8FAFC),
                margin: const EdgeInsets.only(bottom: 10),
                child: RadioListTile<String>(
                  title: Text(option, style: const TextStyle(fontSize: 13)),
                  value: option,
                  groupValue: null,
                  onChanged: (val) {},
                ),
              )).toList(),
              
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Soumission de vos réponses à Panoucia IA...")));
                    Navigator.pop(context);
                  },
                  child: const Text("SOUMETTRE MES RÉPONSES"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

