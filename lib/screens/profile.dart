// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:lets_talk_money/utils/widgets.dart';
// import 'package:provider/provider.dart';

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
//       appBar: AppBar(),
      
//       body: SafeArea(
//         left: true,
//         right: true,
//         bottom: true,
//         top: true,
//         minimum: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//         child: Column(children: <Widget>[
//           Card(
//               margin: EdgeInsets.all(10.0),
//               borderOnForeground: false,
//               elevation: 0,
//               child: ListTile(
//                 leading: Icon(
//                   Icons.face,
//                   size: 56.0,
//                   color: kPrimaryColor,
//                 ),
//                 tileColor: kBackgroundColor,
//                 title: Text(
//                   "username: $_currentUsername",
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyText1
//                       ?.copyWith(color: kPrimaryColor),
//                 ),
//               )),
//           Flexible(
//             child: SizedBox(
//               height: 40,
//             ),
//           ),
//           Flexible(
//             child: Text(
//               "Connected Socials",
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyText1
//                   ?.copyWith(color: kPrimaryColor),
//             ),
//           ),
//           // SizedBox(
//           //   height: 20,
//           // ),
//           Card(
//               margin: EdgeInsets.all(5.0),
//               child: ListTile(
//                 leading: Icon(
//                   Icons.facebook,
//                   size: 56.0,
//                   color: Colors.white,
//                 ),
//                 tileColor: kPrimaryColor,
//                 title: Text(
//                   'Facebook Account',
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyText1
//                       ?.copyWith(color: Colors.white),
//                 ),
//                 onTap: () async {
//                   if (_facebookLink.isNotEmpty) {
//                     await canLaunch(_facebookLink)
//                         ? await launch(_facebookLink)
//                         : throw 'Could not launch $_facebookLink';
//                   }
//                 },
//                 subtitle: _facebookLink.isEmpty
//                     ? Text(
//                         "No Facebook link available.",
//                         style: Theme.of(context)
//                             .textTheme
//                             .caption
//                             ?.copyWith(color: Colors.white),
//                       )
//                     : (Text(
//                         "$_facebookLink",
//                         style: Theme.of(context)
//                             .textTheme
//                             .caption
//                             ?.copyWith(color: Colors.white),
//                       )),
//               )),
//           Card(
//               margin: EdgeInsets.all(5.0),
//               child: ListTile(
//                 leading: Icon(
//                   Icons.camera_alt_outlined,
//                   size: 56.0,
//                   color: Colors.white,
//                 ),
//                 tileColor: kPrimaryColor,
//                 title: Text(
//                   'Instagram Account',
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyText1
//                       ?.copyWith(color: Colors.white),
//                 ),
//                 onTap: () async {
//                   if (_instagramLink.isNotEmpty) {
//                     await canLaunch(_instagramLink)
//                         ? await launch(_instagramLink)
//                         : throw 'Could not launch $_instagramLink';
//                   }
//                 },
//                 subtitle: _instagramLink.isEmpty
//                     ? Text(
//                         "No Instagram link available.",
//                         style: Theme.of(context)
//                             .textTheme
//                             .caption
//                             ?.copyWith(color: Colors.white),
//                       )
//                     : (Text(
//                         "$_instagramLink",
//                         style: Theme.of(context)
//                             .textTheme
//                             .caption
//                             ?.copyWith(color: Colors.white),
//                       )),
//               )),
//           Flexible(
//             child: SizedBox(
//               height: 80,
//             ),
//           ),
//           StyledButton(
//               text: "Update username",
//               onPressed: () =>
//                   Navigator.pushNamed(context, ResetUsernameScreen.routeName)),
//           // Expanded(child: Container(),),
//           roomButtons(context),
//           SizedBox(
//             height: 20,
//           ),
//         ]),
//         // ),
//       ),
//       drawer: memoDrawer(context),
//     );
//   }
// }
