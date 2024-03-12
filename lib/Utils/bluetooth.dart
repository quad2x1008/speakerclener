import 'dart:async';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speakerclener/Utils/BlueTooth/BluetoothDeviceListEntry.dart';
import 'package:speakerclener/ads/BannerAds.dart';
import 'package:speakerclener/main.dart';
import 'package:speakerclener/screens/Homescreen.dart';

class BlueThootScreen extends StatefulWidget {
  final bool checkAvailability;

  const BlueThootScreen({this.checkAvailability = true});

  @override
  State<BlueThootScreen> createState() => _BlueThootScreenState();
}

enum _DeviceAvailability {
  no,
  maybe,
  yes,
}

class _DeviceWithAvailability {
  BluetoothDevice device;
  _DeviceAvailability availability;
  int? rssi;

  _DeviceWithAvailability(this.device, this.availability, [this.rssi]);
}

class _BlueThootScreenState extends State<BlueThootScreen> {
  // Availability
  StreamSubscription<BluetoothDiscoveryResult>? _discoveryStreamSubscription;
  bool _isDiscovering = false;

  List<_DeviceWithAvailability> devices = List<_DeviceWithAvailability>.empty(growable: true);
  bool isDeviceConnected = false;
  String connectedDeviceName = '';
  bool blucheck = false;

  @override
  void initState() {
    super.initState();

    _isDiscovering = widget.checkAvailability;

    if (_isDiscovering) {
      _startDiscovery();
    }

    // Setup a list of the bonded devices
    FlutterBluetoothSerial.instance.getBondedDevices().then((List<BluetoothDevice> bondedDevices) {
      setState(() {
        devices = bondedDevices
            .map(
              (device) => _DeviceWithAvailability(
                device,
                widget.checkAvailability ? _DeviceAvailability.maybe : _DeviceAvailability.yes,
              ),
            )
            .toList();
      });
    });
  }

  void _restartDiscovery() {
    setState(() {
      _isDiscovering = true;
    });

    _startDiscovery();
  }

  void _startDiscovery() {
    _discoveryStreamSubscription = FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        Iterator i = devices.iterator;
        while (i.moveNext()) {
          var _device = i.current;
          if (_device.device == r.device) {
            _device.availability = _DeviceAvailability.yes;
            _device.rssi = r.rssi;
          }
        }
      });
    });

    _discoveryStreamSubscription?.onDone(() {
      setState(() {
        _isDiscovering = false;
      });
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _discoveryStreamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<BluetoothDeviceListEntry> list = devices
        .map((_device) => BluetoothDeviceListEntry(
              device: _device.device,
              rssi: _device.rssi,
              enabled: _device.availability == _DeviceAvailability.yes,
              onTap: () {
                Navigator.of(context).pop(_device.device);
              },
            ))
        .toList();
    return devices.isEmpty
        ? Scaffold(
            body: Container(
              height: 1.sh,
              width: 1.sw,
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                height: 0.06.sh,
                                width: 0.06.sh,
                                margin: EdgeInsets.only(left: 20.w, top: 10.h),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/arrowback.png"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 30.h, left: 10.w, right: 10.w),
                            child: Text(
                              "Headset Cleaning",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff147ADD),
                                fontSize: 30.sp,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ),
                          Container(
                            height: 0.30.sh,
                            width: 0.30.sh,
                            margin: EdgeInsets.only(top: 10.h),
                            decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage("assets/headphone.png"))),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                            child: Text(
                              "Please plug in your headphones \n to continue",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff147ADD), fontSize: 20.sp, fontFamily: "Poppinsreg"),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.h),
                            child: Text(
                              "If you have a Bluetooth headphone device \n then connect it with your phone",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff147ADD), fontSize: 15.sp, fontFamily: "Poppinsreg"),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.h),
                            child: TextButton(
                              onPressed: () {
                                AppSettings.openBluetoothSettings().then((value) {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                    return HomePage();
                                  },));
                                });
                              },
                              child: Text(
                                isDeviceConnected ? "Connected to a Device" : "Connect to a Device",
                                style: TextStyle(
                                    color: Color(0xff147ADD), fontSize: 24.sp, fontFamily: "Poppinsreg"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // BannerAds()
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Select device'),
              actions: <Widget>[
                _isDiscovering
                    ? FittedBox(
                        child: Container(
                          margin: new EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                      )
                    : IconButton(
                        icon: Icon(Icons.replay),
                        onPressed: _restartDiscovery,
                      )
              ],
            ),
            body: ListView(children: list),
          );
  }
}
