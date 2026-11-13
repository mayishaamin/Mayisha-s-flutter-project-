
import 'package:flutter/material.dart';
import 'package:medicore_app/auth/register_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  bool _isLoading = false; // true thakle button e ghurano circle
  bool _hide = true; // password lukano na dekhano

  final _supabase = Supabase.instance.client;

  // Login button e click korle ei function cholbe
  Future<void> login() async {
    if (_isLoading) return;

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    setState(() {
      _isLoading = true;
    });

    try {
      await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      // Login successful hole email/password clear hobe
      if (!mounted) return;

      _emailController.clear();
      _passwordController.clear();

    } on AuthException catch (e) {

      // Vul email/password hole niche message dekhabe
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

      // Login sesh hole loading bondho hobe
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [

              // Shobar upor boro "MediCore" lekha
              Text(
                "MediCore",
                style: TextStyle(
                  fontFamily: 'serif',
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20),

              // Majhkhaner cream login box
              SizedBox(
                width: 350,
                child: Card(
                  color: Color.fromARGB(255, 255, 246, 247),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [

                          // Box er heading
                          Text(
                            "Welcome Back",
                            style: TextStyle(
                              fontFamily: 'serif',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "Sign in to continue",
                            style: TextStyle(
                              color: Color.fromARGB(255, 212, 108, 140),
                            ),
                          ),

                          SizedBox(height: 20),

                          // Email likhar box
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "Email",
                              hintText: "Enter email",
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Field is empty!!";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 10),

                          // Password likhar box (dan pashe chokh icon)
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _hide,
                            decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "Enter password",
                              prefixIcon: Icon(Icons.lock_outline),

                              // Chokh icon e click korle password dekha jabe
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    setState(() => _hide = !_hide),
                                icon: Icon(
                                  _hide
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Field is empty!!";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 10),

                          // Holud Login button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _isLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        login();
                                      }
                                    },
                              child: _isLoading
                                  ? CircularProgressIndicator()
                                  : Text("Login"),
                            ),
                          ),

                          SizedBox(height: 20),

                          // Niche "Register" link, click korle Register page e jabe
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            ),
                            child: Text(
                              "Don't have an account? Register",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
