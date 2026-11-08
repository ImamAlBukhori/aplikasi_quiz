
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const lime = Color(0xFFB7F34A);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nimController = TextEditingController();

  final List<String> educationLevels = [
    'SD',
    'SMP',
    'SMA',
    'Kuliah',
    'Kerja',
  ];

  String selectedEducation = 'SMA';
  bool loading = true;
  bool saving = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    final savedEducation =
        prefs.getString('user_education') ?? 'SMA';

    setState(() {
      _nameController.text =
          prefs.getString('user_name') ?? '';

      selectedEducation = educationLevels.contains(savedEducation)
          ? savedEducation
          : 'SMA';

      _nimController.text =
          prefs.getString('user_nim') ?? '';

      loading = false;
    });
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      saving = true;
    });

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'user_name',
      _nameController.text.trim(),
    );

    await prefs.setString(
      'user_education',
      selectedEducation,
    );

    if (selectedEducation == 'Kuliah') {
      await prefs.setString(
        'user_nim',
        _nimController.text.trim(),
      );
    } else {
      await prefs.remove('user_nim');
    }

    if (!mounted) return;

    setState(() {
      saving = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile berhasil diperbarui!'),
        backgroundColor: Color(0xFF263A22),
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101517),
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xFF101517),
        foregroundColor: Colors.white,
      ),
      body: loading
          ? const Center(
        child: CircularProgressIndicator(color: lime),
      )
          : SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 550),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Icon(
                        Icons.account_circle,
                        color: lime,
                        size: 90,
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      'Nama Lengkap',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 9),

                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: _decoration(
                        'Masukkan nama lengkap',
                        Icons.person_outline,
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty) {
                          return 'Nama tidak boleh kosong';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 22),

                    const Text(
                      'Jenjang Pendidikan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 9),

                    DropdownButtonFormField<String>(
                      initialValue: selectedEducation,
                      dropdownColor: const Color(0xFF1B2425),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: _decoration(
                        'Pilih pendidikan',
                        Icons.school_outlined,
                      ),
                      items: educationLevels.map((level) {
                        return DropdownMenuItem<String>(
                          value: level,
                          child: Text(level),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedEducation = value;
                          });
                        }
                      },
                    ),

                    if (selectedEducation == 'Kuliah') ...[
                      const SizedBox(height: 22),

                      const Text(
                        'Nomor Induk Mahasiswa (NIM)',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 9),

                      TextFormField(
                        controller: _nimController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: _decoration(
                          'Masukkan NIM',
                          Icons.badge_outlined,
                        ),
                        validator: (value) {
                          if (selectedEducation == 'Kuliah' &&
                              (value == null ||
                                  value.trim().isEmpty)) {
                            return 'NIM tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ],

                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: saving ? null : _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: lime,
                          foregroundColor:
                          const Color(0xFF101517),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: saving
                            ? const CircularProgressIndicator(
                          color: Color(0xFF101517),
                        )
                            : const Text(
                          'SIMPAN PERUBAHAN',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _decoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white38),
      prefixIcon: Icon(icon, color: lime),
      filled: true,
      fillColor: const Color(0xFF1B2425),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.white12),
      ),
    );
  }
}
