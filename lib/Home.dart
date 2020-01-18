import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cep/telas/TelaPesquisaPorCep.dart';
import 'package:cep/telas/TelaPesquisaPorEndereco.dart';
import 'package:cep/telas/TelaSobre.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _indiceAtual = 0;

  void _abrirSobreNos(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=> TelaSobre())
    );
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> telas = [
      TelaPesquisaPorCep(),
      TelaPesquisaPoEndereco(),
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.grey
        ),
        backgroundColor: Colors.white,
        title: Text(
          "CEPbr",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.blue
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Colors.blue,
            ),

            onPressed: (){
              _abrirSobreNos();
            },
          ),
        ],
        elevation: 0.0,
      ),
      body: Container(
        child: telas[_indiceAtual],
        color: Colors.white,
      ),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _indiceAtual,
          onTap: (indice){
            setState(() {
              _indiceAtual = indice;
            });
          },
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.blue,
          unselectedItemColor: Colors.black12,
          items: [
            BottomNavigationBarItem(
                title: Padding(
                  padding:
                  EdgeInsets.only(bottom: 10),
                  child: Text("Pesquisa por CEP"),
                ),
                icon: Padding(
                  padding:
                  EdgeInsets.only(top: 10),
                  child: Icon(
                    Icons.looks_one,
                    size: 30,
                  ),
                ),
            ),
            BottomNavigationBarItem(
              title: Padding(
                padding:
                EdgeInsets.only(bottom: 10),
                child: Text("Pesquisa por endereço"),
              ),
              icon: Padding(
                padding:
                EdgeInsets.only(top: 10),
                child: Icon(
                  Icons.font_download,
                  size: 26,
                ),
              ),
            ),
          ],
          elevation: 0.0,
        ),
      )
    );
  }
}
