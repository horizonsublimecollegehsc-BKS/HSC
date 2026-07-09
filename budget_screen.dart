// =========================================================================
// PROJET : H.S.C.100 (Horizon Sublime College)
// COMPOSANT : budget_screen.dart (Flutter Screen - Onglet Comptabilité)
// DESCRIPTION : Gestion des activations par Airtel Money et historique des reçus
// REGLE FINANCIÈRE : Prix fixé à 4.00 USD | Taux strict H.S.C : 1 USD = 2350 CDF
// =========================================================================

import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({Key? key}) : super(key: key);

  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final _phoneController = TextEditingController();
  int _selectedMonthToActivate = 2; // Par défaut, suggère le mois suivant
  bool _isProcessingPayment = false;
  
  // Constantes de calcul
  final double _priceUsd = 4.00;
  final double _exchangeRate = 2350.00;

  // Simulation de l'historique des reçus récupéré depuis PostgreSQL (Trigger)
  final List<Map<String, String>> _receiptsHistory = [
    {
      "receiptNumber": "REC-20260708-A4F9E2B1",
      "date": "08/07/2026",
      "level": "Mois 1 (Frais d'inscription & d'accès)",
      "amount": "9.400,00 CDF (4.00 USD)",
      "status": "Validé"
    }
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  // Déclenchement du paiement Airtel Money
  void _executeAirtelMoneyPayment() async {
    if (_phoneController.text.isEmpty || _phoneController.text.length < 9) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Veuillez entrer un numéro Airtel Money valide (Ex: 097XXXXXXX)."),
        backgroundColor: Colors.redAccent,
      ));
      return;
    }

    setState(() { _isProcessingPayment = true; });

    // ICI : Envoi de la requête POST au NestJS (/payments/initiate)
    // payload: { studentId: "...", levelNumber: _selectedMonthToActivate, phoneNumber: _phoneController.text }
    await Future.delayed(const Duration(seconds: 3)); // Simulation du Push STK réseau

    setState(() { _isProcessingPayment = false; });

    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 10),
              Text("Requête envoyée", style: TextStyle(fontSize: 16)),
            ],
          ),
          content: Text(
            "Un message push Airtel Money de ${(_priceUsd * _exchangeRate).toStringAsFixed(2)} CDF a été envoyé sur le numéro ${_phoneController.text}.\n\nUne fois votre code PIN secret saisi, votre reçu sera généré et le cours sera débloqué à vie.",
            style: const TextStyle(fontSize: 13),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _phoneController.clear();
              },
              child: const Text("Compris"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalCdf = _priceUsd * _exchangeRate; // 4.00 * 2350 = 9400 CDF
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 850;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BLOC A : FORMULAIRE D'ACTIVATION ET CALCULATEUR DE TAUX
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Flex(
                  direction: isDesktop ? Axis.horizontal : Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Partie Gauche : Détails de la transaction
                    Expanded(
                      flex: isDesktop ? 1 : 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("ACTIVER UN MOIS DE COURS", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<int>(
                            value: _selectedMonthToActivate,
                            decoration: InputDecoration(
                              labelText: "Sélectionner le niveau à débloquer",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            items: List.generate(5, (i) => i + 2).map((month) {
                              return DropdownMenuItem<int>(
                                value: month,
                                child: Text("Mois $month - Accès permanent"),
                              );
                            }).toList(),
                            onChanged: (val) => setState(() => _selectedMonthToActivate = val!),
                          ),
                          const SizedBox(height: 14),
                          // Tableau récapitulatif des prix au taux fixe
                          Table(
                            children: [
                              TableRow(children: [
                                const Padding(padding: EdgeInsets.symmetric(vertical: 6), child: Text("Frais académiques standards :", style: TextStyle(fontSize: 12, color: Colors.slate))),
                                Text("${_priceUsd.toStringAsFixed(2)} USD", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.slate)),
                              ]),
                              TableRow(children: [
                                const Padding(padding: EdgeInsets.symmetric(vertical: 6), child: Text("Taux de change fixé (OSIL) :", style: TextStyle(fontSize: 12, color: Colors.slate))),
                                Text("${_exchangeRate.toStringAsFixed(2)} CDF / USD", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.slate)),
                              ]),
                              TableRow(children: [
                                const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text("Montant net à payer :", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold))),
                                Text("${totalCdf.toStringAsFixed(2)} CDF", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green)),
                              ]),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (isDesktop) const SizedBox(width: 40) else const SizedBox(height: 24),
                    
                    // Partie Droite : Saisie du numéro Airtel Money
                    Expanded(
                      flex: isDesktop ? 1 : 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("PASSERELLE AIRTEL MONEY RDC", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.slate)),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: "Numéro de téléphone Airtel",
                              hintText: "097XXXXXXX",
                              prefixIcon: const Icon(Icons.phone_android, color: Colors.redAccent),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade900),
                              onPressed: _isProcessingPayment ? null : _executeAirtelMoneyPayment,
                              child: _isProcessingPayment
                                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                  : const Text("INITIALISER LE PAIEMENT (CDF)"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            // BLOC B : HISTORIQUE DES REÇUS FISCAUX ÉMIS (ANTI-FRAU DE)
            const Text("VOS REÇUS ACADÉMIQUES OFFICIELS", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _receiptsHistory.length,
              itemBuilder: (context, index) {
                final receipt = _receiptsHistory[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade100, width: 1),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                      child: const Icon(Icons.receipt_long, color: Colors.green),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.between,
                      children: [
                        Text(receipt["receiptNumber"]!, style: const TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1E293B))),
                        Text(receipt["date"]!, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.top(6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Libellé : ${receipt["level"]!}", style: const TextStyle(fontSize: 12, color: Colors.slate)),
                          const SizedBox(height: 2),
                          Text("Total encaissé : ${receipt["amount"]!}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

