import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:store/models/user_model.dart';
import 'package:store/screens/create_account_screen.dart';
import 'package:store/screens/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onSuccess() async {
    Navigator.of(context).pop();
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Erro ao realizar cadastro"),
      backgroundColor: Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          TextButton(
            style: ButtonStyle(
              enableFeedback: true,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CreateAccountScreen()));
            },
            child: Text(
              "Criar Conta",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(hintText: "Email"),
                validator: (email) {
                  if (email!.isEmpty || !email.contains("@")) {
                    return "E-mail invalido!";
                  }
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Senha"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (password) {
                    if (password!.isEmpty || password.length < 6) {
                      return "Senha invalida";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Esqueci a senha",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                  fixedSize: MaterialStateProperty.all(
                    Size.fromHeight(50),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    model.signIn(
                        email: _emailController.text,
                        password: _passwordController.text,
                        onSuccess: _onSuccess,
                        onFail: _onFail);
                  }
                },
                child: !model.isLoading
                    ? Text(
                        "Entrar",
                        style: TextStyle(fontSize: 18),
                      )
                    : CircularProgressIndicator(),
              )
            ],
          ),
        );
      }),
    );
  }
}
