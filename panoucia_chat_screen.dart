// =========================================================================
// PROJET : H.S.C.100 (Horizon Sublime College)
// COMPOSANT : panoucia_chat_screen.dart (Flutter Screen - Onglet Assistant IA)
// DESCRIPTION : Interface conversationnelle avec Panoucia IA
// PROPRIÉTÉ : © OSIL Digital – Tous droits réservés (Signature obligatoire)
// =========================================================================

import 'package:flutter/material.dart';

class PanouciaChatScreen extends StatefulWidget {
  const PanouciaChatScreen({Key? key}) : super(key: key);

  @override
  _PanouciaChatScreenState createState() => _PanouciaChatScreenState();
}

class _PanouciaChatScreenState extends State<PanouciaChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      "sender": "panoucia",
      "text": "Hello! I am Panoucia, your H.S.C.100 Academic Assistant. How can I help you practice your English today?",
      "time": "Now"
    }
  ];
  bool _isTyping = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  // Émission du message vers l'API d'intelligence artificielle
  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _messageController.clear();
    setState(() {
      _messages.add({"sender": "student", "text": text, "time": "Now"});
      _isTyping = true;
    });

    // ICI : Liaison future avec NestJS (/exam-ia/chat) qui interroge le modèle
    await Future.delayed(const Duration(seconds: 2)); // Simulation de réflexion de l'IA

    setState(() {
      _isTyping = false;
      _messages.add({
        "sender": "panoucia",
        "text": "Excellent vocabulary usage! To improve your sentence structure, consider using complex connectors. Let's practice another scenario.",
        "time": "Now"
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // 1. SIGNATURE SÉCURISÉE DE PROPRIÉTÉ DE L'IA (OSIL DIGITAL)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: const Color(0xFF0F172A), // Noir ardoise profond
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.verified_user_outlined, color: Colors.cyanAccent, size: 14),
                SizedBox(width: 8),
                Text(
                  "POWERED BY PANOUCIA IA © OSIL DIGITAL – PROPRIÉTÉ EXCLUSIVE",
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8
                  ),
                ),
              ],
            ),
          ),

          // 2. CORPS DE LA DISCUSSION (DEFILANT)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                bool isMe = msg["sender"] == "student";

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: isMe ? const Color(0xFF1E3A8A) : Colors.white,
                      borderRadius: BorderRadius.circular(16).copyWith(
                        topRight: isMe ? const Radius.circular(0) : const Radius.circular(16),
                        topLeft: isMe ? const Radius.circular(16) : const Radius.circular(0),
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isMe ? "Moi" : "Panoucia IA",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isMe ? Colors.white70 : const Color(0xFF1E3A8A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          msg["text"]!,
                          style: TextStyle(
                            fontSize: 13,
                            color: isMe ? Colors.white : const Color(0xFF334155),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // INDICATEUR DE Saisie DE L'IA
          if (_isTyping)
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Panoucia analyse votre anglais...",
                  style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.grey),
                ),
              ),
            ),

          // 3. BARRE DE COMMANDE & CHAMP DE Saisie (CLAVIER)
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: "Saisissez votre message en anglais...",
                      hintStyle: const TextStyle(fontSize: 13),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      filled: true,
                      fillColor: const Color(0xFFF1F5F9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E3A8A),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send, color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

