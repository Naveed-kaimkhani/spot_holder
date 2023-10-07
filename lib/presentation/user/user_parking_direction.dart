import 'dart:async';
import 'dart:ui' as ui;
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spot_holder/Data/FirebaseUserRepository.dart';
import 'package:spot_holder/utils/utils.dart';

import '../../Domain/models/reserved_parking_model.dart';
import '../../Domain/models/user_model.dart';
import '../../provider/user_provider.dart';
import '../../style/styling.dart';
import '../widget/tracing_screen_bottom.dart';
import 'loading_map.dart';

class UserParkingTraking extends StatefulWidget {
  final ReservedParkingModel parkingModel;
  const UserParkingTraking({super.key, required this.parkingModel});

  @override
  State<UserParkingTraking> createState() => _UserParkingTrakingState();
}

class _UserParkingTrakingState extends State<UserParkingTraking> {
  final CustomInfoWindowController _windowinfoController =
      CustomInfoWindowController();
  final String apiKey = 'AIzaSyB_uj7e2Au3zoDSB0kLeBrio2Q_QKjlWmM';
  // LatLng? sourceLocation = const LatLng(0.0, 0.0);
  LatLng? destinationLocation;
  UserModel? user;
  Uint8List? sellerTracingIcon;

  Uint8List? sellerLocation;
  final Completer<GoogleMapController> _controller = Completer();
  FirebaseUserRepository _firebaseUserRepository = FirebaseUserRepository();

  List<LatLng> polyLineCoordinates = [];
  Position? currentLocation;
  StreamSubscription<Position>? positionStreamSubscription;
  String? distance;

  void getUserCurrentLocation() async {
    try {
      currentLocation = Position(
        latitude: user!.lat!,
        longitude: user!.long!,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        altitudeAccuracy: 0.0,
        headingAccuracy: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        isMocked: false,
        floor: null,
      );

      distance = utils.getDistancebtwSourceNDestination(
          currentLocation!.latitude,
          currentLocation!.longitude,
          widget.parkingModel.locationLat!,
          widget.parkingModel.locationLong!);

      // await _firebaseUserRepository.getUserCurrentLocation(context);

      // setState(() {});
      // print("before postion stream $currentLocation");
      addMarker();
      getPolyPoints();
      positionStreamSubscription = Geolocator.getPositionStream().listen(
        (Position position) async {
          // GoogleMapController controller = await _controller.future;
          await FirebaseUserRepository.updateRiderLocation(
              position.latitude, position.longitude);

          setState(() {
            currentLocation = position;
            distance = utils.getDistancebtwSourceNDestination(
                position.latitude,
                position.longitude,
                widget.parkingModel.locationLat!,
                widget.parkingModel.locationLong!);
            // controller.animateCamera(
            //   CameraUpdate.newCameraPosition(
            //     CameraPosition(
            //       target: LatLng(
            //           currentLocation!.latitude, currentLocation!.longitude),
            //       zoom: 18,
            //     ),
            //   ),
            // );
          });
        },
        onError: (e) {
          print(e);
          // utils.flushBarErrorMessage(e.toString(), context);
        },
      );
    } catch (error) {
      print(error);
      // utils.flushBarErrorMessage(error.toString(), context);
      return null; // or throw the error
    }
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey,
        PointLatLng(currentLocation!.latitude, currentLocation!.longitude),
        PointLatLng(widget.parkingModel.locationLat!,
            widget.parkingModel.locationLong!));
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polyLineCoordinates.add(LatLng(point.latitude, point.longitude)));
      // addMarker();
      setState(() {});
    }
  }

  Future<Uint8List> getByteFromAssets(String path, int widht) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: widht);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Position> convertLatLngToPosition(LatLng latLng) async {
    return Position(
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      altitudeAccuracy: 0.0,
      headingAccuracy: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
      isMocked: false,
      floor: null,
    );
  }

  addMarker() async {
    sellerTracingIcon = await getByteFromAssets("assets/dir.png", 160);
    // sellerLocation = await getByteFromAssets("assets/SellerLocation.png", 70);
  }

  @override
  void dispose() {
    positionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    utils.checkConnectivity(context);

    user = Provider.of<UserProvider>(context, listen: false).user;

    getUserCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    String dis = distance.toString();
    double halfLength =
        dis.length / 3; // Calculate the half length of the string
    double firstLine = (widget.parkingModel.parkingAddress!.length / 2);
    return SafeArea(
      child: sellerTracingIcon == null
          ? const LoadingMap()
          : Scaffold(
              bottomNavigationBar: TracingScreenBottomNavigation(
                distance: distance,
                halfLength: halfLength,
                text: "call owner",
                // widget: widget,
                phone: widget.parkingModel.userContact!,
                address: widget.parkingModel.parkingAddress!,
                firstLine: firstLine,
              ),
              body: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(currentLocation!.latitude,
                            currentLocation!.longitude),
                        zoom: 18),
                    compassEnabled: true,
                    markers: {
                      Marker(
                          markerId: const MarkerId(
                            "0",
                          ),
                          position: LatLng(currentLocation!.latitude,
                              currentLocation!.longitude),
                          icon: BitmapDescriptor.fromBytes(sellerTracingIcon!),
                          infoWindow:
                              const InfoWindow(title: "Current Position")),
                      Marker(
                          markerId: const MarkerId("1"),
                          position: LatLng(widget.parkingModel.locationLat!,
                              widget.parkingModel.locationLong!),
                          // icon: BitmapDescriptor.fromBytes(sellerLocation!),
                          infoWindow: const InfoWindow(title: "Parking")),
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      _windowinfoController.googleMapController = controller;
                    },
                    // onTap: (position) {
                    //   _windowinfoController.hideInfoWindow!();
                    // },
                    polylines: {
                      Polyline(
                        polylineId: const PolylineId('route'),
                        points: polyLineCoordinates,
                        color: Styling.primaryColor,
                        width: 6,
                      )
                    },
                  ),
                  const BackButton(),
                  // CustomInfoWindow(
                  //   controller: _windowinfoController,
                  //   height: 150,
                  //   width: 300,
                  //   offset: 10,
                  // ),
                ],
              ),
            ),
    );
  }
}
