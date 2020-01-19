import 'package:flutter/material.dart';
import 'package:cep/model/Cep.dart';
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

  Future<Cep> _recuperarEnderecos() async {

    String url = _urlBase+widget.pesquisaDigitada+"/json/";

    http.Response response = await http.get( url );
    var dadosJson = json.decode( response.body );

    var cep = dadosJson;
    if(dadosJson.toString() == "{erro: true}"){
      Cep c = Cep(cep["cep"]="", cep["logradouro"]="", cep["complemento"]="", cep["bairro"]="", cep["localidade"]="", cep["uf"]="", cep["unidade"]="", cep["ibge"]="", cep["gia"]="");
      return c;
    }else{
      Cep c = Cep(cep["cep"], cep["logradouro"], cep["complemento"], cep["bairro"], cep["localidade"], cep["uf"], cep["unidade"], cep["ibge"], cep["gia"]);
      return c;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.blue
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left:20, right: 20),
          child: Center(
            child: FutureBuilder<Cep>(
              future: _recuperarEnderecos(),
              builder: (context, snapshot){
                switch( snapshot.connectionState ){
                  case ConnectionState.none :
                  case ConnectionState.waiting :
                    return Container(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  case ConnectionState.active :
                  case ConnectionState.done :
                    if( snapshot.hasError || snapshot.data.cep.isEmpty){
                      return Center(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                                  child: Text("Não foram encontrados registros com os dados informados.",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue
                                    ),
                                  ),
                                )
                              );
                    }else {
                      Cep cep = snapshot.data;
                      return Text("\n${cep.cep == ""?"":"CEP: "+cep.cep+"\n"}"
                            "${cep.logradouro == ""?"":"Logradouro: "+cep.logradouro+"\n"}"
                            "${cep.complemento == ""?"":"Complemento: "+cep.complemento+"\n"}"
                            "${cep.bairro == ""?"":"Bairro: "+cep.bairro+"\n"}"
                            "${cep.localidade == ""?"":"Cidade: "+cep.localidade+"\n"}"
                            "${cep.uf == ""?"":"UF: "+cep.uf+"\n"}"
                            "${cep.unidade == ""?"":"Unidade: "+cep.unidade+"\n"}"
                            "${cep.ibge == ""?"":"IBGE: "+cep.ibge+"\n"}"
                            "${cep.gia == ""?"":"GIA: "+cep.gia}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue
                          ),
                        );
                      }
                    break;
                  }
                }
            ),
          ),
        ),
      )
    );
  }
}