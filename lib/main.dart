import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        title: 'Parking App',
        theme: ThemeData(
            primarySwatch: const MaterialColor(0xFFFFD60A, <int, Color>{
              50: Color(0xFFFFFAE2),
              100: Color(0xFFFFF3B6),
              200: Color(0xFFFFEB85),
              300: Color(0xFFFFE254),
              400: Color(0xFFFFDC2F),
              500: Color(0xFFFFD60A),
              600: Color(0xFFFFD109),
              700: Color(0xFFFFCC07),
              800: Color(0xFFFFC605),
              900: Color(0xFFFFBC03),
            }),
            fontFamily: 'Menlo',
            scaffoldBackgroundColor: const Color(0xFF383838)),
        home: const MyHomePage(
          title: 'Parking App',
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin {
  late AnimationController _controllerFast;
  late Animation _animationRadPB;
  late AnimationController _controllerBG;
  late Animation _animationBG;

  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _controllerFast =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    _animationRadPB = Tween<double>(begin: 0, end: 100.0).animate(_controllerFast);
    _controllerBG =
        AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _animationBG = ColorTween(begin: const Color(0xFF202020), end: const Color(0xFF222222)).animate(_controllerBG);

    _controllerBG.addListener(() {
      setState(() {});
    });
    _controllerFast.addListener(() {
      setState(() {});
    });
  }

  static bool _idleBool() {
    return false;
  }
  void _connectBtn() {
    setState(() {
      _isConnected = !_isConnected;
      _isConnected ? _controllerFast.repeat() : _controllerFast.stop();
      _controllerBG.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _animationBG.value,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 60, 10, 20),
            child: Center(
              child: SizedBox(
                  height: 340,
                  width: 340,
                  //300
                  child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            widget: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(_idleBool() ? '-' : '3B',
                                      style: TextStyle(
                                        fontSize: 100,
                                        color: _idleBool()
                                            ? const Color(0xFF585858)
                                            : const Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text('\nNext free lot in:',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Arial',
                                        fontFeatures: const [
                                          FontFeature.tabularFigures()
                                        ],
                                        color: _idleBool()
                                            ? const Color(0xFF585858)
                                            : const Color(0xFFFFD60A),
                                        fontWeight: FontWeight.w500,
                                      )),
                                  Text('${(_animationRadPB.value) ~/ 10}',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'Arial',
                                        fontFeatures: const [
                                          FontFeature.tabularFigures()
                                        ],
                                        color: _idleBool()
                                            ? const Color(0xFF585858)
                                            : const Color(0xFFFFD60A),
                                        fontWeight: FontWeight.bold,
                                      ))
                                ],
                              )
                            ),
                          ),
                        ],
                        minimum: 0,
                        maximum: 100,
                        showLabels: false,
                        showTicks: false,
                        startAngle: 270,
                        endAngle: 270,
                        axisLineStyle: AxisLineStyle(
                          thickness: 0.055,
                          cornerStyle: CornerStyle.bothFlat,
                          color: !_isConnected
                              ? const Color(0xFF585858)
                              : const Color(0xFFFFFFFF),
                          thicknessUnit: GaugeSizeUnit.factor,
                        ),
                        pointers: <GaugePointer>[
                          RangePointer(
                            value: _animationRadPB.value,
                            width: 0.055,
                            color: !_isConnected
                                ? const Color(0xFFFFFFFF)
                                : const Color(0xFFFFD60A),
                            pointerOffset: 0,
                            cornerStyle: CornerStyle.bothFlat,
                            sizeUnit: GaugeSizeUnit.factor,
                          )
                        ],
                      ),
                    ],
                  )
              ),
            ),
          ),
          _isConnected ? OutlinedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(5),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.fromLTRB(30, 15, 30, 15)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(_animationBG.value),
                foregroundColor: MaterialStateProperty.all<Color>((_idleBool())
                    ? const Color(0x44FFD60A)
                    : const Color(0xFFFFD60A)),
                side: MaterialStateProperty.all<BorderSide>(BorderSide(
                    width: 1.0,
                    color: (_idleBool())
                        ? const Color(0x44FFD60A)
                        : const Color(0xFFFFD60A))),
              ),
              onPressed: (_idleBool()) ? null : () {},
              child: Row(mainAxisSize: MainAxisSize.min, children: const [
                Icon(Icons.confirmation_num),
                Text('   RESERVE',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial'))
              ])):Container(),
          _isConnected ? Container(
              margin: const EdgeInsets.fromLTRB(40, 70, 40, 0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Column(
                      children: const [
                        Text('-',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF))),
                        Text('OCCUPIED',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF))),
                      ],
                    ),
                    Column(
                      children: const [
                        Text('10',
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFD60A))),
                        Text('AVAILABLE',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFD60A))),
                      ],
                    ),
                    Column(
                      children: const [
                        Text('-',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF))),
                        Text('RESERVED',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF))),
                      ],
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('\n\nNumber of Lots: 20',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arial',
                              color: Color(0xFFFFFFFF)))
                    ])
              ])):Container()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 50,
          shape: const CircularNotchedRectangle(),
          notchMargin: _isConnected ? 10 : 0,
          child: Row(
            children: [
              const Spacer(),
              SizedBox(
                  height: 80,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.settings_rounded),
                            iconSize: 40,
                            onPressed: () {}),
                        const Text('SETTINGS',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))
                      ])),
              const Spacer(),
              const Spacer(),
              SizedBox(
                  height: 80,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.info_rounded),
                            iconSize: 40,
                            onPressed: () {}),
                        const Text('HELP',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))
                      ])),
              const Spacer()
            ],
          )),
      floatingActionButton: SizedBox(
        height: _isConnected ? 70 : 0,
        width: _isConnected ? 70 : 0,
        child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ParkingSpace()),
              );
            },
            child: _isConnected ? const Icon(Icons.dashboard, size: 35):Container()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void dispose() {
    _controllerFast.dispose();
    _controllerBG.dispose();
    super.dispose();
  }
}

class ParkingSpace extends StatefulWidget {
  const ParkingSpace({Key? key}) : super(key: key);

  @override
  State<ParkingSpace> createState() => _ParkingSpaceState();
}

class _ParkingSpaceState extends State<ParkingSpace>
    with SingleTickerProviderStateMixin {
  List<String> _parkingLotsName() {
    return [
      '1A',
      '1B',
      '1C',
      '1D',
      '2A',
      '2B',
      '2C',
      '2D',
      '3A',
      '3B',
      '3C',
      '3D',
      '4A',
      '4B',
      '4C',
      '4D',
      '5A',
      '5B',
      '5C',
      '5D',
      '6A',
      '6B',
      '6C',
      '6D'
    ];
  }

  List<int> _parkingLotsStatus() {
    return [
      1,
      1,
      1,
      3,
      3,
      2,
      3,
      1,
      3,
      2,
      1,
      2,
      1,
      3,
      2,
      1,
      1,
      1,
      2,
      2,
      3,
      3,
      1,
      1
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose parking space',
            style: TextStyle(fontFamily: 'Arial')),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        padding: const EdgeInsets.all(30),
        children: List.generate(_parkingLotsName().length, (index) {
          return Center(
              child: RawMaterialButton(
                  onPressed: (_parkingLotsStatus()[index] == 1) ? () {} : null,
                  highlightColor: const Color(0xFFFFD60A),
                  highlightElevation: 15,
                  splashColor: const Color(0x44FFD60A),
                  elevation: 10.0,
                  fillColor: (_parkingLotsStatus()[index] == 1)
                      ? const Color(0xFFFFFFFF)
                      : const Color(0xFF4F4F4F),
                  padding: const EdgeInsets.all(14.0),
                  shape: const CircleBorder(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_parkingLotsName()[index].toString(),
                          style: const TextStyle(
                              color: Color(0xFF383838),
                              fontSize: 26,
                              fontWeight: FontWeight.bold)),
                      CircleAvatar(
                        radius: 4,
                        backgroundColor: (_parkingLotsStatus()[index] == 1)
                            ? const Color(0xFF00FF22)
                            : ((_parkingLotsStatus()[index] == 2)
                                ? const Color(0xFFFF0000)
                                : const Color(0xFFFFD60A)),
                      )
                    ],
                  )));
        }),
      ),
      bottomNavigationBar: const LinearProgressIndicator(
        backgroundColor: Color(0xFFFFFFFF),
        color: Color(0xFFFFD60A),
        value: 50,
      ),
    );
  }
}
