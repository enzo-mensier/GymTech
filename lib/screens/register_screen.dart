import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';
import '../services/auth_service.dart';
import '../models/utilisateur.dart';
import '../widgets/date_input.dart';
import '../models/genre.dart';
import '../screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  Genre? _selectedGenre;
  final _dateNaissanceController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (_passwordController.text != _confirmPasswordController.text) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Les mots de passe ne correspondent pas',
                style: AppTextStyles.regular.copyWith(color: Colors.white),
              ),
              backgroundColor: AppColors.negativeColor,
            ),
          );
          return;
        }

        final utilisateur = Utilisateur(
          nomUser: _nomController.text,
          prenomUser: _prenomController.text,
          emailUser: _emailController.text,
          motDePasseUser: _passwordController.text,
          genreUser: _selectedGenre!,
          dateNaissanceUser: _dateNaissanceController.text,
        );

        final authService = AuthService();
        final response = await authService.register(utilisateur);

        if (response['success']) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Erreur d\'inscription: ${response['message']}',
                style: AppTextStyles.regular.copyWith(color: Colors.white),
              ),
              backgroundColor: AppColors.negativeColor,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Erreur d\'inscription: ${e.toString()}',
              style: AppTextStyles.regular.copyWith(color: Colors.white),
            ),
            backgroundColor: AppColors.negativeColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/gymtech_logo.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 48),

                  // Champ Nom
                  TextFormField(
                    controller: _nomController,
                    decoration: InputDecoration(
                      labelText: 'Nom',
                      labelStyle: AppTextStyles.regular.copyWith(color: AppColors.contrastColor),
                      prefixIcon: Icon(Icons.person, color: AppColors.contrastColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.contrastColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.contrastColor),
                      ),
                      floatingLabelStyle: AppTextStyles.regular.copyWith(color: AppColors.contrastColor),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre nom';
                      }
                      if (value.length < 2) {
                        return 'Le nom doit contenir au moins 2 caractères';
                      }
                      if (value.contains(RegExp(r'[0-9]'))) {
                        return 'Le nom ne doit pas contenir de chiffres';
                      }
                      if (!value.contains(RegExp(r'[a-zA-Z]'))) {
                        return 'Le nom doit contenir des lettres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),

                  // Champ Prénom
                  TextFormField(
                    controller: _prenomController,
                    decoration: InputDecoration(
                      labelText: 'Prénom',
                      labelStyle: AppTextStyles.regular.copyWith(color: AppColors.contrastColor),
                      prefixIcon: Icon(Icons.person, color: AppColors.contrastColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.contrastColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.contrastColor),
                      ),
                      floatingLabelStyle: AppTextStyles.regular.copyWith(color: AppColors.contrastColor),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre prénom';
                      }
                      if (value.length < 2) {
                        return 'Le prénom doit contenir au moins 2 caractères';
                      }
                      if (value.contains(RegExp(r'[0-9]'))) {
                        return 'Le prénom ne doit pas contenir de chiffres';
                      }
                      if (!value.contains(RegExp(r'[a-zA-Z]'))) {
                        return 'Le prénom doit contenir des lettres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),

                  // Champ Email
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: AppTextStyles.regular.copyWith(color: AppColors.contrastColor),
                      prefixIcon: Icon(Icons.email, color: AppColors.contrastColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.contrastColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.contrastColor),
                      ),
                      floatingLabelStyle: AppTextStyles.regular.copyWith(color: AppColors.contrastColor),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre email';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Veuillez entrer un email valide';
                      }
                      if (value.length > 255) {
                        return 'L\'email est trop long (maximum 255 caractères)';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),

                  // Champ Mot de passe
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      labelStyle: AppTextStyles.regular.copyWith(color: AppColors.contrastColor),
                      prefixIcon: Icon(Icons.lock, color: AppColors.contrastColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.contrastColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.contrastColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.contrastColor),
                      ),
                      floatingLabelStyle: AppTextStyles.regular.copyWith(color: AppColors.contrastColor),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un mot de passe';
                      }
                      if (value.length < 6) {
                        return 'Le mot de passe doit contenir au moins 6 caractères';
                      }
                      if (value.length > 255) {
                        return 'Le mot de passe est trop long (maximum 255 caractères)';
                      }
                      if (!value.contains(RegExp(r'[a-zA-Z]'))) {
                        return 'Le mot de passe doit contenir au moins une lettre';
                      }
                      if (!value.contains(RegExp(r'[0-9]'))) {
                        return 'Le mot de passe doit contenir au moins un chiffre';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),

                  // Champ Confirmation du mot de passe
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Confirmer le mot de passe',
                      labelStyle: AppTextStyles.regular.copyWith(color: AppColors.contrastColor),
                      prefixIcon: Icon(Icons.lock, color: AppColors.contrastColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.contrastColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.contrastColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.contrastColor),
                      ),
                      floatingLabelStyle: AppTextStyles.regular.copyWith(color: AppColors.contrastColor),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez confirmer votre mot de passe';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),

                  // Champ Genre
                  DropdownButtonFormField<Genre>(
                    value: _selectedGenre,
                    decoration: InputDecoration(
                      labelText: 'Genre',
                      labelStyle: AppTextStyles.regular.copyWith(color: AppColors.contrastColor),
                      prefixIcon: Icon(Icons.person, color: AppColors.contrastColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.contrastColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.contrastColor),
                      ),
                      floatingLabelStyle: AppTextStyles.regular.copyWith(color: AppColors.contrastColor),
                    ),
                    items: Genre.values.map((genre) {
                      return DropdownMenuItem<Genre>(
                        value: genre,
                        child: Text(
                          genre.displayName,
                          style: AppTextStyles.regular,
                        ),
                      );
                    }).toList(),
                    onChanged: (Genre? value) {
                      setState(() {
                        _selectedGenre = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Veuillez sélectionner un genre';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),

                  // Champ Date de naissance
                  DateInput(
                    controller: _dateNaissanceController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre date de naissance';
                      }
                      try {
                        final date = DateTime.parse(value.split('/').reversed.join('-'));
                        final now = DateTime.now();
                        if (date.isAfter(now)) {
                          return 'La date de naissance ne peut pas être dans le futur';
                        }
                        final age = now.year - date.year;
                        if (age < 18) {
                          return 'Vous devez avoir au moins 18 ans pour vous inscrire';
                        }
                      } catch (e) {
                        return 'Date invalide';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),

                  // Bouton Inscription
                  ElevatedButton(
                    onPressed: _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: AppColors.backgroundColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'S\'inscrire',
                      style: AppTextStyles.semiBold.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Lien vers Login
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      'Déjà inscrit ? Se connecter',
                      style: AppTextStyles.regular.copyWith(
                        color: AppColors.contrastColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    // Pas de besoin de disposer _selectedGenre car c'est une variable simple
    _dateNaissanceController.dispose();
    super.dispose();
  }
}
