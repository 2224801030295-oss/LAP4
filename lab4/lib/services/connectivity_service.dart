import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Future<bool> isOnline() async {
    final result = await _connectivity.checkConnectivity();
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi;
  }

  Stream<bool> get onConnectivityChanged async* {
    await for (final state in _connectivity.onConnectivityChanged) {
      yield state == ConnectivityResult.mobile ||
          state == ConnectivityResult.wifi;
    }
  }
}
