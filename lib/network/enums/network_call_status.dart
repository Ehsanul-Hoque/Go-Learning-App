enum NetworkCallStatus {
  none,
  noInternet,
  loading,
  success,
  cancelled,
  failed;

  static NetworkCallStatus combineInParallel(
    List<NetworkCallStatus?> statusList,
  ) {
    if (statusList.contains(null) || statusList.contains(none)) return none;
    if (statusList.contains(noInternet)) return noInternet;
    if (statusList.contains(cancelled)) return cancelled;
    if (statusList.contains(failed)) return failed;
    if (statusList.contains(loading)) return loading;
    return success;
  }

  static NetworkCallStatus combineInShuffledSerial(
    List<NetworkCallStatus?> statusList, {
    bool returnSuccessOnlyIfAllSuccess = false,
  }) {
    if (statusList.contains(noInternet)) return noInternet;
    if (statusList.contains(cancelled)) return cancelled;
    if (statusList.contains(failed)) return failed;
    if (statusList.contains(loading)) return loading;

    if (returnSuccessOnlyIfAllSuccess) {
      if (statusList.contains(null) || statusList.contains(none)) return none;
      return success;
    } else {
      if (statusList.contains(success)) return success;
      return none;
    }
  }
}
