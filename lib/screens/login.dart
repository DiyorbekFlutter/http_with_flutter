import 'package:flutter/material.dart';
import 'package:http_with_flutter/services/http_service.dart';

import '../widgets/loading.dart';
import 'asosiy.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool showErrorTextForEmail = false;
  bool showErrorTextForPassword = false;
  String errorTextForEmail = '';
  String errorTextForPassword = '';
  bool inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        children: [
          const SizedBox(height: 100),
          const Image(
            width: 250,
            height: 250,
            image: AssetImage('assets/images/auth.png')
          ),
          const SizedBox(height: 60),
          TextField(
            onTap: () => setState(() => showErrorTextForEmail = false),
            controller: email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Username kiriting',
                prefixIcon: const Icon(Icons.email),
                errorText: showErrorTextForEmail ? errorTextForEmail : null,
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            onTap: () => setState(() => showErrorTextForPassword = false),
            controller: password,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                labelText: 'Parol',
                hintText: 'Parolni kiriting',
                prefixIcon: const Icon(Icons.lock),
                errorText: showErrorTextForPassword? errorTextForPassword : null,
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if(checkData){
                loading(context);
                setState(() => inProgress = true);
                String? response = await NetworkService.postDate(api: NetworkService.apiLogin, body: {
                  "username": email.text.trim(),
                  "password": password.text.trim()
                });
                navigatorPop;
                setState(() => inProgress = false);
                if(response != null){
                  pushAndRemoveUntil;
                } else {
                  showText('Nimadir xato ketdi !!!');
                }
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
            ),
            child: const Text('Login', style: TextStyle(fontSize: 22, color: Colors.white)),
          ),
        ],
      ),
    );
  }


  Future<void> get navigatorPop async => Navigator.pop(context);
  Future<void> get pushAndRemoveUntil async => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Main()), (route) => false);

  void showText(String text){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text))
    );
  }

  bool get checkData {
    bool check = true;
    if(inProgress) return false;
    if(email.text.trim().isEmpty){
      errorTextForEmail = 'Majburiy maydon';
      showErrorTextForEmail = true;
      check = false;
    }
    if(password.text.trim().isEmpty){
      errorTextForPassword = 'Majburiy maydon';
      showErrorTextForPassword = true;
      check = false;
    }
    if(password.text.trim().length<6 && password.text.trim().isNotEmpty){
      errorTextForPassword = "Eng kamida 6 ta belgi bo'lishi kerak";
      showErrorTextForPassword = true;
      check = false;
    }

    setState((){});
    return check;
  }
}
