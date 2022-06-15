import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import '../clases/alarm.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:highlight_text/highlight_text.dart';

class ScreenAlarm extends StatefulWidget {
  List <Alarm> alarmas;
  ScreenAlarm(this.alarmas);

  @override
  State<ScreenAlarm> createState() => _ScreenAlarmState();
}

class _ScreenAlarmState extends State<ScreenAlarm> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  List<int> indexEjecutados = [];
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
  void initState(){
    super.initState();
    _speech = stt.SpeechToText();
    var initializationSettingsAndroid = new AndroidInitializationSettings('panda');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin =  new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
    });
  }
  Future _showNotificationWithDefaultSound(String title) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high,
      icon: 'panda');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      'Ya es hora de completar tu actividad 🥳',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }
  @override
  Widget build(BuildContext context) {
    alarms = widget.alarmas;
    Timer miTimer = Timer.periodic(Duration(seconds: 10),(timer){
      //El codigo se ejecuta cada 30 seg
      for(int i=0;i<alarms.length;i++){
        print('hola $i');
        print(TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute).toString());
        print(DateTime.now().toString());
        if(alarms[i].hora == TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute) && alarms[i].fecha.day == DateTime.now().day && alarms[i].fecha.month == DateTime.now().month && alarms[i].fecha.year == DateTime.now().year){
          if(!indexEjecutados.contains(i)){
            indexEjecutados.add(i);
            print('es hora');
            _showNotificationWithDefaultSound(alarms[i].descripcion);
          }
        }
      }
    });
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
                        fontFamily: 'Quicksand',
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
                        title: Text('${alarms[index].descripcion} ', style: TextStyle(color: colorLetter[_colorSelected], fontFamily: 'DidactGothic'),),
                        subtitle: Text('${DateFormat('dd-MM-yyyy').format(alarms[index].fecha)} ${alarms[index].hora.hour}:${alarms[index].hora.minute}', style: const TextStyle(color: Color.fromRGBO(113, 113, 113, 1)),),
                        trailing: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: IconButton(
                            onPressed: (){
                              setState(() {
                                alarms.removeWhere((element) => (element == alarms[index]));
                                indexEjecutados.remove(index);
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
                  child: const Icon(Icons.mic, size: 30,color: Color.fromRGBO(255, 148, 66, 1),),
                  backgroundColor: const Color.fromRGBO(255, 204, 163, 1),
                  onPressed: _listen,
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
                    modalAlarma();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Presiona el botón y empieza a hablar';
  double _confidence = 1.0;
  bool _isReading = false;
  FlutterTts flutertts = FlutterTts();
  bool eliminar = false;
  void _read (String text) async{
    if (!_isReading) {
      setState(() => _isReading = true);
      await flutertts.setLanguage('es-ES');
      await flutertts.setPitch(1);
      await flutertts.speak(text);
    } else {
      setState(() => _isReading = false);
    }
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            print(_text);
            if(_text.contains('añadir alarma') || _text.contains('Añadir alarma')){
              modalAlarma();
            } else if(_text.contains('Eliminar alarma')|| _text.contains('eliminar alarma')){
              _read('Ok!, dime el título de la alarma que quieres eliminar');
              eliminar = true;
            }else if(eliminar && _text.isNotEmpty){
              print('entro');
              for(int i=0;i<alarms.length;i++){
                if(alarms[i].descripcion.toUpperCase()==_text.toUpperCase()){
                  setState((){
                    alarms.removeAt(i);
                    print('Eliminado');
                    _read('Ok! se eliminó la alarma');
                  });
                }
              }
              eliminar = false;
            }
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  modalAlarma(){
    return showDialog(
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
                                  hour.text = '';
                                  date.text = '';
                                  name.text = '';
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
  }
}

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;

    Paint circleGrey = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color.fromRGBO(226, 221, 235, 1)
      ..strokeWidth = 2;

    Paint circlePink = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color.fromRGBO(245, 214, 199, 1)
      ..strokeWidth = 2;

    canvas.drawCircle(Offset(width*0.05, height*0.23), 100, circleGrey);
    canvas.drawCircle(Offset(width*0.9, height*0.7), 100, circlePink);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
