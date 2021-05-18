
import 'package:flutter/material.dart';
import 'package:visab_admin/ui/widgets/bottom_button.dart';
import 'package:visab_admin/util/const_ui_group.dart';

class GuideDetailUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Center(child: Text(
          'Profile',
          style: TextStyle(
            fontSize: 40.0,
          ),
        )),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget> [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: CircleAvatar(
                    radius: 80.0,
                    backgroundImage: AssetImage('images/meno.jpg'),
                  ),
                ),
                Text(
                  'Zeleke Gessesse',
                  style: kProfileNameStyle,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'A tour-guide with the experience of such and such... '
                      'All the details related to this specific tour-guide will be'
                      ' displayed here' ,
                  style: kTourGuideDetailTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 50.0,
                  width: 150.0,
                  child: Divider(
                    color: Colors.blueGrey[900],
                    thickness: 2,
                  ),
                ),

                Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 10.0,
                      horizontal: 10.0),
                  child: ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Colors.teal,
                      ),
                      title: Text(
                        '+251900000000',
                        style: kPhoneEmailTextStyle,
                      )
                  ),
                ),
                Card(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 10.0,
                        horizontal: 10.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Colors.teal,
                      ),
                      title: Text(
                        'ZelekeGessesse@gmail.com',
                        style:  kPhoneEmailTextStyle,
                      ),
                    )),
                Card(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 10.0,
                        horizontal: 10.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.location_city,
                        color: Colors.teal,
                      ),
                      title: Text(
                        'Addis Ababa, 4-killo',
                        style:  kPhoneEmailTextStyle,
                      ),
                    )),
                BottomButton(
                  buttonTitle: 'Contact me',
                  onTap: () {
                    print('the user may get the contacts');
                  },
                )
              ],
            )),
      ),
    );
  }
}