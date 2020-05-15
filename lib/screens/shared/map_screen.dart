import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/user.dart';
import '../../consts/consts.dart';
import '../../models/family.dart';
import '../../consts/loading.dart';
import '../../services/data_base.dart';
import '../../services/size_config.dart';
import '../../services/location_service.dart';
import '../../screens/family/add_family.dart';
import '../../services/shered_Preference.dart';
import '../../screens/family/family_details.dart';
import '../../functions/check_location_permission.dart';

class MapScreen extends StatefulWidget {
  final LatLng findOnMap;
  final bool isSelectLocation;
  final bool isOrg;

  const MapScreen({
    this.findOnMap,
    this.isSelectLocation = false,
    this.isOrg = false,
  });
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMap map;
  DatabaseService database;
  String initialValue = 'بغداد، Irak';
  Set<Marker> markers = {};
  Set<Polyline> roads = <Polyline>{};
  bool showSortingOptions = false, onlyIsNeedd = false, onlyNotNeed = false;
  String searchText;
  LatLng myLocation;
  final TextEditingController searchTextController = TextEditingController();
  final _controller = Completer();

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    var currentFocus = FocusScope.of(context);

    searchTextController.addListener(() {
      setState(() {
        searchText = searchTextController.text;
      });
    });

    return Scaffold(
      appBar: widget.isOrg ? null : apBar('الخريطة', context),
      body: StreamBuilder<Position>(
        stream: Stream.fromFuture(mylocation()),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
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

                    if (onlyIsNeedd && onlyNotNeed ||
                        !onlyIsNeedd && !onlyNotNeed) {
                      addMarker(f);
                    } else if (onlyIsNeedd) {
                      if (f.isNeedHelp) addMarker(f);
                    } else if (onlyNotNeed) {
                      if (!f.isNeedHelp) addMarker(f);
                    }
                  }
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      GoogleMap(
                        onLongPress: (value) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              // return object of type Dialog
                              final title = widget.isSelectLocation
                                  ? "تاكيد الاختيار"
                                  : 'اضافة عائلة';
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
                                              Navigator.of(context).pop(value);
                                            } else {
                                              Navigator.of(context).push(
                                                CupertinoPageRoute(
                                                  builder: (_) => AddFamily(
                                                    isAdmin: !widget.isOrg,
                                                    location: value,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        );
                                      },
                                      child: Text(
                                        "اضافة",
                                        style: textStyle.copyWith(
                                            color: Colors.blue),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "الغاء",
                                        style: textStyle.copyWith(
                                            color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
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
                      Container(
                        width: SizeConfig.screenWidth * 0.9,
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                color: Colors.white,
                                child: TextField(
                                  controller: searchTextController,
                                  textDirection: TextDirection.rtl,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal),
                                    ),
                                    hintText: 'بحث عن عائلة',
                                    labelText: 'بحث عن عائلة',
                                    isDense: true,
                                    prefixIcon: Icon(Icons.search),
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.sort),
                                      onPressed: () {
                                        setState(
                                          () {
                                            showSortingOptions =
                                                !showSortingOptions;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            showSortingOptions
                                ? Card(
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'المحافظة',
                                                style: textStyle.copyWith(
                                                    fontSize: 15),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                padding: const EdgeInsets.only(
                                                    left: 30,
                                                    right: 30,
                                                    top: 5,
                                                    bottom: 5),
                                                child: DropdownButton<String>(
                                                  items: <String>[
                                                    'بغداد، Irak',
                                                    'بصرة، Irak',
                                                    'القادسية، Irak',
                                                    'ميسان، Irak',
                                                    'واسط، Irak',
                                                    'كربلاء ، Irak',
                                                    'النجف ، Irak',
                                                    'القادسية ، Irak',
                                                    'المثنى ، Irak',
                                                    'ذي قار ، Irak',
                                                    'بابل ، Irak',
                                                    'الانبار ، Irak',
                                                    'نينوى ، Irak',
                                                    'صلاح الدين ، Irak',
                                                    'ديالى ، Irak',
                                                    'كركوك ، Irak',
                                                    'دهوك ، Irak',
                                                    'اربيل ، Irak',
                                                    'السليمانية ، Irak',
                                                  ].map(
                                                    (value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(
                                                            value.replaceAll(
                                                                '، Irak', '')),
                                                      );
                                                    },
                                                  ).toList(),
                                                  isDense: true,
                                                  underline: Container(),
                                                  onChanged: (val) async {
                                                    setState(
                                                      () {
                                                        initialValue = val;
                                                      },
                                                    );

                                                    if (val.isNotEmpty) {
                                                      final a =
                                                          await stateLocation(
                                                              val);
                                                      final controller =
                                                          await _controller
                                                                  .future
                                                              as GoogleMapController;
                                                      setState(
                                                        () {
                                                          controller
                                                              .animateCamera(
                                                            CameraUpdate
                                                                .newCameraPosition(
                                                              CameraPosition(
                                                                zoom: 13,
                                                                target: LatLng(
                                                                    a.coordinates
                                                                        .latitude,
                                                                    a.coordinates
                                                                        .longitude),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }
                                                  },
                                                  value: initialValue,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        CheckboxListTile(
                                          title: Text(
                                            'العوائل المحتاجة',
                                            style: textStyle.copyWith(
                                              fontSize: 15,
                                            ),
                                          ),
                                          value: onlyIsNeedd,
                                          onChanged: (value) {
                                            if (!currentFocus.hasPrimaryFocus) {
                                              currentFocus.unfocus();
                                            }

                                            setState(
                                              () {
                                                onlyIsNeedd = value;
                                              },
                                            );
                                          },
                                        ),
                                        CheckboxListTile(
                                          title: Text(
                                            'العوائل غير المحتاجة',
                                            style: textStyle.copyWith(
                                              fontSize: 15,
                                            ),
                                          ),
                                          value: onlyNotNeed,
                                          onChanged: (value) {
                                            if (!currentFocus.hasPrimaryFocus) {
                                              currentFocus.unfocus();
                                            }
                                            setState(
                                              () {
                                                onlyNotNeed = value;
                                              },
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                : Container(),
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue,
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  widget.isSelectLocation
                                      ? 'اضغط مطولا على الموقع اللذي تريدة لتحديده'
                                      : 'اضغط مطولا اعلى اي موقع تريدة لاضافة عائلة في هذا الموقع',
                                  textAlign: TextAlign.center,
                                  style: textStyle.copyWith(fontSize: 10),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 55,
                            ),
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
            checkLocationPermision(navigateToMap: () {});
            return const Loading();
          }
        },
      ),
    );
  }
}
