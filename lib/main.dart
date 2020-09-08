import 'package:InvestAportes/views/aporte.form.dart';
import 'package:InvestAportes/views/aporte.list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meus Aportes',
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        brightness: Brightness.light
      ) ,
      routes: {
        '/' : (context) => ListaAportes(),
        '/aporte-form' : (context) => AporteForm(),
      },
      initialRoute: '/',
    );
  }
}

Route _createTransition(Widget widget){
  return PageRouteBuilder(
    pageBuilder: (context, animation, secAnimation) => widget,
    transitionsBuilder: (context, animation, secAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
