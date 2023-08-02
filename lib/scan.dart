import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scanner',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 22,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Builder(builder: (BuildContext context) {
        return Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                child: ElevatedButton(
                  onPressed: () => scanBarcodeNormal(),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 241, 236, 236),
                    onPrimary: Color.fromARGB(255, 77, 79, 192),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 22,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 34),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 8,
                    shadowColor:
                        Color.fromARGB(255, 21, 0, 255).withOpacity(0.6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.barcode_reader), // Icon added here
                      SizedBox(
                          width:
                              15), // Adjust the spacing between the icon and text
                      Text('Barcode scan'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 11, horizontal: 50),
                child: ElevatedButton(
                  onPressed: () => scanQR(),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 241, 236, 236),
                    onPrimary: Color.fromARGB(255, 51, 0, 255),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 22,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 76),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 8,
                    shadowColor:
                        Color.fromARGB(255, 51, 0, 255).withOpacity(0.6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code), // Icon added here
                      SizedBox(
                          width:
                              15), // Adjust the spacing between the icon and text
                      Text('QR scan'),
                    ],
                  ),
                ),
              ),
              /* Padding(
                padding: EdgeInsets.symmetric(vertical: 11, horizontal: 16),
                child: ElevatedButton(
                  onPressed: () => startBarcodeScanStream(),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: AppTheme.darkText,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 22,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 26),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 11,
                    shadowColor: Colors.grey.withOpacity(0.9),
                  ),
                  child: const Text('Barcode scan stream'),
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'Scan result: $_scanBarcode\n',
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
