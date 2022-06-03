import 'package:agenda_project/screens/screen_actividades.dart';
import 'package:agenda_project/screens/screen_alarmas.dart';
import 'package:agenda_project/screens/screen_inicio.dart';
import 'package:agenda_project/screens/screen_tareas.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyAppStf(),
    );
  }
}

class MyAppStf extends StatefulWidget {
  const MyAppStf({Key? key}) : super(key: key);

  @override
  State<MyAppStf> createState() => _MyAppStfState();
}

class _MyAppStfState extends State<MyAppStf> {
  late List<Widget> _pages;
  late Widget _page0;
  late Widget _page1;
  late Widget _page2;
  late Widget _page3;
  late int _currentIndex;
  late Widget _currentPage;

  @override
  void initState() {
    super.initState();
    _page0 = const ScreenMain();
    _page1 = const ScreenWork();
    _page2 = const ScreenActividades();
    _page3 = const ScreenAlarm();
    _pages = [_page0, _page1, _page2, _page3];
    _currentIndex = 0;
    _currentPage = _page0;
  }

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
      _currentPage = _pages[index];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.4),
              blurRadius: 25,
              offset: Offset(0.0, 0.75)
            )
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Inicio'),
            BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/tareas.png')), label: 'Tareas'),
            BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/horario.png')), label: 'Horario'),
            BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/alarma.png')), label: 'Alarma'),
            ],
            currentIndex: _currentIndex,
            selectedItemColor: const Color.fromRGBO(33, 150, 243, 100),
            unselectedItemColor: const Color.fromRGBO(169, 151, 196, 100),
            unselectedFontSize: 17,
            selectedFontSize: 17,
            iconSize: 30,
            onTap: (index) => setState(() => _currentIndex = index),
          ),
        )
    );
  }
}

