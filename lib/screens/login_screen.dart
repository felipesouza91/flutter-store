import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:store/models/user_model.dart';
import 'package:store/screens/create_account_screen.dart';

class LoginScreem extends StatelessWidget {
  LoginScreem({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

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
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => CreateAccountScreem()));
            },
            child: Text(
              "Criar Conta",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        if (model.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              TextFormField(
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
                  model.signIn();
                  if (_formKey.currentState?.validate() != null &&
                      _formKey.currentState!.validate()) {}
                },
                child: Text(
                  "Entrar",
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
