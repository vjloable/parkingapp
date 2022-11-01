import 'package:flutter/material.dart';

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
        )
    );
  }
}