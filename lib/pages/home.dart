import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:parkingapp/pages/slots.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin {
  late AnimationController _controllerRadPB;
  late Animation _animationRadPB;
  //bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _controllerRadPB =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    _animationRadPB = Tween<double>(begin: 0, end: 100.0).animate(_controllerRadPB);
    /*
    _controllerBG.addListener(() {
      setState(() {});
    });
    */
    _controllerRadPB.addListener(() {
      setState(() {});
    });

    _controllerRadPB.repeat();
  }

  static bool _idleBool() {
    return false;
  }
  /*
  void _connectBtn() {
    setState(() {
      _isConnected = !_isConnected;
      _isConnected ? _controllerFast.repeat() : _controllerFast.stop();
    });
  }
   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222222),
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: Center(
              child: SizedBox(
                  height: 270,
                  width: 270,
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
                                          fontSize: 90,
                                          color: _idleBool()
                                              ? const Color(0xFF585858)
                                              : const Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text('Next free lot in:',
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
                        axisLineStyle: const AxisLineStyle(
                          thickness: 0.055,
                          cornerStyle: CornerStyle.bothFlat,
                          color: //!_isConnected
                          //    ? const Color(0xFF585858)
                          //    :
                          Color(0xFFFFFFFF),
                          thicknessUnit: GaugeSizeUnit.factor,
                        ),
                        pointers: <GaugePointer>[
                          RangePointer(
                            value: _animationRadPB.value,
                            width: 0.055,
                            color:
                            //? const Color(0xFFFFFFFF)
                            //:
                            const Color(0xFFFFD60A),
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
          OutlinedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(5),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.fromLTRB(30, 20, 30, 20)),
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
                Icon(Icons.confirmation_num, size: 16),
                Text('   RESERVE',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial'))
              ])),
          Container(
              margin: const EdgeInsets.fromLTRB(40, 25, 40, 0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Column(
                      children: const [
                        Text('12',
                            style: TextStyle(
                                fontSize: 30,
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
                                fontSize: 40,
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
                        Text('8',
                            style: TextStyle(
                                fontSize: 30,
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
              ]))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 50,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
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
              const Text('\n\n\nSLOTS', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
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
          height: 70,
          width: 70,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ParkingSpace()),
              );
            },
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.dashboard, size: 40),
                ]
            ),
          )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void dispose() {
    _controllerRadPB.dispose();
    super.dispose();
  }
}