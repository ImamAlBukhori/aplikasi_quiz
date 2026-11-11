import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_profile_screen.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const lime = Color(0xFFB7F34A);

  String name = 'Football Player';
  String email = '';
  String education = 'Belum diatur';
  String nim = '';

  bool loading = true;
  bool loggingOut = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      name = prefs.getString('user_name') ?? 'Football Player';
      email = prefs.getString('user_email') ?? '';
      education = prefs.getString('user_education') ?? 'Belum diatur';
      nim = prefs.getString('user_nim') ?? '';
      loading = false;
    });
  }

  Future<void> _openEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const EditProfileScreen(),
      ),
    );

    if (!mounted) return;

    if (result == true) {
      await _loadProfile();
    }
  }

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1B2425),
          title: const Text(
            'Logout',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Apakah kamu yakin ingin keluar dari akun FootQuiz?',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text(
                'BATAL',
                style: TextStyle(color: Colors.white60),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text(
                'LOGOUT',
                style: TextStyle(
                  color: lime,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirm != true || !mounted) return;

    setState(() {
      loggingOut = true;
    });

    final prefs = await SharedPreferences.getInstance();

    // Hapus status sesi saja, jangan hapus data akun.
    await prefs.remove('is_logged_in');

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
          (route) => false,
    );
  }

  Widget _infoCard(String title, String value, IconData icon) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2425),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: lime, size: 23),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value.isEmpty ? '-' : value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101517),
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: loading
          ? const Center(
        child: CircularProgressIndicator(color: lime),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Column(
              children: [
                const SizedBox(height: 20),

                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Color(0xFF263A22),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: lime,
                    size: 55,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  email,
                  style: const TextStyle(color: Colors.white54),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: _openEditProfile,
                    icon: const Icon(Icons.edit),
                    label: const Text('EDIT PROFILE'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lime,
                      foregroundColor:
                      const Color(0xFF101517),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                _infoCard(
                  'Nama Lengkap',
                  name,
                  Icons.person_outline,
                ),

                _infoCard(
                  'Email',
                  email,
                  Icons.email_outlined,
                ),

                _infoCard(
                  'Jenjang Pendidikan',
                  education,
                  Icons.school_outlined,
                ),

                if (education == 'Kuliah')
                  _infoCard(
                    'NIM',
                    nim,
                    Icons.badge_outlined,
                  ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: loggingOut ? null : _logout,
                    icon: const Icon(Icons.logout),
                    label: const Text('LOGOUT'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.redAccent,
                      side: const BorderSide(
                        color: Colors.redAccent,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
