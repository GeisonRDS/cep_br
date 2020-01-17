import 'package:flutter/material.dart';
import 'package:cep/telas/TelaResultado.dart';

class TelaPesquisaPoEndereco extends StatefulWidget {
  @override
  _TelaPesquisaPoEnderecoState createState() => _TelaPesquisaPoEnderecoState();
}

class _TelaPesquisaPoEnderecoState extends State<TelaPesquisaPoEndereco> {

  TextEditingController _controllerUf = TextEditingController();
  TextEditingController _controllerLocalidade = TextEditingController();
  TextEditingController _controllerLogradouro = TextEditingController();


  void _getEnderecoDigitado(){

    var enderecoDigitado = "${_controllerUf.text}/${_controllerLocalidade.text}/${_controllerLogradouro.text}";

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TelaResultado(pesquisaDigitada: enderecoDigitado)
        )
    );
    _limparCampos();
  }

  _limparCampos(){
    _controllerUf.text = "";
    _controllerLocalidade.text = "";
    _controllerLogradouro.text = "";
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: TextFormField(
                  validator: (value){
                    int f = 1;
                    for (var i = 0; i < 2; i++) {
                      if(value.substring(i,f) == " "){
                        return "Campo obrigatório, mínimo 3 caracteres de A-Z";
                      }
                      f++;
                    }
                    if(value.isEmpty || value.length < 2){
                      return "Campo obrigatório, mínimo 2 caracteres de A-Z";
                    }
                  },
                  keyboardType: TextInputType.text,
                  maxLength: 2,
                  decoration: InputDecoration(
                      labelText: "Digite o UF, ex: RS",
                      labelStyle: TextStyle(
                        fontSize: 20,
                      )
                  ),
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.blue
                  ),
                  controller: _controllerUf,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: TextFormField(
                  validator: (value){
                    int f = 1;
                    for (var i = 0; i < 3; i++) {
                      if(value.substring(i,f) == " "){
                        return "Campo obrigatório, mínimo 3 caracteres de A-Z";
                      }
                      f++;
                    }
                    if(value.isEmpty || value.length < 2 /*|| espacoEmBrando == true*/){
                      return "Campo obrigatório, mínimo 3 caracteres de A-Z";
                    }
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Digite o Cidade, ex: Porto Alegre",
                      labelStyle: TextStyle(
                        fontSize: 20,
                      )
                  ),
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.blue
                  ),
                  controller: _controllerLocalidade,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: TextFormField(
                  validator: (value){
                    int f = 1;
                    for (var i = 0; i < 3; i++) {
                      if(value.substring(i,f) == " "){
                        return "Campo obrigatório, mínimo 3 caracteres de A-Z";
                      }
                      f++;
                    }
                    if(value.isEmpty || value.length < 2){
                      return "Campo obrigatório, mínimo 3 caracteres de A-Z";
                    }
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Digite o logradouro, ex: Domingos José",
                      labelStyle: TextStyle(
                        fontSize: 20,
                      )
                  ),
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.blue
                  ),
                  controller: _controllerLogradouro,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Consultar",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    onPressed: (){
                      if (_formKey.currentState.validate()) {
                        _getEnderecoDigitado();
                      }
                    }
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}