# Lets Talk Money



`https://github.com/nalarkin/lets-make-money.git`

link to website: https://github.com/nalarkin/lets-make-money

## Author:

* Nathan Larkin

## How to run the App:

1. Have all requirements downloaded
2. copy dependencies in `pubspec.yaml` file.
3. In CLI, type`flutter pub get` to install required plugins that were listed in the new `pubspec.yaml file`
4. You can run both android and chrome through the VS code browser.

## Build ID: 

`nlarkin.lets_talk_money`

## Requirements:

* flutter 2.0+ is downloaded and installed
* files that were edited within `android/app/scr/main/res/  (necessary for splash screen)
* update contents in `android/app/src/AndroidManifest.xml`
* have all files in `/lib` downloaded
* Android SDK >= 21
* compatible on Android and Web (Chrome OS)

## Web app specific requirements:

* download and copy the contents within the `/web/` folder. The most important are the contents of the `index.html`file.


## You-tube Playlist of examples.

* https://youtube.com/playlist?list=PLpRmUT5wCbFkXV725sRB1u6JoOIZClfvV

## Areas of Improvement

I would have found an alternative way to give the web version ads if I knew that admob was incompatible sooner. I also think I spent too much time on developing a new app, instead of just reusing the old one.

## Troubleshooting issues

* Clone the entire repository instead of copying certain files
* try `flutter clean` then `flutter pub get`
* admob ads are not compatible with web version
* install the plugins by doing `flutter get <addon>`, this was how I installed my addons. So it could have changed some config code somewhere in the project that I was unaware of.
* Web app issue, make sure you are using local host 8887 as this is the only client id authorized.

## Image of the way the Messages are stored in Firestore

<a href="https://i.imgur.com/knAobJz.png">https://i.imgur.com/knAobJz.png</a>

## Integrated Testing

* To do an integrated test on android, run the following command: `flutter drive --target=test_driver/app.dart`

