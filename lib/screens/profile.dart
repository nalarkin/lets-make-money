import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_talk_money/screens/reset_username.dart';
import 'package:lets_talk_money/utils/widgets.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  static final String routeName = '/profile';

  Widget build(BuildContext context) {
    User? currUser = Provider.of<User?>(context);
    return Scaffold(
      appBar: customAppBar(context, "Profile"),
      drawer: customDrawer(context),
      body: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.fromLTRB(10, 60, 10, 40),
          // child:
          Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  // color: Colors.blue,
                  child: ListTile(
                    // minVerticalPadding: 30,
                    leading: Icon(
                      Icons.face,
                      size: 60,
                    ),
                  ),
                ),
                // Container(
                // color: Colors.red,
                // child:
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
                  child: Text("${currUser?.displayName}"),
                )

                //   ),
                //   Text("${currUser?.displayName}"),
              ],
            ),
            //     ),
            //     ),
            //   ],
            // ),
          ),
          StyledButton(
              text: "Update username",
              onPressed: () =>
                  Navigator.pushNamed(context, ResetUsername.routeName)),
          // )
        ],
      ),
    );
  }
}


// class Profile extends StatefulWidget {
//   const Profile({Key? key}) : super(key: key);
//   static final String routeName = '/profile';

//   @override
//   _ProfileState createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   @override
//   Widget build(BuildContext context) {
//     User? currUser = Provider.of<User?>(context);
//     return Scaffold(
//       appBar: customAppBar(context, "Profile"),
//       drawer: customDrawer(context),
//       body: Column(
//         children: [
//           // Padding(
//           //   padding: EdgeInsets.fromLTRB(10, 60, 10, 40),
//           // child:
//           Card(
//             margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   // color: Colors.blue,
//                   child: ListTile(
//                     // minVerticalPadding: 30,
//                     leading: Icon(
//                       Icons.face,
//                       size: 60,
//                     ),
//                   ),
//                 ),
//                 // Container(
//                 // color: Colors.red,
//                 // child:
//                 Container(
//                   alignment: Alignment.center,
//                   margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
//                   child: Text("${currUser?.displayName}"),
//                 )

//                 //   ),
//                 //   Text("${currUser?.displayName}"),
//               ],
//             ),
//             //     ),
//             //     ),
//             //   ],
//             // ),
//           ),
//           // )
//         ],
//       ),
//     );
//   }
// }
