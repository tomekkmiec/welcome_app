import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var errorMessage = '';
  var creatingAccount = false;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  creatingAccount == true ? 'Zarejestruj Się' : 'Zaloguj Się',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: widget.emailController,
                  decoration: const InputDecoration(
                    hintText: 'E-mail',
                    errorText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: widget.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Hasło',
                    errorText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: FractionalOffset.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isChecked = !_isChecked;
                          });
                        },
                        child: Icon(
                          Icons.check_box,
                          color: _isChecked ? Colors.green : Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(errorMessage),
                ElevatedButton(
                  onPressed: () async {
                    if (creatingAccount == true) {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: widget.emailController.text,
                                password: widget.passwordController.text);
                      } catch (error) {
                        setState(() {
                          errorMessage = error.toString();
                        });
                      }
                    } else {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: widget.emailController.text,
                            password: widget.passwordController.text);
                      } catch (error) {
                        setState(() {
                          errorMessage = error.toString();
                        });
                      }
                    }
                  },
                  child: Text(creatingAccount == true
                      ? 'Zarejestruj się'
                      : 'Zaloguj Się'),
                ),
                if (creatingAccount == false) ...[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        creatingAccount = true;
                      });
                    },
                    child: const Text('Utwórz konto'),
                  ),
                ],
                if (creatingAccount == true) ...[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        creatingAccount = false;
                      });
                    },
                    child: const Text('Zaloguj Się'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
