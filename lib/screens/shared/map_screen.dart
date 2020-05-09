import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../HomeScreen.dart';
import '../../services/family_sevices.dart';
import '../../services/location_service.dart';
import '../../services/shered_Preference.dart';

import '../../consts/consts.dart';
import '../../models/family.dart';
import '../../services/data_base.dart';
import '../../services/size_config.dart';
import './family_details.dart';

class MapScreen extends StatefulWidget {
  final bool isNotSupScreen;
  final bool isSelectLocation;
  final bool isOrg;

  MapScreen({
    @required this.isNotSupScreen,
    @required this.isSelectLocation,
    @required this.isOrg,
  });
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMap map;
  DatabaseService database;
  String initialValue = 'بغداد، Irak';
  Set<Marker> markers = Set();
  Set<Polyline> roads = Set<Polyline>();
  bool showSortingOptions = false, onlyIsNeedd = false, onlyNotNeed = false;
  String searchText;
  LatLng myLocation;
  final searchTextController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isOrg ? null : apBar('الخريطة', context),
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: StreamBuilder(
          stream: Stream.fromFuture(mylocation()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //searchText = '';

            if (snapshot.data != null) {
              roads.clear();
              myLocation =
                  LatLng(snapshot.data.latitude, snapshot.data.longitude);
              return StreamBuilder(
                stream: getFamilies(
                  isNeed: ((!onlyIsNeedd && !onlyNotNeed) ||
                          (onlyIsNeedd && onlyNotNeed))
                      ? null
                      : ((onlyIsNeedd) ? true : false),
                  name: (searchText == '') ? null : searchText,
                ),
                builder: (context, snap) {
                  print(snap.data);
                  if (snap.data != null) {
                    roads.clear();
                    List<Family> data = snap.data;

                    markers.clear();
                    for (var i = 0; i < data.length; i++) {
                      Family f = data[i];
                      if (onlyIsNeedd && onlyNotNeed ||
                          !onlyIsNeedd && !onlyNotNeed) {
                        addMarker(f);
                      } else if (onlyIsNeedd) {
                        if (f.isNeedHelp) addMarker(f);
                      } else if (onlyNotNeed) {
                        if (f.isNeedHelp) addMarker(f);
                      }
                    }
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        GoogleMap(
                          onLongPress: (value) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                // return object of type Dialog
                                String title = widget.isSelectLocation
                                    ? "تاكيد الاختيار"
                                    : 'اضافة عائلة';
                                return Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: AlertDialog(
                                    title: new Text(
                                      title,
                                      style: textStyle,
                                    ),
                                    content: new Text(
                                      widget.isSelectLocation
                                          ? 'هل انت متاكد من اختيا هذا الموقع؟'
                                          : 'هل تريد اضافة عائلة في هذا الموقع؟',
                                      style: textStyle.copyWith(fontSize: 13),
                                    ),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      new FlatButton(
                                        child: new Text(
                                          "اضافة",
                                          style: textStyle.copyWith(
                                              color: Colors.blue),
                                        ),
                                        onPressed: () {
                                          print(value);
                                          setState(
                                            () {
                                              if (widget.isSelectLocation) {
                                                Navigator.of(context).pop();
                                                Navigator.of(context)
                                                    .pop(value);
                                              }
                                            },
                                          );
                                        },
                                      ),
                                      new FlatButton(
                                        child: new Text(
                                          "الغاء",
                                          style: textStyle.copyWith(
                                              color: Colors.red),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          polylines: roads,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          buildingsEnabled: false,
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            zoom: 15,
                            target: myLocation,
                          ),
                          markers: markers,
                        ),
                        Container(
                          width: SizeConfig.screenWidth * 0.8,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              DropdownButton<String>(
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
                                  (String value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(
                                          value.replaceAll('، Irak', '')),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) async {
                                  setState(
                                    () {
                                      initialValue = val;
                                    },
                                  );

                                  if (val.isNotEmpty) {
                                    final a = await stateLocation(val);
                                    final GoogleMapController controller =
                                        await _controller.future;
                                    setState(
                                      () {
                                        controller.animateCamera(
                                          CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                              zoom: 18,
                                              target: LatLng(
                                                  a.coordinates.latitude,
                                                  a.coordinates.longitude),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                                value: initialValue,
                              ),
                              Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 0),
                                  child: new TextField(
                                    onChanged: (value) {
                                      setState(
                                        () async {
                                          searchText = value;
                                          final GoogleMapController controller =
                                              await _controller.future;
                                          setState(
                                            () {
                                              if (markers.length != 0) {
                                                setState(
                                                  () {
                                                    controller.animateCamera(
                                                      CameraUpdate
                                                          .newCameraPosition(
                                                        CameraPosition(
                                                          zoom: 18,
                                                          target: LatLng(
                                                            markers
                                                                .first
                                                                .position
                                                                .latitude,
                                                            markers
                                                                .first
                                                                .position
                                                                .longitude,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              } 
                                            },
                                          );
                                        },
                                      );
                                    },
                                    decoration: new InputDecoration(
                                      border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.teal)),
                                      hintText: 'بحث عن عائلة',
                                      // helperText: 'Keep it short, this is just a demo.',
                                      labelText: 'بحث',
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
                                          CheckboxListTile(
                                            title: Text(
                                              'العوائل المحتاجة.',
                                              style: textStyle.copyWith(
                                                fontSize: 15,
                                              ),
                                            ),
                                            value: onlyIsNeedd,
                                            onChanged: (value) {
                                              setState(
                                                () {
                                                  onlyIsNeedd = value;
                                                },
                                              );
                                            },
                                          ),
                                          CheckboxListTile(
                                            title: Text(
                                              'العوائل غير المحتاجة.',
                                              style: textStyle.copyWith(
                                                fontSize: 15,
                                              ),
                                            ),
                                            value: onlyNotNeed,
                                            onChanged: (value) {
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
                            ],
                          ),
                        )
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
