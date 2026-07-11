import 'package:flutter/material.dart';

void main() {
  runApp(const HorizonSublimeCollegeApp());
}

class HorizonSublimeCollegeApp extends StatelessWidget {
  const HorizonSublimeCollegeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horizon Sublime College',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // L'application démarre directement sur ton écran de connexion
      home: const LoginScreen(), 
      debugShowCheckedModeBanner: false,
    );
  }
}

// ==========================================
// 1. ÉCRAN DE CONNEXION (LoginScreen)
// ==========================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    // Connexion simple pour le test : redirige vers le Dashboard
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeDashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'HSC - Connexion',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: "Nom d'utilisateur",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Mot de passe',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Se connecter'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 2. TABLEAU DE BORD (HomeDashboardScreen)
// ==========================================
class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HSC - Tableau de Bord'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          )
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildMenuCard(
            context,
            title: 'Budget & Finances',
            icon: Icons.account_balance_wallet,
            color: Colors.green,
            destination: const BudgetScreen(),
          ),
          _buildMenuCard(
            context,
            title: 'Examens Sécurisés',
            icon: Icons.security,
            color: Colors.red,
            destination: const ExamSecureScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, {required String title, required IconData icon, required Color color, required Widget destination}) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => destination)),
      child: Card(
        elevation: 4,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 12),
              Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 3. ÉCRAN BUDGET (BudgetScreen)
// ==========================================
class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budget & Finances')),
      body: const Center(
        child: Text('Gestion du Budget HSC (Validé)', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

// ==========================================
// 4. ÉCRAN EXAMEN (ExamSecureScreen)
// ==========================================
class ExamSecureScreen extends StatelessWidget {
  const ExamSecureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Zone Examen Sécurisé')),
      body: const Center(
        child: Text('Espace d\'Examen Sécurisé HSC (Validé)', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
