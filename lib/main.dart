import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lets_talk_money/screens/home.dart';
import 'package:lets_talk_money/utils/widgets.dart';

import 'package:provider/provider.dart';

import 'models/Member.dart';

void main() {
  // This needs to be called before any Firebase services can be used
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppToInitializeFirebase());
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [AppToInitializeFirebase] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class AppToInitializeFirebase extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppToInitializeFirebaseState createState() =>
      _AppToInitializeFirebaseState();
}

class _AppToInitializeFirebaseState extends State<AppToInitializeFirebase> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          // return SomethingWentWrong();
          return Text(
              "Error ocurred in main.dart when calling Firebase.initializeApp()");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyMaterialApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return LoadingCircle();
      },
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: Provider.of<AuthService>(context, listen: false).firstLogin(),
//         builder: (context, AsyncSnapshot<User?> snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.error != null) {
//               print("error");
//               return Text(snapshot.error.toString());
//             }
//             print("main.dart: snaphshot.data=${snapshot.data}");
//             return MyMaterialApp(snapshot.data, snapshot.hasData);
//           } else {
//             return LoadingCircle();
//           }
//         });
//   }
// }

class MyMaterialApp extends StatefulWidget {
  // final User? currUser;
  // final bool hasData;
  // MyMaterialApp(this.currUser, this.hasData);

  @override
  // _MyMaterialAppState createState() => _MyMaterialAppState(currUser, hasData);
  _MyMaterialAppState createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp> {
  // final User? currUser;
  // final bool hasData;
  // MemberBloc bloc = MemberBloc();
  // _MyMaterialAppState(this.currUser, this.hasData);

  // @override
  // void dispose() {
  //   bloc.dispose();
  //   super.dispose();
  // }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return
        // MultiProvider(
        //   providers: [
        //     // StreamProvider<User? >.value(
        //     //   value: bloc.memberStream,
        //     //   initialData: Member(),
        //     // ),
        //   ],
        //   child:
        MaterialApp(
            title: 'Nathan',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: Home(),

            // To navigate to another page enter type the command:
            // Navigator.pushNamed(context, <ClassWithRouteName>.routeName);
            // example: Navigator.pushNamed(context, Register.routeName);
            routes: <String, WidgetBuilder>{
          Home.routeName: (context) => Home(),
        });
    // );
  }
}
