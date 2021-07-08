import 'package:flutter/material.dart';
import 'package:lets_talk_money/screens/chat_screen.dart';
import 'package:lets_talk_money/screens/home.dart';
import 'package:lets_talk_money/screens/new_conversation.dart';
import 'package:lets_talk_money/screens/profile.dart';
import 'package:lets_talk_money/services/auth.dart';
import 'package:lets_talk_money/styles/colors.dart';

class Header extends StatelessWidget {
  const Header(this.heading);
  final String heading;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          heading,
          style: const TextStyle(fontSize: 24),
        ),
      );
}

class Paragraph extends StatelessWidget {
  const Paragraph(this.content);
  final String content;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          content,
          style: const TextStyle(fontSize: 18),
        ),
      );
}

class IconAndDetail extends StatelessWidget {
  const IconAndDetail(this.icon, this.detail);
  final IconData icon;
  final String detail;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(
              detail,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      );
}

class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).accentColor,
        ),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}

// PreferredSizeWidget myAppbar(String appBarTitle) {
//   return AppBar(
//     // backgroundColor: kPrimaryColor,
//     centerTitle: true,
//     title: Text(
//       appBarTitle,
//       // style: Theme.of(context)
//       //     .textTheme
//       //     .headline5
//       //     ?.copyWith(color: kOnPrimaryColor),
//     ),
//   );
// }

class StyledButton extends StatelessWidget {
  const StyledButton({required this.text, required this.onPressed});
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => MaterialButton(
        // elevation: buttonThemeElevation,
        shape: RoundedRectangleBorder(
            // borderRadius: BorderRadius.circular(buttonBorderRadius),
            ),
        // child: Text(text),
        child: Text(text, style: Theme.of(context).textTheme.button),
        // ?.copyWith(color: kOnButtonColor)),
        color: kButtonColor,
        onPressed: onPressed,
      );
}

class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments as ChatScreen;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.convoID),
      ),
      body: Center(
        child: Text(args.convoID),
      ),
    );
  }
}

Widget customDrawer(BuildContext context) {
  return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.

      child: ListView(

          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Text(
            'Quick Actions',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
        ListTile(
          title: Text('Settings'),
          leading: Icon(
            Icons.settings,
            // color: kPrimaryColor,
          ),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            // Navigator.pop(context);
            // Navigator.pushNamed(context, SettingsPage.routeName);
          },
        ),
        ListTile(
            title: Text('Profile'),
            leading: Icon(
              Icons.face,
              // color: kPrimaryColor,
            ),
            onTap: () {
              Navigator.pushNamed(context, Profile.routeName);
              // Update the state of the app
              // ...
              // Then close the drawer
              // Navigator.pop(context);
              // Navigator.pushNamed(context, Profile.routeName);
            }),
        ListTile(
            title: Text('Home'),
            leading: Icon(
              Icons.home,
              // color: kPrimaryColor,
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              // Navigator.pop(context);
              // Navigator.pushNamed(context, Home.routeName);
            }),
        ListTile(
            title: Text('Logout'),
            leading: Icon(
              Icons.logout,
              // color: kPrimaryColor,
            ),
            onTap: () {
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //     Welcome.routeName, (Route<dynamic> route) => false);
            })
      ]));
}

PreferredSizeWidget customAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(
      title,
      key: const Key('appbar'),
    ),
    centerTitle: true,
    actions: [
      IconButton(
        onPressed: () => createDummyMessage(
            "oYwXPIfUFjfDyABGIgXkzdzsYkr2", "O9uAX7fwujV63IVJeWGG84TPxjv1"),
        icon: Icon(Icons.mail),
      ),
      IconButton(onPressed: AuthService().signOut, icon: Icon(Icons.logout)),
      IconButton(
          // onPressed: () => createNewConvo(context),
          onPressed: () =>
              Navigator.pushNamed(context, NewConversation.routeName),
          icon: Icon(
            Icons.add,
            size: 30,
          ))
    ],
  );
}
