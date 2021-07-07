import 'package:flutter/material.dart';
import 'package:lets_talk_money/screens/chat_screen.dart';
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


PreferredSizeWidget myAppbar(String appBarTitle) {
  return AppBar(
    // backgroundColor: kPrimaryColor,
    title: Text(
      appBarTitle,
      // style: Theme.of(context)
      //     .textTheme
      //     .headline5
      //     ?.copyWith(color: kOnPrimaryColor),
    ),
  );
}

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