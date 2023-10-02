import 'dart:async';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spot_holder/style/styling.dart';
import 'package:spot_holder/utils/utils.dart';
import '../../Domain/models/reserved_parking_model.dart';
import '../user/loading_map.dart';
import '../widget/tracing_screen_bottom.dart';
import '../widget/user_marker_info_window.dart';

class TrackUser extends StatefulWidget {
  final ReservedParkingModel requestModel;
  const TrackUser({super.key, required this.requestModel});

  @override
  State<TrackUser> createState() => _TrackUserState();
}

class _TrackUserState extends State<TrackUser> {
  final CustomInfoWindowController _windowinfoController =
      CustomInfoWindowController();
  final String apiKey = 'AIzaSyB_uj7e2Au3zoDSB0kLeBrio2Q_QKjlWmM';
  LatLng? riderLocation;
  Uint8List? sellerTracingIcon;
  final Completer<GoogleMapController> _controller = Completer();
  List<LatLng> polyLineCoordinates = [];
  Position? currentLocation;
  double? distance;
  double getDistancebtwRiderNSeller(
    double riderLat,
    double riderLong,
  ) {
    return Geolocator.distanceBetween(riderLat, riderLong,
        widget.requestModel.locationLat!, widget.requestModel.locationLong!);
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      apiKey,
      PointLatLng(
          widget.requestModel.locationLat!, widget.requestModel.locationLong!),
      PointLatLng(riderLocation!.latitude, riderLocation!.longitude),

      // PointLatLng(25.5238, 69.0141),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polyLineCoordinates.add(LatLng(point.latitude, point.longitude)));
      setState(() {});
    }
    addMarker();
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

  addMarker() async {
    sellerTracingIcon = await getByteFromAssets("assets/man.png", 100);
    // sellerLocation = await getByteFromAssets("assets/SellerLocation.png", 70);
  }

// Initialize Firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

// Start listening to rider location updates
  void listenToRiderLocation() async {
    // print("listenToRiderLocation");
    await firestore
        .collection('users')
        .doc(widget.requestModel.userUid)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        // Handle rider's location update
        double latitude = snapshot['lat'];
        double longitude = snapshot['long'];
        setState(() {
          riderLocation = LatLng(latitude, longitude);

          distance = getDistancebtwRiderNSeller(
              riderLocation!.latitude, riderLocation!.longitude);
        });
        // Update the rider's location on the map or do other processing as needed
      }
      getPolyPoints();
    });
    if (riderLocation != null) {
      getPolyPoints();
    }
  }

  @override
  void dispose() {
    // positionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    utils.checkConnectivity(context);
    addMarker();
    listenToRiderLocation();
  }

  @override
  Widget build(BuildContext context) {
    String dis = distance.toString();
    double halfLength =
        dis.length / 3; // Calculate the half length of the string
    double firstLine = (widget.requestModel.parkingAddress!.length / 2);
    return SafeArea(
      child: riderLocation == null &&
              sellerTracingIcon == null &&
              distance == null
          ? const LoadingMap()
          : Scaffold(
              bottomNavigationBar: TracingScreenBottomNavigation(
                distance:
                    "${(distance! / 1000).toString().substring(0, distance.toString().length ~/ 3)} km",
                halfLength: halfLength,
                address: widget.requestModel.parkingAddress!,
                firstLine: firstLine,
                phone: widget.requestModel.userContact!,
                text: "call user",
              ),
              body: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(widget.requestModel.locationLat!,
                            widget.requestModel.locationLong!),
                        zoom: 18),
                    compassEnabled: true,
                    markers: {
                      Marker(
                          markerId: const MarkerId(
                            "0",
                          ),
                          position: LatLng(widget.requestModel.locationLat!,
                              widget.requestModel.locationLong!),
                          icon: BitmapDescriptor.defaultMarker,
                          infoWindow: const InfoWindow(title: "Your Position")),
                      Marker(
                        markerId: const MarkerId("1"),
                        position: riderLocation!,
                        icon: sellerTracingIcon == null
                            ? BitmapDescriptor.defaultMarker
                            : BitmapDescriptor.fromBytes(sellerTracingIcon!),
                        onTap: () {
                          _windowinfoController.addInfoWindow!(
                            UserMarkerInfoWindow(
                              request: widget.requestModel,
                            ),
                            LatLng(widget.requestModel.locationLat!,
                                widget.requestModel.locationLong!),
                          );
                        },
                      ),
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      _windowinfoController.googleMapController = controller;
                    },
                    onTap: (position) {
                      _windowinfoController.hideInfoWindow!();
                    },
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
}
