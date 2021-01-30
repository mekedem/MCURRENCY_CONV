import './api.dart';

class ControllerComponent {
  Api _api = Api();

  Future<Map<String, dynamic>> loadInitialData() async {
    final response = await _api.getInitialCurrency();
    final Map<String, dynamic> body = response.data;

    return body['rates'];
  }

  void flactuationData(String startDate, String endDate) async {
    final response = await _api.getFlactuationData(startDate, endDate);
    final Map<String, dynamic> body = response.data;

    print(body);

    // return body['rates'];
  }
}
