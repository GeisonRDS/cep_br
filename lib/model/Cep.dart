class Cep{
  String _cep;
  String _logradouro;
  String _complemento;
  String _bairro;
  String _localidade;
  String _uf;
  String _unidade;
  String _ibge;
  String _gia;

  Cep(this._cep, this._logradouro, this._complemento, this._bairro,
      this._localidade, this._uf, this._unidade, this._ibge, this._gia);

  String get gia => _gia;

  set gia(String value) {
    _gia = value;
  }

  String get ibge => _ibge;

  set ibge(String value) {
    _ibge = value;
  }

  String get unidade => _unidade;

  set unidade(String value) {
    _unidade = value;
  }

  String get uf => _uf;

  set uf(String value) {
    _uf = value;
  }

  String get localidade => _localidade;

  set localidade(String value) {
    _localidade = value;
  }

  String get bairro => _bairro;

  set bairro(String value) {
    _bairro = value;
  }

  String get complemento => _complemento;

  set complemento(String value) {
    _complemento = value;
  }

  String get logradouro => _logradouro;

  set logradouro(String value) {
    _logradouro = value;
  }

  String get cep => _cep;

  set cep(String value) {
    _cep = value;
  }


}