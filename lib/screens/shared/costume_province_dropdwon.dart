import 'package:flutter/material.dart';

class SelectProvinceDropDwon extends StatelessWidget {
  final String initialValue;
  final Function(String newValue) onSelectedProvince;
  final bool isBlue;
  const SelectProvinceDropDwon({
    this.onSelectedProvince,
    this.initialValue,
    this.isBlue = false,
  });

  // var _selectedProvince = "بغداد";
  @override
  Widget build(BuildContext context) {
    final _muhafazat = [
      "بغداد",
      "البصرة",
      "المثنى",
      "اربيل",
      "السليمانية",
      "القادسية",
      "الانبار",
      "النجف",
      "بابل",
      "ديالى",
      "دهوك",
      "ذي قار",
      "صلاح الدين",
      "كربلاء",
      "كركوك",
      "ميسان",
      "نينوى",
      "واسط"
    ];
    return Container(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<String>(
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w800,
                color:
                    isBlue ? const Color(0xffA5D5EB) : const Color(0xffDC9292),
              ),
              underline: Container(),
              isExpanded: true,
              items: _muhafazat.map((dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: SizedBox(
                      width: 200,
                      child:
                          Text(dropDownStringItem, textAlign: TextAlign.right)),
                );
              }).toList(),
              onChanged: onSelectedProvince,
              hint: Text(
                'اختر محافظتك',
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w800,
                  color: isBlue
                      ? const Color(0xffA5D5EB)
                      : const Color(0xffDC9292),
                ),
              ),
              value: initialValue.isEmpty ? null : initialValue,
            ),
          ),
        ),
      ),
    );
  }
}
