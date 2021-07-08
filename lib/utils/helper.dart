import 'package:lets_talk_money/models/member.dart';

class HelperFunctions {
  // HelperFunctions();
  static String getConvoID(String userID, String peerID) {
    print("inside HelperFunction.getConvoID()");
    print("userID: $userID");
    print("peerID: $peerID");
    return userID.hashCode <= peerID.hashCode
        ? userID + '_' + peerID
        : peerID + '_' + userID;
  }

  static Map<String, Member> getMemberMap(List<Member> currMembersList) {
    Map<String, Member> _memberMap = {};
    for (Member curr in currMembersList) {
      _memberMap[curr.id] = curr;
    }
    return _memberMap;
  }
}
