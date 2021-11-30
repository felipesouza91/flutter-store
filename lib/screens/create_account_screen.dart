import 'package:flutter/material.dart';

class CreateAccountScreem extends StatelessWidget {
  CreateAccountScreem({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: "Nome Completo"),
              validator: (name) {
                if (name!.isEmpty) {
                  return "Nome é obrigatorio!";
                }
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: TextFormField(
                decoration: InputDecoration(hintText: "email"),
                keyboardType: TextInputType.emailAddress,
                validator: (email) {
                  if (email!.isEmpty || !email.contains("@")) {
                    return "E-mail invalido!";
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(hintText: "Senha"),
                validator: (password) {
                  if (password!.isEmpty || password.length < 6) {
                    return "Senha invalida";
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(hintText: "Endereço"),
                validator: (address) {
                  if (address!.isEmpty || address.length < 6) {
                    return "Senha invalida";
                  }
                },
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
                if (_formKey.currentState?.validate() != null &&
                    _formKey.currentState!.validate()) {}
              },
              child: Text(
                "Cadastrar",
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
