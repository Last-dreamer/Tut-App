import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl extends NetworkInfo {
  final DataConnectionChecker _dataConnectionChecker;
  NetworkInfoImpl(this._dataConnectionChecker);
  @override
  Future<bool> get isConnected => _dataConnectionChecker.hasConnection;
}