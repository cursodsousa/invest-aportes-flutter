import 'package:InvestAportes/infra/aporte.service.dart';
import 'package:InvestAportes/model/aporte.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListaAportes extends StatefulWidget {

  @override
  _ListaAportesState createState() => _ListaAportesState();
}

class _ListaAportesState extends State<ListaAportes> {
  Future<List<Aporte>> _list;
  var _ano = 2020;
  final service = AporteService();

  @override
  void initState() {
    super.initState();
    _listarAportes();
  }

  _listarAportes(){
    _list = service.fetchAportesByUserIdAndAno(1, 2020);
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = GoogleFonts.quicksand(
      textStyle: TextStyle(color: Colors.white)
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('Meus Aportes', 
            style: textStyle,
          ),
          actions: [
            FlatButton(
              onPressed: (){},
              child: Text('$_ano', style:textStyle,),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).pushNamed('/aporte-form');
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.lightBlue,
        ),
        body: Container(
          child: FutureBuilder<List<Aporte>> (
            future: _list,
            builder: (context, lista){
              if(lista.hasData){
                var aportes = lista.data;
                return ListView.builder(
                  itemCount: aportes.length,
                  itemBuilder: (ctx, index){
                    Aporte a = aportes[index];
                    final tile = ListTile(
                      key: Key('${a.id}'),
                      leading: Icon(Icons.calendar_today),
                      title: Text(a.getMesString()),
                      subtitle: Text('Anterior: ${a.saldoAnterior}'),
                      trailing: Text(a.valor.toString()),
                    );
                    if(0 == index ){
                      return Dismissible(
                        key: Key('${a.id}'),
                        child: tile,
                        onDismissed: (direction) async {
                          await service.delete(a.id);
                          aportes.removeAt(index);
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Deletado com sucesso!'),));
                        },
                      );
                    }
                    return tile;
                  },
                );
              }else if(lista.hasError){
                return Text('${lista.error}');
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )
            
        ),
      );
  }
}

