import 'package:flutter/material.dart';
import 'package:cep/telas/TelaResultado.dart';

class TelaPesquisaPorCep extends StatefulWidget {
  @override
  _TelaPesquisaPorCepState createState() => _TelaPesquisaPorCepState();
}

class _TelaPesquisaPorCepState extends State<TelaPesquisaPorCep> {

  TextEditingController _controllerCep = TextEditingController();

  void _recuperarCep(){

    var enderecoDigitado = "${_controllerCep.text}";

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TelaResultado(pesquisaDigitada: enderecoDigitado)
        )
    );
    _limparCampo();
  }

  void _limparCampo(){
    _controllerCep.text = "";
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: TextField(
                keyboardType: TextInputType.number,
                maxLength: 8,
                decoration: InputDecoration(
                    labelText: "Digite o CEP, ex: 95630000",
                    labelStyle: TextStyle(
                      fontSize: 20,
                    )
                ),
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue
                ),
                controller: _controllerCep,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                  onPressed: _recuperarCep
              ),
            ),
          ],
        ),
      ),
    );
  }
}

