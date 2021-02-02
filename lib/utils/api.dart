import 'package:dio/dio.dart';

class Api {
  static final Dio _dio = Dio();
  static String baseUrl = 'http://data.fixer.io/api/';
  static String apiKey = '67ba337bd7a67f574d3a185f3c30c91b';
  static String latestInitial = baseUrl + '/latest?access_key=' + apiKey;
  static String symbolsurl =
      "https://data.fixer.io/api/symbols?access_key=" + apiKey;

  static String flactuationData = baseUrl + '/fluctuation?access_key=' + apiKey;

  Future<Response> getInitialCurrency() {
    return _dio.get(latestInitial);
  }

  Future<Response> getFlactuationData(String startDate, String endDate) {
    return _dio.get(flactuationData +
        '& start_date = {$startDate} & end_date = {$endDate}');
  }

  Future<Response> getsymbolsCurrency() {
    return _dio.get(symbolsurl);
  }
}
