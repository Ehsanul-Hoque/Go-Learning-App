enum NetworkCallStatus {
  none,
  noInternet,
  loading,
  success,
  failed;

  static NetworkCallStatus combine(List<NetworkCallStatus?> statusList) {
    if (statusList.contains(null) || statusList.contains(none)) return none;
    if (statusList.contains(noInternet)) return noInternet;
    if (statusList.contains(failed)) return failed;
    if (statusList.contains(loading)) return loading;
    return success;
  }
}
