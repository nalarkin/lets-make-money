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
}
