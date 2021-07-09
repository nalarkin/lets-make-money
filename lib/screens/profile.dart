

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lets_talk_money/screens/reset_username.dart';
import 'package:lets_talk_money/utils/ad_helper.dart';
import 'package:lets_talk_money/utils/platform.dart';
import 'package:lets_talk_money/utils/widgets.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  static final String routeName = '/profile';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  bool android = PlatformFinder().isAndroid;
  
  late RewardedAd _rewardedAd;

  
  bool _isRewardedAdReady = false;

  @override
  void initState() {
    
    super.initState();
    if (android) {
      _loadRewardedAd();
    }
  }

  @override
  void dispose() {
    
    if (android) {
      _rewardedAd.dispose();
    }

    super.dispose();
  }

  
  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          this._rewardedAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                _isRewardedAdReady = false;
              });
              _loadRewardedAd();
            },
          );

          setState(() {
            _isRewardedAdReady = true;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
          setState(() {
            _isRewardedAdReady = false;
          });
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    User? currUser = Provider.of<User?>(context);
    return Scaffold(
      appBar: customAppBar(context, "Profile"),
      drawer: customDrawer(context),
      body: Column(
        children: [
          
          
          
          Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  
                  child: ListTile(
                    
                    leading: Icon(
                      Icons.face,
                      size: 60,
                    ),
                  ),
                ),
                
                
                
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
                  child: Text(
                    "${currUser?.displayName}",
                    key: const ValueKey("profileUsername"),
                  ),
                )

                
                
              ],
            ),
            
            
            
            
          ),
          
          
          
          
          
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget? _buildFloatingActionButton() {
    
    return (_isRewardedAdReady)
        ? FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Want to change username?'),
                    content: Text('Watch an Ad and change your username!'),
                    actions: [
                      TextButton(
                        child: Text('cancel'.toUpperCase()),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text('ok'.toUpperCase()),
                        onPressed: () {
                          
                          _rewardedAd.show(onUserEarnedReward: (_, reward) {
                            Navigator.pushNamed(
                                context, ResetUsername.routeName);
                          });
                        },
                      ),
                    ],
                  );
                },
              );
            },
            label: Text('Change Username?'),
            icon: Icon(Icons.card_giftcard),
          )
        : null;
  }
}































































