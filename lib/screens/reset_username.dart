import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lets_talk_money/screens/profile.dart';
import 'package:lets_talk_money/services/database.dart';
import 'package:lets_talk_money/utils/input_decoration.dart';
import 'package:lets_talk_money/utils/widgets.dart';
import 'package:provider/provider.dart';

class ResetUsername extends StatefulWidget {
  const ResetUsername({Key? key}) : super(key: key);
  static final String routeName = '/reset_username';
  @override
  _ResetUsernameState createState() => _ResetUsernameState();
}

class _ResetUsernameState extends State<ResetUsername> {
  String _username = '';
  final auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    DatabaseService _db = Provider.of<DatabaseService>(context, listen: false);

    User? currUser = Provider.of<User?>(context);
    return _isLoading
        ? LoadingCircle()
        : Scaffold(
            appBar: customAppBar(context, "Update Username"),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                    child: Column(children: <Widget>[
                  SizedBox(height: 15.0),
                  TextFormField(
                      // style: Theme.of(context)
                      //     .textTheme
                      //     .bodyText1
                      //     ?.copyWith(color: kTextColor),
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Username'),
                      validator: (val) {
                        if (val != null) {
                          if (val.isEmpty) {
                            return "Enter a username";
                          } else if (val.length > 18) {
                            return "Max username length is 18 characters.";
                          }
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() => _username = val);
                      }),
                  SizedBox(height: 15.0),
                  Text(
                    "$error",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(color: Theme.of(context).errorColor),
                  ),
                  MaterialButton(
                      
                      child: Text('Update Username',
                          style: Theme.of(context)
                              .textTheme
                              .button),
                              
                      onPressed: () async {
                        setState(() => _isLoading = true);
                        if (_username.isEmpty) {
                          setState(() {
                            _isLoading = false;
                            error = "username is empty";
                          });
                        } else if (_username.length > 18) {
                          setState(() {
                            _isLoading = false;
                            error = "longer than 18 characters";
                          });
                        } else {
                          await _db.updateUsername(currUser, _username);
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.pushNamed(context, Profile.routeName);
                        }
                      }),
                ]))));
  }
}
