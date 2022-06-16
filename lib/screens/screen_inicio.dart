import 'package:agenda_project/screens/screen_alarmas.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../clases/actividad.dart';
import '../clases/alarm.dart';
import '../clases/tarea.dart';

class ScreenMain extends StatefulWidget {
  List<Tarea> works;
  List <Alarm> alarmas;
  List<Actividad> activities;
  ScreenMain(this.works, this. alarmas, this.activities);

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  int _selectedIndex = 0;
  final keys = List<String>.generate(20, (i) => "Frase $i");
  DateTime _myDateTime = DateTime.now();
  List<Tarea> tareas = [];
  List <Alarm> alarms = [];
  bool isChecked = false;
  List<Actividad> actividades = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    tareas = widget.works;
    alarms = widget.alarmas;
    actividades = widget.activities;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(170, 218, 199, 1),
        buttonTheme: ButtonTheme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
              secondary: Color.fromRGBO(170, 218, 199, 1)
          ),
        ),
          scaffoldBackgroundColor: Colors.white
      ),
      home: Scaffold(
        drawer: Drawer(
          child: Container(
            color: Colors.white, //Color de fondo del drawer
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top:20, bottom: 0),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,//Toma el largo horizontal
                  //color: Colors.grey[100], //Color de fondo
                  child: Column(
                    children: const [
                      Text(
                        'Bienvenid@',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        'Estas son las frases que puedes utilizar para realizar acciones en la aplicación sin necesidad de escribir :)',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: keys.length,
                    itemBuilder: (context, index) => Card(
                      margin: const EdgeInsets.only(bottom: 2),
                      color: Colors.grey[100],
                      child: ListTile(
                        title: Text(keys[index]),
                        subtitle: const Text('Icream is good for health'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(170, 218, 199, 1),
        ),
        body: SingleChildScrollView(
          child: CustomPaint(
            painter: BluePainter(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
                Container(
                  margin: const EdgeInsets.only(top: 40, right: 30, left: 30),
                  decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(207, 207, 207, 1),
                          width: 3.0,
                        ),
                      )
                  ),
                  child: Column(
                    children: <Widget> [
                      Row(
                        children: [
                          Image.asset('assets/panda_rojo.png', height: 100,),
                          const Text(' Bienvenid@!', style: TextStyle(color: Color.fromRGBO(113, 113, 113, 1), fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Quicksand')),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Image.asset(getImageTime(_myDateTime.hour), height: 150, ),
                      Text(dayWeekend(_myDateTime.weekday), style: const TextStyle(color: Color.fromRGBO(113, 113, 113, 1), fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'DidactGothic')),
                      Text(DateFormat('dd-MM-yyyy').format(_myDateTime), style: const TextStyle(color: Color.fromRGBO(113, 113, 113, 1), fontSize: 20, fontFamily: 'DidactGothic')),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, right: 30, left: 30),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.4),
                          offset: Offset(0, 0.75),
                          blurRadius: 25
                      )
                    ],
                  ),
                  child: Column(
                    children: <Widget> [
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Color.fromRGBO(226, 221, 235, 1), width: 3.0,),
                            )
                        ),
                        child: ListTile(
                          title: const Text('Tareas a realizar',
                            style: TextStyle(color: Color.fromRGBO(255, 204, 163, 1), fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Quicksand',),
                          ),
                          trailing: Image.asset('assets/check.png', height: 30,),
                        ),
                      ),
                      /*ListTile(
                        leading: Checkbox(
                          activeColor: const Color.fromRGBO(169, 151, 196, 1),
                          value: tareas[0].terminada,
                          onChanged: (value) {
                            setState(() {
                              print(0);
                              isChecked = value!;
                              if(tareas[0].terminada){
                                tareas[0].terminada = false;
                              }else{
                                tareas[0].terminada = true;
                              }
                            });
                          },
                        ),
                        title: Text(tareas[0].descripcion, style: const TextStyle(fontFamily: 'DidactGothic')),
                      ),
                      ListTile(
                        leading: Checkbox(
                          activeColor: const Color.fromRGBO(169, 151, 196, 1),
                          value: tareas[1].terminada,
                          onChanged: (value) {
                            setState(() {
                              print(1);
                              isChecked = value!;
                              if(tareas[1].terminada){
                                tareas[1].terminada = false;
                              }else{
                                tareas[1].terminada = true;
                              }
                            });
                          },
                        ),
                        title: Text(tareas[1].descripcion, style: const TextStyle(fontFamily: 'DidactGothic')),
                      ),*/
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Color.fromRGBO(226, 221, 235, 1), width: 3.0,),
                            )
                        ),
                        child: const ListTile(
                          trailing: Text('Ver más',
                            style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Quicksand',),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25, right: 30, left: 30, bottom: 15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromRGBO(207, 207, 207, 1),
                        width: 3.0,
                      ),
                      top: BorderSide(
                        color: Color.fromRGBO(207, 207, 207, 1),
                        width: 3.0,
                      ),
                    )
                  ),
                  child: Column(
                    children: <Widget> [
                      Container(
                        margin: const EdgeInsets.only(top: 25),
                        child: ListTile(
                          leading: Image.asset('assets/manzana.png', height: 35,),
                          title: const Text('Actividades a realizar',
                            style: TextStyle(color: Color.fromRGBO(189, 221, 135, 1), fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Quicksand',),
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
                        elevation: 3,
                        color: const Color.fromRGBO(245, 214, 199, 1),
                        child: ListTile(
                          title: Text(actividades[0].descripcion, style: const TextStyle(color: Colors.black, fontFamily: 'DidactGothic'),),
                          trailing: Text('${actividades[0].hora_inicio}-${actividades[0].hora_final}',
                            style: const TextStyle(color: Color.fromRGBO(173, 66, 60, 1), fontFamily: 'Quicksand',),
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
                        elevation: 3,
                        color: const Color.fromRGBO(250, 246, 200, 1),
                        child: ListTile(
                          title: Text(actividades[1].descripcion, style: const TextStyle(color: Colors.black, fontFamily: 'DidactGothic'),),
                          trailing: Text('${actividades[1].hora_inicio}-${actividades[1].hora_final}',
                            style: const TextStyle(color: Color.fromRGBO(117, 110, 8, 1), fontFamily: 'Quicksand',),
                          ),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.white,
                        child: const ListTile(
                          trailing: Text('Ver más',
                            style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Quicksand',),
                          ),
                        ),
                        onPressed: (){
                        }
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 30, left: 30, bottom: 30),
                  child: Column(
                    children: <Widget> [
                      ListTile(
                        title: const Text('Alarmas programadas',
                          style: TextStyle(color: Color.fromRGBO(247, 186, 123, 1), fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Quicksand',),
                        ),
                        trailing: Image.asset('assets/calendario.png', height: 40,),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
                        elevation: 3,
                        color: const Color.fromRGBO(255, 237, 237, 1),
                        child: ListTile(
                          leading: Image.asset('assets/reloj.png', height: 35),
                          title: Text('${alarms[0].descripcion} ', style: const TextStyle(color: Color.fromRGBO(173, 66, 60, 1), fontFamily: 'DidactGothic'),),
                          subtitle: Text('${DateFormat('dd-MM-yyyy').format(alarms[0].fecha)} ${alarms[0].hora.hour}:${alarms[0].hora.minute}', style: const TextStyle(color: Color.fromRGBO(113, 113, 113, 1)),),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
                        elevation: 3,
                        color: const Color.fromRGBO(255, 240, 227, 1),
                        child: ListTile(
                          leading: Image.asset('assets/reloj.png', height: 35),
                          title: Text('${alarms[1].descripcion} ', style: const TextStyle(color: Color.fromRGBO(245, 164, 77, 1), fontFamily: 'DidactGothic'),),
                          subtitle: Text('${DateFormat('dd-MM-yyyy').format(alarms[1].fecha)} ${alarms[1].hora.hour}:${alarms[1].hora.minute}', style: const TextStyle(color: Color.fromRGBO(113, 113, 113, 1)),),
                        ),
                      ),
                      const ListTile(
                        trailing: Text('Ver más',
                          style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Quicksand',),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Stack(
          children: [
            Positioned(
              right: 15,
              top: 90,
              child: SizedBox(
                height: 50,
                width: 50,
                child: FloatingActionButton(
                  child: const Icon(Icons.mic, size: 30,color: Color.fromRGBO(67, 157, 187, 1),),
                  backgroundColor: const Color.fromRGBO(216, 237, 243, 1),
                  onPressed: (){
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String dayWeekend(int n){
    String aux = '';
    switch (n){
      case 1: aux = 'Lunes'; break;
      case 2: aux = 'Martes'; break;
      case 3: aux = 'Miércoles'; break;
      case 4: aux = 'Jueves'; break;
      case 5: aux = 'Viernes'; break;
      case 6: aux = 'Sábado'; break;
      case 7: aux = 'Domingo'; break;
    }
    return aux;
  }

  String getImageTime(int hrs){
    String aux = '';
    if(hrs>=6 && hrs<11){
      aux = 'assets/mañana.png';
    } else if (hrs>=12 && hrs<19){
      aux = 'assets/tarde.png';
    } else {
      aux = 'assets/noche.png';
    }
    return aux;
  }

}

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;

    Paint circleGrey = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color.fromRGBO(250, 232, 218, 1)
      ..strokeWidth = 2;

    Paint circlePink = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color.fromRGBO(245, 214, 199, 1)
      ..strokeWidth = 2;

    canvas.drawCircle(Offset(width*0.08, height*0.08), 100, circleGrey);
    canvas.drawCircle(Offset(width*0.9, height*0.3), 100, circlePink);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}