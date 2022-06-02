import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../clases/alarm.dart';

class ScreenAlarm extends StatefulWidget {
  const ScreenAlarm({Key? key}) : super(key: key);

  @override
  State<ScreenAlarm> createState() => _ScreenAlarmState();
}

class _ScreenAlarmState extends State<ScreenAlarm> {
  int _selectedIndex = 0;
  int _colorSelected = -1;
  List <Alarm> alarms = [];
  List <Color> colorBack = [const Color.fromRGBO(255, 237, 237, 1), const Color.fromRGBO(255, 240, 227, 1), const Color.fromRGBO(252, 249, 221, 1), const Color.fromRGBO(241, 250, 240, 1), const Color.fromRGBO(230, 247, 250, 1), const Color.fromRGBO(240, 237, 247, 1)];
  List <Color> colorLetter = [const Color.fromRGBO(173, 66, 60, 1), const Color.fromRGBO(245, 164, 77, 1), const Color.fromRGBO(179, 168, 16, 1), const Color.fromRGBO(143, 174, 45, 1), const Color.fromRGBO(67, 157, 187, 1), const Color.fromRGBO(113, 86, 150, 1)];
  final keys = List<String>.generate(20, (i) => "Frase $i");
  TextEditingController date = TextEditingController();
  TextEditingController hour = TextEditingController();
  TextEditingController name = TextEditingController();
  DateTime _myDateTime = DateTime.now();
  TimeOfDay _myHourTime = TimeOfDay.now();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int getColor(){
    if(_colorSelected == 5){
      _colorSelected = 0;
    } else {
      _colorSelected++;
    }
    return _colorSelected;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda',
      theme: ThemeData(primaryColor: Colors.deepOrangeAccent),
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
                      SizedBox(   //Espacio entre textos
                        height: 10,
                      ),
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
          backgroundColor: const Color.fromRGBO(255, 204, 163, 1),
        ),
        body: CustomPaint(
          painter: BluePainter(),
          child: Container(
            margin: const EdgeInsets.only(top: 25, right: 35, left: 35, bottom: 25),
            height: double.infinity,
            width: double.infinity,
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
              children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(226, 221, 235, 1),
                          width: 3.0,
                        ),
                      )
                  ),
                  child: ListTile(
                    leading: Image.asset('assets/cactus.png', height: 44),
                    title: const Text(
                      'Todas las alarmas',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 204, 163, 1),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: alarms.length,
                    itemBuilder: (context, index) => Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
                      elevation: 3,
                      color: colorBack[getColor()],
                      child: ListTile(
                        leading: Image.asset('assets/reloj.png', height: 35),
                        title: Text('${alarms[index].descripcion} ', style: TextStyle(color: colorLetter[_colorSelected]),),
                        subtitle: Text('${DateFormat('dd-MM-yyyy').format(alarms[index].fecha)} ${alarms[index].hora.hour}:${alarms[index].hora.minute}', style: const TextStyle(color: Color.fromRGBO(113, 113, 113, 1)),),
                        trailing: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: IconButton(
                            onPressed: (){
                              setState(() {
                                alarms.removeWhere((element) => (element == alarms[index]));
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Color.fromRGBO(173, 66, 60, 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
            currentIndex: _selectedIndex,
            selectedItemColor: const Color.fromRGBO(33, 150, 243, 100),
            unselectedItemColor: const Color.fromRGBO(169, 151, 196, 100),
            unselectedFontSize: 17,
            selectedFontSize: 17,
            iconSize: 30,
            onTap: _onItemTapped,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Stack(
          children: [
            Positioned(
              right: 15,
              top: 170,
              child: SizedBox(
                height: 50,
                width: 50,
                child: FloatingActionButton(
                  child: const Icon(Icons.mic, size: 30,color: Color.fromRGBO(255, 148, 66, 1),),
                  backgroundColor: const Color.fromRGBO(255, 204, 163, 1),
                  onPressed: (){
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              right: 40,
              child: SizedBox(
                height: 40,
                width: 40,
                child: FloatingActionButton(
                  child: const Icon(Icons.add, size: 30, color: Color.fromRGBO(255, 148, 66, 1),),
                  backgroundColor: const Color.fromRGBO(255, 204, 163, 1),
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Programa tu alarma'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                const Text('Fecha: ', style: TextStyle(color: Colors.grey),),
                                Expanded(
                                    child: TextFormField(
                                      controller: date,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                        hintText: 'Ingresa una fecha',
                                        border: UnderlineInputBorder(),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.orangeAccent),
                                        ),
                                      ),
                                    )
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.orangeAccent,
                                  radius: 20,
                                  child: IconButton(
                                    onPressed: () async {
                                      _myDateTime = (await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2010),
                                          lastDate: DateTime(2030)
                                      ))!;
                                      setState(() {
                                        date.text = DateFormat('dd-MM-yyyy').format(_myDateTime);
                                      });
                                    },
                                    icon: const Icon(Icons.calendar_today_outlined, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Hora: ', style: TextStyle(color: Colors.grey),),
                                Expanded(
                                    child: TextFormField(
                                      controller: hour,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                        hintText: 'Ingresa una hora',
                                        border: UnderlineInputBorder(),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.orangeAccent),
                                        ),
                                      ),
                                    )
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.orangeAccent,
                                  radius: 20,
                                  child: IconButton(
                                    onPressed: () async {
                                      _myHourTime = (await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now()
                                      ))!;
                                      setState(() {
                                        hour.text = '${_myHourTime.hour}:${_myHourTime.minute}';
                                      });
                                    },
                                    icon: const Icon(Icons.access_alarm, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        actions: [
                          FlatButton(
                              onPressed: (){
                                setState(() {
                                  Navigator.of(context).pop();
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Programa tu alarma'),
                                        content: TextField(
                                          controller: name,
                                          decoration: InputDecoration(
                                            hintText: 'Ingresar el nombre de la alarma',
                                            filled: true,
                                            fillColor: Colors.grey.shade50,
                                          ),
                                        ),
                                        actions: [
                                          FlatButton(
                                              onPressed: (){
                                                setState(() {
                                                  Alarm aux = Alarm(_myDateTime, _myHourTime, name.text.toString());
                                                  alarms.add(aux);
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                              child: const Text('Ok')
                                          )
                                        ],
                                      )
                                  );
                                });
                              },
                              child: const Text('Ok')
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;

    Paint circleGrey = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color.fromRGBO(226, 221, 235, 100)
      ..strokeWidth = 2;

    Paint circlePink = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color.fromRGBO(245, 214, 199, 100)
      ..strokeWidth = 2;

    canvas.drawCircle(Offset(width*0.05, height*0.23), 100, circleGrey);
    canvas.drawCircle(Offset(width*0.9, height*0.7), 100, circlePink);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
