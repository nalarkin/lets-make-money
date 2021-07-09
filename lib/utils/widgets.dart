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

class StyledButton extends StatelessWidget {
  const StyledButton({required this.text, required this.onPressed});
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => MaterialButton(
        shape: RoundedRectangleBorder(),
        child: Text(text, style: Theme.of(context).textTheme.button),
        color: kButtonColor,
        onPressed: onPressed,
      );
}

class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
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
      key: const Key('drawer'),
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
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
          ),
          onTap: () {},
        ),
        ListTile(
            title: Text(
              'Profile',
              key: const Key('drawerProfileButton'),
            ),
            leading: Icon(
              Icons.face,
            ),
            onTap: () {
              Navigator.pushNamed(context, Profile.routeName);
            }),
        ListTile(
            title: Text('Home'),
            leading: Icon(
              Icons.home,
            ),
            onTap: () {}),
        ListTile(
            title: Text('Logout'),
            leading: Icon(
              Icons.logout,
            ),
            onTap: () {}),
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
          onPressed: () => Navigator.pushNamed(context, Profile.routeName),
          icon: Icon(
            Icons.face,
            size: 30,
            key: const Key("profileButton"),
          )),
      IconButton(
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              Home.routeName, (Route<dynamic> route) => false),
          icon: Icon(
            Icons.home,
            size: 30,
            key: const Key("homeButton"),
          )),
      IconButton(
          onPressed: () =>
              Navigator.pushNamed(context, NewConversation.routeName),
          icon: Icon(
            Icons.add,
            size: 30,
            key: const Key("addMessageButton"),
          )),
    ],
  );
}
