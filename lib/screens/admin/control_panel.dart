import 'package:attayairaq/consts/consts.dart';
import 'package:attayairaq/screens/admin/organisations_list.dart';
import 'package:attayairaq/screens/shared/add_family.dart';
import 'package:flutter/material.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: 18,
      fontFamily: 'Changa',
      fontWeight: FontWeight.bold,
      color: deepTxtBlue,
    );
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.all(20),
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
                  MaterialPageRoute(
                    builder: (_) => AddFamily(isAdmin: true,),
                  ),
                );
              },
            ),
            ControlPanelButton(
              textStyle: textStyle,
              imageIcon: Image.asset('assets/icons/delete_icon.png'),
              lable: 'حذف عائلة',
              onPressed: () {},
            ),
            ControlPanelButton(
              textStyle: textStyle,
              imageIcon: Image.asset('assets/icons/family.png'),
              lable: 'طلبات الاضافة من الجمعيات',
              onPressed: () {},
            ),
            ControlPanelButton(
              textStyle: textStyle,
              imageIcon: Image.asset('assets/icons/delete_icon.png'),
              lable: 'طلبات الحذف  من الجمعيات',
              onPressed: () {},
            ),
            ControlPanelButton(
              textStyle: textStyle,
              imageIcon: Image.asset('assets/icons/delete_icon.png'),
              lable: 'حذف جمعية او فريق',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => OrganizationsList(),
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
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
            ),
            color: Color(0xFFA5D5EB).withOpacity(0.3),
          ),
          child: Row(
            children: <Widget>[
              imageIcon,
              SizedBox(
                width: 5,
              ),
              Text(
                lable,
                style: textStyle,
                textAlign: TextAlign.start,
              ),
            ],
          )),
    );
  }
}
