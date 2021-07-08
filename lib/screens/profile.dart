import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_talk_money/utils/widgets.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  static final String routeName = '/profile';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    User? currUser = Provider.of<User?>(context);
    return Scaffold(
      appBar: customAppBar(context, "Profile"),
      drawer: customDrawer(context),
    );
  }
}
