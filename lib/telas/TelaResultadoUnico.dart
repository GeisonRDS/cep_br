import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TelaResultadoUnico extends StatefulWidget {

  String pesquisaDigitada;

  TelaResultadoUnico({this.pesquisaDigitada});

  @override
  _TelaResultadoUnicoState createState() => _TelaResultadoUnicoState();
}

class _TelaResultadoUnicoState extends State<TelaResultadoUnico> {

  String _urlBase = "https://viacep.com.br/ws/";

  String _mensagemResultado = "";

  void _recuperarCep() async {

    String url = "https://viacep.com.br/ws/${widget.pesquisaDigitada}/json/";

    print(url);

    http.Response response;
    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String cepDigitado = retorno["cep"]         == "" ? "" : "CEP: ${retorno["cep"]}\n";
    String logradouro  = retorno["logradouro"]  == "" ? "" : "Logradouro: ${retorno["logradouro"]}\n";
    String complemento = retorno["complemento"] == "" ? "" : "Complemento: ${retorno["complemento"]}\n";
    String bairro      = retorno["bairro"]      == "" ? "" : "Bairro: ${retorno["bairro"]}\n";
    String localidade  = retorno["localidade"]  == "" ? "" : "Cidade: ${retorno["localidade"]}\n";
    String uf          = retorno["uf"]          == "" ? "" : "UF: ${retorno["uf"]}\n";
    String unidade     = retorno["unidade"]     == "" ? "" : "Unidade: ${retorno["unidade"]}\n";
    String ibge        = retorno["ibge"]        == "" ? "" : "IBGE: ${retorno["ibge"]}\n";
    String gia         = retorno["gia"]         == "" ? "" : "GIA: ${retorno["gia"]}";

    setState(() {
      _mensagemResultado = "${cepDigitado}"
          + "${logradouro}"
          + "${complemento}"
          + "${bairro}"
          + "${localidade}"
          + "${uf}"
          + "${unidade}"
          + "${ibge}"
          + "${gia}";
    });
  }

  @override
  Widget build(BuildContext context) {

    _recuperarCep();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.blue
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Center(
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 60),
              child: Container(
                padding: EdgeInsets.only(
                    left: 50, top: 30, right: 50, bottom: 30),
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.blue),
                        bottom: BorderSide(color: Colors.blue))
                ),
                child: Text(_mensagemResultado,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue
                    )
                ),
              )
          )
      ),
    );
  }
}
