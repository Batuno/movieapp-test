import 'package:flutter/material.dart';
import 'package:movie/providers/common.dart';
import 'package:provider/provider.dart';
import '../global_keys.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      Provider.of<CommonProvider>(GlobalKeys.navigatorKey.currentContext!,
              listen: false)
          .onLogin();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Let's sign you in.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Welcome back.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
                const Text(
                  "You've been missed!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _phoneCtrl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Хоосон байж болохгүй";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.6),
                        width: 1,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                    ),
                    label: const Text("Утасны дугаар"),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passCtrl,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Хоосон байж болохгүй";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.6),
                        width: 1,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                    ),
                    label: const Text("Нууц үг"),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: _onSubmit,
                child: const Text("Нэвтрэх"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
