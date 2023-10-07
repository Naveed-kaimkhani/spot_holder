import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spot_holder/Data/FirebaseUserRepository.dart';
import 'package:spot_holder/presentation/no_data_found.dart';
import 'package:spot_holder/provider/parking_list_provider.dart';
import 'package:spot_holder/utils/utils.dart';
import '../../Domain/models/parking_model.dart';
import '../../Domain/models/user_model.dart';
import '../../provider/user_provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../style/images.dart';
import '../../style/styling.dart';
import '../widget/home_header.dart';
import '../widget/location_buttn.dart';
import '../widget/parking_info_window.dart';
import '../widget/previous_parking_widget.dart';
import 'booking.dart';

class ParkingSpotsOnMap extends StatefulWidget {
  const ParkingSpotsOnMap({Key? key});

  @override
  State<ParkingSpotsOnMap> createState() => _ParkingSpotsOnMapState();
}

class _ParkingSpotsOnMapState extends State<ParkingSpotsOnMap> {
  final Completer<GoogleMapController> _controller = Completer();
  final CustomInfoWindowController _windowinfoController =
      CustomInfoWindowController();
  List<ParkingModel>? _listOfParkingsModel;
  UserModel? user;
  bool isLoadingNow = false;

  static CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(24.965508, 69.293713),
    zoom: 18,
  );

  List<Marker> _marker = [];

  void isLoading(bool value) {
    setState(() {
      isLoadingNow = value;
    });
  }

  loadLocation() async {
    try {
      user = Provider.of<UserProvider>(context, listen: false).user;
      _listOfParkingsModel =
          Provider.of<ParkingListProvider>(context, listen: false).parkingList;
      addMarker(user!.lat!, user!.long!, '1', 'My Position 1');
      if (mounted) {
        setState(() {
          _cameraPosition = CameraPosition(
            target: LatLng(user!.lat!, user!.long!),
            zoom: 18,
          );
          animateCamera();
        });
      }
    } catch (error) {
      // utils.flushBarErrorMessage(error.toString(), context);
    }
  }

  void addMarker(double lat, double long, String markerId, String title) {
    _marker.add(Marker(
      position: LatLng(lat, long),
      markerId: MarkerId(markerId),
      infoWindow: InfoWindow(title: title),
    ));
  }

  void createSellersMarkers() async {
    final Uint8List icon = await getByteFromAssets(Images.locationIcon, 80);
    _marker = _listOfParkingsModel!.map((parking) {
      final markerId = MarkerId(parking.ownerName!);
      final marker = Marker(
        markerId: markerId,
        position: LatLng(parking.locationLat!, parking.locationLong!),
        anchor: const Offset(0.5, 0.0),
        icon: BitmapDescriptor.fromBytes(icon),
        onTap: () {

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Booking(parking: parking)));
          // _windowinfoController.addInfoWindow!(
          //   ParkingInfoWindow(parking: parking),
          //   LatLng(parking.locationLat!, parking.locationLong!),
          // );
        },
      );
      return marker;
    }).toList();

    _marker.add(Marker(
      position: LatLng(user!.lat!, user!.long!),
      markerId: MarkerId(user!.name!),
      infoWindow: const InfoWindow(title: "Your Position"),
    ));
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> animateCamera() async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  Future<Uint8List> getByteFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  // icon: Icon(Icons.),


  @override
  void initState() {
    super.initState();
    utils.checkConnectivity(context);
    loadLocation();

    createSellersMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Locationbttn(func: animateCamera),
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: SizedBox(
                height: 115.h,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _listOfParkingsModel!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: PreviousParkingWidget(
                            parking: _listOfParkingsModel![index]),
                      onTap: (){
                        
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Booking(parking: _listOfParkingsModel![index],)));
                      },
                      );
                      
                    }),
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            _listOfParkingsModel!.isEmpty
                ? NoDataFoundScreen(text: "No Available Parking")
                : GoogleMap(
                    initialCameraPosition: _cameraPosition,
                    compassEnabled: true,
                    markers: Set<Marker>.of(_marker),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      _windowinfoController.googleMapController = controller;
                    },
                    onTap: (position) {
                      _windowinfoController.hideInfoWindow!();
                    },
                  ),
            HomeHeader(
              height: 84.h,
              profile: user!.profileImage!,
              barTitle: "Map",
            ),
            CustomInfoWindow(
              controller: _windowinfoController,
              height: 150,
              width: 300,
              offset: 10,
            ),
          ],
        ),
      ),
    );
  }

  // Padding locationButton() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 110.0),
  //     child: FloatingActionButton(
  //       backgroundColor: Styling.primaryColor,
  //       heroTag: "btn2",
  //       child: const Icon(
  //         Icons.location_searching_outlined,
  //         color: Colors.white,
  //       ),
  //       onPressed: () async {
  //         animateCamera();
  //       },
  //     ),
  //   );
  // }

  Padding callButton(String phone) {
    return Padding(
      padding: const EdgeInsets.only(left: 110.0),
      child: FloatingActionButton(
        backgroundColor: Styling.primaryColor,
        heroTag: "btn1",
        child: const Icon(
          Icons.call,
          color: Colors.white,
        ),
        onPressed: () {
          utils.launchphone(phone, context);
        },
      ),
    );
  }
}
