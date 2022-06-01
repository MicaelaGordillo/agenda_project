import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class ScreenWork extends StatefulWidget {
  const ScreenWork({Key? key}) : super(key: key);

  @override
  State<ScreenWork> createState() => _ScreenWorkState();
}

class _ScreenWorkState extends State<ScreenWork> {
  int _selectedIndex = 0;
  bool isChecked = false;
  final tareas = List<String>.generate(10000, (i) => "Tarea $i");
  final frases = List<String>.generate(20, (i) => "Frase $i");

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          backgroundColor: const Color.fromRGBO(226, 221, 235, 100),
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
                    leading: Image.asset('assets/check.png', height: 35),
                    title: const Text(
                      'Todas las tareas',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                      itemCount: tareas.length,
                      itemBuilder: (context, index) => Card(
                        margin: const EdgeInsets.only(bottom: 2),
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: const Color.fromRGBO(170, 218, 199, 100),
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                print(index);
                                isChecked = value!;
                              });
                            },
                          ),
                          title: Text('${tareas[index]}'),
                          subtitle: Text('Icream is good for health'),
                          trailing: CircleAvatar(
                            backgroundColor: const Color.fromRGBO(255, 204, 163, 100),
                            radius: 15,
                            child: IconButton(
                              onPressed: (){
                                setState(() {
                                  print(index);
                                });
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 15,
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
        /*floatingActionButton: Container(
          height: 40,
          width: 40,
          child: FloatingActionButton(
            child: Icon(Icons.add, size: 30,),
            backgroundColor: Colors.grey,
            onPressed: (){
            },
          ),
        ),*/
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Stack(
          children: [
            Positioned(
              right: 15,
              top: 170,
              child: Container(
                height: 50,
                width: 50,
                child: FloatingActionButton(
                  child: const Icon(Icons.mic, size: 30,),
                  backgroundColor: Colors.grey,
                  onPressed: (){
                  },
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
                  child: const Icon(Icons.add, size: 30,),
                  backgroundColor: Colors.grey,
                  onPressed: (){
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
