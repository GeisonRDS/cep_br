import 'package:cep/model/Cep.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class TelaResultado extends StatefulWidget {

  String pesquisaDigitada;

  TelaResultado({this.pesquisaDigitada});

  @override
  _TelaResultadoState createState() => _TelaResultadoState();
}

class _TelaResultadoState extends State<TelaResultado> {

  String _urlBase = "https://viacep.com.br/ws/";

  String _mensagemResultado = "";

  Future<List<Cep>> _recuperarEnderecos() async {

    String urlPesquisa = widget.pesquisaDigitada+"/json/";

    String url = _urlBase+urlPesquisa;

    http.Response response = await http.get( url );
    var dadosJson = json.decode( response.body );

    List<Cep> enderecos = List();
    for( var cep in dadosJson ){
      Cep c = Cep(cep["cep"], cep["logradouro"], cep["complemento"], cep["bairro"], cep["localidade"], cep["uf"], cep["unidade"], cep["ibge"], cep["gia"]);
      enderecos.add( c );
    }
    return enderecos;
  }

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

    if(widget.pesquisaDigitada.length == 8){
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
    }else if(widget.pesquisaDigitada.length > 8){
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
                child: FutureBuilder<List<Cep>>(
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
                        if( snapshot.hasError || snapshot.data.isEmpty){
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
                          return  ListView.separated(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index){
                              List<Cep> lista = snapshot.data;
                              Cep cep = lista[index];
                              return ListTile(
                                title: Text("\n${cep.cep == ""?"":"CEP: "+cep.cep+"\n"}"
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
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Divider(
                              height: 4,
                              color: Colors.blue,
                            ),
                          );
                        }
                      break;
                    }
                  },
                ),
              ),
            ),
          )
      );
    }
  }
}
