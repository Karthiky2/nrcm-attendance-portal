import 'package:flutter/material.dart';
import 'package:attendance_portal/screens/year_branch_section_screen.dart';
import 'package:attendance_portal/screens/admin_login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  bool hidePassword = true;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // ================= BACKGROUND =================

          Positioned.fill(
            child: Image.asset(
              "assets/images/college.jpg",
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(.65),
                    Colors.black.withOpacity(.45),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // ================= LOGIN CARD =================

          Center(
            child: SingleChildScrollView(
              child: Container(
                width: 420,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.15),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white54,
                    width: 1.5,
                  ),
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    const Icon(
                      Icons.school,
                      size: 70,
                      color: Colors.white,
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "NARSIMHA REDDY\nENGINEERING COLLEGE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Attendance Management System",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 17,
                      ),
                    ),

                    const SizedBox(height: 35),

                    TextField(
                      controller: userController,
                      decoration: InputDecoration(
                        hintText: "Username",
                        prefixIcon: const Icon(Icons.person),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: passController,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [

                        Checkbox(
                          value: rememberMe,
                          activeColor: const Color(0xff6B103D),
                          onChanged: (v) {
                            setState(() {
                              rememberMe = v!;
                            });
                          },
                        ),

                        const Text(
                          "Remember Me",
                          style: TextStyle(color: Colors.white),
                        ),

                        const Spacer(),

                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff6B103D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        onPressed: () {

                          String user = userController.text.trim();
                          String pass = passController.text.trim();

                          if (user == "admin" && pass == "1234") {

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Login Successful"),
                              ),
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const YearBranchSectionScreen(),
                              ),
                            );

                          } else {

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Invalid Username or Password"),
                              ),
                            );

                          }

                        },
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminLoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Admin Login",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}