import 'package:agenda_project/clases/actividad.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../clases/tarea.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:highlight_text/highlight_text.dart';

class ScreenActividades extends StatefulWidget {
  List<Actividad> activities;
  ScreenActividades(this.activities);

  @override
  State<ScreenActividades> createState() => _ScreenActividadesState();
}

class _ScreenActividadesState extends State<ScreenActividades> {
  List<Color> colores = [Color.fromRGBO(245, 214, 199, 1),Color.fromRGBO(250, 246, 200, 1),Color.fromRGBO(211, 240, 210, 1),Color.fromRGBO(238, 235, 245, 1)];
  List<Color> coloresText = [Color.fromRGBO(173, 66, 60, 1),Color.fromRGBO(117, 110, 8, 1),Color.fromRGBO(63, 157, 47, 1),Color.fromRGBO(113, 86, 150, 1)];
  late DateTime _myDateTime;
  late TimeOfDay _myTime;
  int _selectedIndex = 0;
  bool isChecked = false;
  //final tareas = List<String>.generate(100, (i) => "Tarea $i");
  List<Actividad> actividades = [];
  final frases = List<String>.generate(20, (i) => "Frase $i");
  TextEditingController miVar = TextEditingController();
  TextEditingController valorHoraInicio = TextEditingController();
  TextEditingController valorHoraFinal = TextEditingController();
  TextEditingController valorFechaInicio = TextEditingController();
  TextEditingController valorFechaFinal = TextEditingController();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void insertActividad(Actividad actividad){
    actividades.add(actividad);
    print('se agregó la actividad');
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    actividades = widget.activities;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda',
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
                    itemCount: frases.length,
                    itemBuilder: (context, index) => Card(
                      margin: const EdgeInsets.only(bottom: 2),
                      color: Colors.grey[100],
                      child: ListTile(
                        title: Text('${frases[index]}'),
                        subtitle: Text('Icream is good for health'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(233, 240, 215, 1),
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
                          color: Color.fromRGBO(226, 221, 235, 100),
                          width: 3.0,
                        ),
                      )
                  ),
                  child: ListTile(
                    leading: Image.asset('assets/arco_iris.png', height: 35),
                    title: const Text(
                      'Todas las actividades',
                      style: TextStyle(
                        color: Color.fromRGBO(189, 211, 135, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand'
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: actividades.length,
                    itemBuilder: (context, index) => Card(
                      color: colores[index%4],
                      margin: const EdgeInsets.only(top:9,right: 10, left: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        
                        title: Text('${actividades[index].descripcion}', style: TextStyle(fontFamily: 'DidactGothic', color: Color.fromRGBO(56, 56, 56, 1)),),
                        //subtitle: Text('Icream is good for health'),
                        trailing: 
                        Row(
                          mainAxisSize: MainAxisSize.min,

                          children: [
                            Text('${actividades[index].hora_inicio} - ${actividades[index].hora_final}',style: TextStyle(color: coloresText[index%4], fontFamily: 'DidactGothic')),
                            SizedBox(width: 10)
                            ,CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 15,
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                    print(index);
                                    actividades.removeAt(index);
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                  size: 15,
                                ),
                              ),
                            ),
                          ],),
                        
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
              child: Container(
                height: 50,
                width: 50,
                child: FloatingActionButton(
                  child: const Icon(Icons.mic, size: 30, color: Color.fromRGBO(189, 211, 135, 1),),
                  backgroundColor: Color.fromRGBO(233, 240, 215, 1),
                  onPressed: _listen,
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              right: 40,
              child: Container(
                height: 40,
                width: 40,
                child: FloatingActionButton(
                  child: const Icon(Icons.add, size: 30, color: Color.fromRGBO(189, 211, 135, 1),),
                  backgroundColor: Color.fromRGBO(233, 240, 215, 1),
                  onPressed: (){
                    modalAddTarea(context);
                  },
                ),
              ),
            ),
            // Add more floating buttons if you want
            // There is no limit
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
            if(_text.contains('añadir actividad') || _text.contains('Añadir actividad')){
              modalAddTarea(context);
            } else if(_text.contains('Eliminar actividad')|| _text.contains('eliminar actividad')){
              _read('Ok!, dime el título de la actividad que quieres eliminar');
              eliminar = true;
            }else if(eliminar && _text.isNotEmpty){
              print('entro');
              for(int i=0;i<actividades.length;i++){
                if(actividades[i].descripcion.toUpperCase()==_text.toUpperCase()){
                  setState((){
                    actividades.removeAt(i);
                    print('Eliminado');
                    _read('Ok! se eliminó la actividad');
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

  modalAddTarea(BuildContext context){
    Widget okButton = TextButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(189, 211, 135, 1))),
        onPressed: (){
          setState(() {
            Navigator.of(context).pop();
            print(miVar.text);
            var actividad = Actividad(
                cod_actividad: 0,
                descripcion: miVar.text,
                fecha_inicio: valorFechaInicio.text,
                fecha_final: valorFechaFinal.text,
                hora_inicio: valorHoraInicio.text,
                hora_final: valorHoraFinal.text,
            );
            insertActividad(actividad);
            miVar.text='';
            valorHoraInicio.text = '';
            valorHoraFinal.text = '';
            valorFechaFinal.text = '';
            valorFechaInicio.text = '';

          });
        },child: const Text('OK', style: TextStyle(fontSize: 15, color: Colors.white),)
    );
    Widget cancelButton = TextButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(255, 191, 176, 1))),
        onPressed: (){
          setState(() {
            Navigator.of(context).pop();
            miVar.text='';
            valorHoraInicio.text = '';
            valorHoraFinal.text = '';
            valorFechaFinal.text = '';
            valorFechaInicio.text = '';
          });
        },child: const Text('Cancelar', style: TextStyle(fontSize: 15, color: Colors.white),)
    );



    AlertDialog alert = AlertDialog(
      title: const Text('Ingresar nueva actividad', style: TextStyle(color: Color.fromRGBO(56, 56, 56, 1))),
      content:
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: <Widget>[
              const Text('Asunto:', style: TextStyle(fontSize: 14),),
              SizedBox(width: 4,),
              Expanded(
                child: TextField(
                  style:TextStyle(fontSize: 14),
                  controller: miVar,
                  decoration: const InputDecoration(
                    hintText: 'Ingresa un asunto',
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.all(6),
                  ) ,
                ),
              ),
            ],
          ),
          SizedBox(height: 6,),
          Row(
            children: <Widget>[
              const Text('Fecha inicio:',style: TextStyle(fontSize: 14)),
              SizedBox(width: 4,),
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 14),
                  controller: valorFechaInicio,
                  keyboardType: TextInputType.none,
                  decoration: const InputDecoration(
                      hintText: 'Ingresa una fecha',
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.all(6)
                  ) ,
                  ),
              ),
              SizedBox(width: 4,),
              Container(
                  height: 30,
                  width: 30,
                  child: RawMaterialButton(
                      fillColor: Color.fromRGBO(189, 211, 135, 1),
                      shape: CircleBorder(),
                      elevation: 0.0,
                      child: Icon(Icons.date_range, color: Colors.white, size: 17,),
                      onPressed: () async{
                        _myDateTime = (await showDatePicker(
                            firstDate: DateTime(2010),
                            initialDate: DateTime.now(),
                            context: context,
                            lastDate: DateTime(2030)
                        ))!;
                        setState((){
                          valorFechaInicio.text = DateFormat('dd-MM-yy').format(_myDateTime);
                        });
                      }
                  )
              )
            ],
          ),
          SizedBox(height: 6,),
          Row(
            children: <Widget>[
              const Text('Fecha final:', style: TextStyle(fontSize: 14)),
              SizedBox(width: 10,),
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 14),
                  controller: valorFechaFinal,
                  keyboardType: TextInputType.none,
                  decoration: const InputDecoration(
                    hintText: 'Ingresa una fecha',
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.all(6),
                  ) ,
                ),
              ),
              SizedBox(width: 4,),
              Container(
                height: 30,
                width: 30,
                child: RawMaterialButton(
                  fillColor: Color.fromRGBO(189, 211, 135, 1),
                  shape: CircleBorder(),
                  elevation: 0.0,
                  child: Icon(Icons.date_range, color: Colors.white, size: 17,),
                  onPressed: () async{
                    _myDateTime = (await showDatePicker(
                    firstDate: DateTime(2010),
                    initialDate: DateTime.now(),
                    context: context,
                    lastDate: DateTime(2030)
                    ))!;
                    setState((){
                    valorFechaFinal.text = DateFormat('dd-MM-yy').format(_myDateTime);
                    });
                  }
                )
              )

            ],
          ),
          SizedBox(height: 6,),
          Row(
            children: <Widget>[
              const Text('Hora inicio:', style: TextStyle(fontSize: 13)),
              SizedBox(width: 2,),
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 12),
                  controller: valorHoraInicio,
                  keyboardType: TextInputType.none,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '🕐',
                    isDense: true,
                    contentPadding: EdgeInsets.all(6),
                  ) ,
                ),
              ),
              SizedBox(width: 2,),
              Container(
                  height: 20,
                  width: 20,
                  child: RawMaterialButton(
                      fillColor: Color.fromRGBO(189, 211, 135, 1),
                      shape: CircleBorder(),
                      elevation: 0.0,
                      child: Icon(Icons.hourglass_top, color: Colors.white, size: 15,),
                      onPressed: () async{
                        _myTime = (await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now()
                        ))!;
                        setState((){
                          if(_myTime.minute<10){
                            valorHoraInicio.text = '${_myTime.hour}:0${_myTime.minute}';
                          }else{
                            valorHoraInicio.text = '${_myTime.hour}:${_myTime.minute}';
                          }
                        });
                      }
                  )
              ),
              SizedBox(width: 6,),
              const Text('Hora final:', style: TextStyle(fontSize: 13)),
              SizedBox(width: 2,),
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 12),
                  controller: valorHoraFinal,
                  keyboardType: TextInputType.none,
                  decoration: const InputDecoration(
                    hintText: '🕐',
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.all(6),
                  ) ,
                ),
              ),
              SizedBox(width: 2,),
              Container(
                  height: 20,
                  width: 20,
                  child: RawMaterialButton(
                      fillColor: Color.fromRGBO(189, 211, 135, 1),
                      shape: CircleBorder(),
                      elevation: 0.0,
                      child: Icon(Icons.hourglass_bottom, color: Colors.white, size: 15,),
                      onPressed: () async{
                        _myTime = (await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now()
                        ))!;
                        setState((){
                          if(_myTime.minute<10){
                            valorHoraFinal.text = '${_myTime.hour}:0${_myTime.minute}';
                          }else{
                            valorHoraFinal.text = '${_myTime.hour}:${_myTime.minute}';
                          }
                        });
                      }
                  )
              )
            ],
          ),
        ],
      ),
      actions: [
        cancelButton,okButton
      ],
    );

    showDialog(
      context: context,
      barrierDismissible: false, //modal
      builder: (BuildContext dialogContext){
        return alert;
      },
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
      ..color = const Color.fromRGBO(226, 221, 235, 0.48)
      ..strokeWidth = 2;

    Paint circlePink = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color.fromRGBO(211, 240, 210, 0.47)
      ..strokeWidth = 2;

    canvas.drawCircle(Offset(width*0.05, height*0.23), 100, circleGrey);
    canvas.drawCircle(Offset(width*0.9, height*0.7), 100, circlePink);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
