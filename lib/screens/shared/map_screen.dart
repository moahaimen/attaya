import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/user.dart';
import '../../consts/consts.dart';
import '../../models/family.dart';
import './search_and_filter.dart';
import '../../consts/loading.dart';
import '../../services/data_base.dart';
import '../../services/location_service.dart';
import '../../screens/family/add_family.dart';
import '../../services/shered_Preference.dart';
import '../../screens/family/family_details.dart';
import '../../functions/check_location_permission.dart';

class MapScreen extends StatefulWidget {
  final LatLng findOnMap;
  final bool isSelectLocation;
  final bool isOrg;
  final bool hasLoginIcon;

  const MapScreen({
    this.findOnMap,
    this.isSelectLocation = false,
    this.isOrg = false,
    this.hasLoginIcon = false,
  });
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMap map;
  DatabaseService database;
  Set<Marker> markers = {};
  Set<Polyline> roads = <Polyline>{};
  bool _onlyIsNeedd = false, _onlyNotNeed = false;
  String searchText;
  LatLng myLocation;
  final TextEditingController searchTextController = TextEditingController();
  final _controller = Completer();
  bool hasPremission;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final requestPremissionResult = await checkLocationPermision();
      setState(() {
        hasPremission = requestPremissionResult;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    searchTextController.addListener(() {
      setState(() {
        searchText = searchTextController.text;
      });
    });

    return Scaffold(
      appBar: apBar('الخريطة', context,
          isNotsubScreen: true, hasLoginIcon: widget.hasLoginIcon),
      body: StreamBuilder<Position>(
        stream: Stream.fromFuture(mylocation()),
        builder: (context, snapshot) {
          if (snapshot.data != null && hasPremission) {
            final position = snapshot.data;
            roads.clear();
            myLocation = LatLng(position.latitude, position.longitude);

            return StreamBuilder<List<Family>>(
              stream: DatabaseService('').families,
              builder: (context, snap) {
                if (snap.data != null) {
                  roads.clear();
                  final data = snap.data;
                  if (widget.isSelectLocation) data.clear();

                  markers.clear();
                  var families = data;
                  if (searchText != null &&
                      searchText.isNotEmpty &&
                      searchText.length >= 4) {
                    families = data.where((f) {
                      return f.headOfFamily.contains(searchText);
                    }).toList();
                    navigateTofirstMarker();
                  }
                  for (var i = 0; i < families.length; i++) {
                    final f = families[i];

                    if (!_onlyIsNeedd && !_onlyNotNeed) {
                      addMarker(f);
                    } else if (_onlyIsNeedd) {
                      if (f.isNeedHelp) addMarker(f);
                    } else if (_onlyNotNeed) {
                      if (!f.isNeedHelp) addMarker(f);
                    }
                  }
                  return Stack(
                    children: <Widget>[
                      GoogleMap(
                        onLongPress: onLongPress,
                        onTap: (argument) {
                          if (!currentFocus.hasPrimaryFocus) {
                            // currentFocus..requestFocus(FocusNode());
                            currentFocus.unfocus();
                          }
                        },
                        polylines: roads,
                        onMapCreated: _controller.complete,
                        buildingsEnabled: false,
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          zoom: 15,
                          target: widget.findOnMap ?? myLocation,
                        ),
                        myLocationButtonEnabled: true,
                        markers: markers,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: SearchAndFilter(
                          searchTextController: searchTextController,
                          currentFocus: currentFocus,
                          onSelectProvance: (value) async {
                            if (value.isNotEmpty) {
                              final a = await stateLocation(value);
                              final controller = await _controller.future
                                  as GoogleMapController;
                              setState(
                                () {
                                  controller.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                        zoom: 13,
                                        target: LatLng(a.coordinates.latitude,
                                            a.coordinates.longitude),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          sortBaseOnNeed: (onlyIsNeed, onlyNotNeed) {
                            setState(() {
                              _onlyIsNeedd = onlyIsNeed;
                              _onlyNotNeed = onlyNotNeed;
                            });
                          },
                        ),
                      ),
                      currentFocus.hasFocus
                          ? Container()
                          : Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        widget.isSelectLocation
                                            ? 'اضغط مطولا على الموقع اللذي تريدة لتحديده'
                                            : 'اضغط مطولا اعلى اي موقع تريده لاضافة عائلة في هذا الموقع',
                                        textAlign: TextAlign.center,
                                        style: textStyle.copyWith(fontSize: 10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 55),
                                ],
                              ),
                            ),
                    ],
                  );
                } else {
                  return const Loading();
                }
              },
            );
          } else {
            return Center(
                child: Text('يجب تفعيل الموقع الجغرافي', style: textStyle));
          }
        },
      ),
    );
  }

  void onLongPress(LatLng latLng) {
    showDialog(
      context: context,
      builder: (context) {
        // return object of type Dialog
        final title =
            widget.isSelectLocation ? "تاكيد الاختيار" : 'اضافة عائلة';
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text(
              title,
              style: textStyle,
            ),
            content: Text(
              widget.isSelectLocation
                  ? 'هل انت متاكد من اختيا هذا الموقع؟'
                  : 'هل تريد اضافة عائلة في هذا الموقع؟',
              style: textStyle.copyWith(fontSize: 13),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  setState(
                    () {
                      if (widget.isSelectLocation) {
                        Navigator.of(context).pop(latLng);
                      } else {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (_) => AddFamily(
                              isAdmin: !widget.isOrg,
                              location: latLng,
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
                child: Text(
                  "اضافة",
                  style: textStyle.copyWith(color: Colors.blue),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "الغاء",
                  style: textStyle.copyWith(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void addMarker(Family f) {
    markers.add(
      Marker(
        infoWindow: InfoWindow(
          onTap: () async {
            final user = await SharedPrefs().getUser();
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => FamilyDetails(
                  isAdmin: user.userType == UserType.admin ? true : false,
                  familyId: f.id,
                ),
              ),
            );
          },
          title: f.headOfFamily,
          snippet: (f.isNeedHelp) ? 'تحتاج مساعدة ' : 'لا تحتاج مساعدة',
        ),
        markerId: MarkerId(f.id),
        onTap: () {
          setState(
            () {
              roads.add(
                Polyline(
                  polylineId: PolylineId(f.id),
                  points: [
                    myLocation,
                    LatLng(
                      f.location.latitude,
                      f.location.longitude,
                    )
                  ],
                ),
              );
            },
          );
        },
        position: LatLng(f.location.latitude, f.location.longitude),
      ),
    );
  }

  Future navigateTofirstMarker() async {
    final controller = await _controller.future as GoogleMapController;
    if (markers.isNotEmpty) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 18,
            target: LatLng(
              markers.first.position.latitude,
              markers.first.position.longitude,
            ),
          ),
        ),
      );
    }
  }
}
