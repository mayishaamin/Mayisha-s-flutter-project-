
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  final TextEditingController _cPasswordController =
      TextEditingController();

  bool _isLoading = false;
  bool _hidePassword = true;
  bool _hideCPassword = true;

  final _supabase = Supabase.instance.client;

  // Register button e click korle ei function cholbe
  Future<void> register() async {
    if (_isLoading) return;

    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    setState(() {
      _isLoading = true;
    });

    try {
      // 1. Supabase auth e account khola
     final authResponse = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      final user = authResponse.user;

      if (user == null) {
        throw Exception("Registration failed. Please try again.");
      }

      // 2. Naam, email profiles table e save (Home e Welcome dekhanor jonno)
      await _supabase.from('profiles').insert({
        'id': user.id,
        'name': name,
        'email': email,
      });

      // Register successful hole message dekhabe
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Registered Successfully!!"),
        ),
      );

      // Login page e fire jabe
      Navigator.pop(context);

    } on AuthException catch (e) {

      // Email already used ba password problem hole message dekhabe
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );

    } catch (e) {

      // Onno kono problem hole ei message dekhabe
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong: $e")),
      );

    } finally {

      // Register sesh hole loading bondho hobe
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Controller gula kaj sesh hole memory theke remove korbe
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _cPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Upor er wine AppBar
      appBar: AppBar(
        title: Text("Register"),
      ),

      body: Center(
        child: SingleChildScrollView(

          // Majhkhaner cream register box
          child: SizedBox(
            width: 350,
            child: Card(
              color: Color.fromARGB(255, 255, 246, 247),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      // Box er heading
                      Text(
                        "Create Account",
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 20),

                      // Naam likhar box (shudhu letter allowed)
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          hintText: "Enter Name",
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return "Enter name";
                          }

                          if (!RegExp(r'^[a-zA-Z .]+$')
                              .hasMatch(value.trim())) {
                            return "Please enter a valid name!!";
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 10),

                      // Email likhar box
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Enter Email",
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return "Enter email";
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 10),

                      // Password box (8+ char, boro/choto letter, number, symbol lagbe)
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _hidePassword,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Enter Password",
                          prefixIcon: Icon(Icons.lock_outline),

                          // Chokh icon e click korle password dekha jabe
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                            icon: Icon(
                              _hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Color.fromARGB(
                                  255, 212, 108, 140),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter password";
                          }

                          if (!RegExp(
                            r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\S+$).{8,}$',
                          ).hasMatch(value)) {
                            return "Enter a strong password!!";
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 10),

                      // Confirm password box (upor er password er shathe mil thakte hobe)
                      TextFormField(
                        controller: _cPasswordController,
                        obscureText: _hideCPassword,
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          hintText: "Re-enter Password",
                          prefixIcon: Icon(Icons.lock_outline),

                          // Chokh icon e click korle confirm password dekha jabe
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _hideCPassword = !_hideCPassword;
                              });
                            },
                            icon: Icon(
                              _hideCPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Color.fromARGB(
                                  255, 212, 108, 140),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter confirm password";
                          }

                          if (value != _passwordController.text) {
                            return "Password and confirm password doesn't match";
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 10),

                      // Holud Register button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!
                                      .validate()) {
                                    register();
                                  }
                                },

                          child: _isLoading
                              ? CircularProgressIndicator()
                              : Text("Register"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
