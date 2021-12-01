import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:store/models/user_model.dart';
import 'package:store/screens/home.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameControlle = TextEditingController();
  final _emailControlle = TextEditingController();
  final _passwordControlle = TextEditingController();
  final _addressControlle = TextEditingController();

  void _onSuccess() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content:
            Text("Usuario cadastrado com suscesso! Redirecionando para Home"),
      ),
    );
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
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
        title: Text("Criar Conta"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
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
                controller: _nameControlle,
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
                  controller: _emailControlle,
                  decoration: InputDecoration(hintText: "E-mail"),
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
                  controller: _passwordControlle,
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
                  controller: _addressControlle,
                  decoration: InputDecoration(hintText: "Endereço"),
                  validator: (address) {
                    if (address!.isEmpty) {
                      return "Endereço obrigatorio";
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
                  if (_formKey.currentState!.validate()) {
                    Map<String, dynamic> userData = {
                      "name": _nameControlle.text,
                      "email": _emailControlle.text,
                      "address": _addressControlle.text
                    };

                    model.signUp(
                        userData: userData,
                        pass: _passwordControlle.text,
                        onSuccess: _onSuccess,
                        onFail: _onFail);
                  }
                },
                child: Text(
                  "Cadastrar",
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
