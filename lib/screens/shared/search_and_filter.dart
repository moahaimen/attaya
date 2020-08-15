import 'package:flutter/material.dart';

import '../../consts/consts.dart';
import '../../services/size_config.dart';

class SearchAndFilter extends StatefulWidget {
  const SearchAndFilter({
    @required TextEditingController searchTextController,
    @required this.currentFocus,
    @required this.onSelectProvance,
    @required this.sortBaseOnNeed,
  }) : _searchTextController = searchTextController;

  final TextEditingController _searchTextController;
  final Function(bool onlyIsNeed, bool onlyNotNeed) sortBaseOnNeed;
  final Function(String value) onSelectProvance;
  final FocusScopeNode currentFocus;

  @override
  _SearchAndFilterState createState() => _SearchAndFilterState();
}

class _SearchAndFilterState extends State<SearchAndFilter> {
  bool showSortingOptions = false;
  String initialValue = 'بغداد، Irak';
  bool onlyIsNeed = false;
  bool onlyNotNeed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                controller: widget._searchTextController,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  hintText: 'بحث عن عائلة',
                  labelText: 'بحث عن عائلة',
                  isDense: true,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.sort),
                    onPressed: () {
                      setState(() => showSortingOptions = !showSortingOptions);
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'المحافظة',
                              style: textStyle.copyWith(fontSize: 15),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.only(
                                  left: 30, right: 30, top: 5, bottom: 5),
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
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child:
                                          Text(value.replaceAll('، Irak', '')),
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
                                  widget.onSelectProvance(val);
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
                        value: onlyIsNeed,
                        onChanged: (value) {
                          setState(() {
                            onlyIsNeed = value;
                            if (onlyNotNeed) {
                              onlyNotNeed = !value;
                            }
                          });
                          widget.sortBaseOnNeed(onlyNotNeed, onlyIsNeed);
                          widget.currentFocus.unfocus();
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
                          setState(() {
                            onlyNotNeed = value;
                            if (onlyIsNeed) {
                              onlyIsNeed = !value;
                            }
                          });
                          widget.sortBaseOnNeed(onlyNotNeed, onlyIsNeed);
                          widget.currentFocus.unfocus();
                        },
                      )
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
