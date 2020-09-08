class Aporte {
  int id;
  double saldoAnterior;
  double valor;
  int mes;
  int ano;

  Aporte({this.id, this.saldoAnterior, this.valor, this.mes, this.ano});

  getMesString(){
    switch (mes){
      case 1: return 'Janeiro';
      case 2: return 'Fevereiro';
      case 3: return 'Março';
      case 4: return 'Abril';
      case 5: return 'Maio';
      case 6: return 'Junho';
      case 7: return 'Julho';
      case 8: return 'Agosto';
      case 9: return 'Setembro';
      case 10: return 'Outubro';
      case 11: return 'Novembro';
      case 12: return 'Dezembro';
    }
    return 'null';
  }

  List<Aporte> fromListJson(){
    
  }

  Aporte.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    saldoAnterior = json['saldoAnterior'];
    valor = json['valor'];
    mes = json['mes'];
    ano = json['ano'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['saldoAnterior'] = this.saldoAnterior;
    data['valor'] = this.valor;
    data['mes'] = this.mes;
    data['ano'] = this.ano;
    return data;
  }
}