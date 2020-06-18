import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts/consts.dart';
import '../../screens/family/add_family.dart';
import '../../screens/admin/requests_list.dart';
import '../../screens/family/families._list.dart';
import '../../screens/orignization/organisations_list.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'التحكم',
              style: textStyle.copyWith(fontSize: 25),
              textAlign: TextAlign.center,
            ),
            ControlPanelButton(
              textStyle: textStyle,
              imageIcon: Image.asset('assets/icons/add_icon.png'),
              lable: 'اضافة عائلة',
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (_) => const AddFamily(isAdmin: true),
                  ),
                );
              },
            ),
            ControlPanelButton(
              textStyle: textStyle,
              imageIcon: Image.asset('assets/icons/delete_icon.png'),
              lable: 'حذف عائلة',
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (_) => const FamiliesList(isAdmin: true),
                  ),
                );
              },
            ),
            ControlPanelButton(
              textStyle: textStyle,
              imageIcon: Image.asset('assets/icons/family.png'),
              lable: 'طلبات الاضافة من الجمعيات',
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (_) => const RequestsList(
                      showDeleteRequests: false,
                    ),
                  ),
                );
              },
            ),
            ControlPanelButton(
              textStyle: textStyle,
              imageIcon: Image.asset('assets/icons/delete_icon.png'),
              lable: 'طلبات الحذف  من الجمعيات',
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (_) => const RequestsList(
                      showDeleteRequests: true,
                    ),
                  ),
                );
              },
            ),
            ControlPanelButton(
              textStyle: textStyle,
              imageIcon: Image.asset('assets/icons/delete_icon.png'),
              lable: 'حذف جمعية او فريق',
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (_) => const OrganizationsList(isAdmin: true),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ControlPanelButton extends StatelessWidget {
  final String lable;
  final Image imageIcon;
  final Function onPressed;
  const ControlPanelButton({
    @required this.lable,
    @required this.imageIcon,
    @required this.onPressed,
    @required this.textStyle,
  });

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
          ),
          color: const Color(0xFFA5D5EB).withOpacity(0.3),
        ),
        child: Row(
          children: <Widget>[
            imageIcon,
            const SizedBox(width: 5),
            Text(
              lable,
              style: textStyle,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
