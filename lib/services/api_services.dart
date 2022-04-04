import 'dart:convert' as convert;
import 'package:abdulaziz_flutter/models/Bix.dart';
import 'package:abdulaziz_flutter/models/Building.dart';
import 'package:abdulaziz_flutter/models/User_Type.dart';
import 'package:abdulaziz_flutter/models/user.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  String urlOrigin = 'localhost:44340';
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': '*',
    'Access-Control-Allow-Headers': '*',
  };

  Future deleteBuild(int ind) async {
    var url = Uri.http(urlOrigin, '/api/Builds/' + ind.toString());
    try {
      var response = await http.delete(
        url,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': '*',
          'Access-Control-Allow-Headers': '*',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = convert.jsonDecode(response.body) as String;
        return jsonResponse;

        // var itemCount = jsonResponse['totalItems'];
        // print('Number of books about http: $itemCount.');
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return 'Request failed with status: ${response.statusCode}.';
      }
    } catch (e) {
      print(e);
      return "Error: " + e.toString();
    }
  }

  Future editBuild(Building build) async {
    var url = Uri.http(urlOrigin, '/api/Builds/' + build.ind.toString());
    try {
      var response = await http.put(
        url,
        body: convert.jsonEncode(build.toJson()),
        headers: header,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        return jsonResponse;
      } else {
        return 'Error Code: ' + response.statusCode.toString();
      }
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }

  Future putBuild(Building build) async {
    var url = Uri.http(urlOrigin, '/api/Builds');
    try {
      var response = await http.post(
        url,
        body: convert.jsonEncode(build.toJson()),
        headers: header,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        return jsonResponse;
      } else {
        return 'Error Code: ' + response.statusCode.toString();
      }
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }

  Future getUser(String username, String passwrod) async {
    var url = Uri.http(urlOrigin, '/api/Users/' + username + '/' + passwrod);
    try {
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = convert.jsonDecode(response.body) as String;
        return jsonResponse;

        // var itemCount = jsonResponse['totalItems'];
        // print('Number of books about http: $itemCount.');
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return 'Request failed with status: ${response.statusCode}.';
      }
    } catch (e) {
      print(e);
      return "Error: " + e.toString();
    }
  }

  Future deleteUser(int ind) async {
    var url = Uri.http(urlOrigin, '/api/Users/' + ind.toString());
    try {
      var response = await http.delete(
        url,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': '*',
          'Access-Control-Allow-Headers': '*',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = convert.jsonDecode(response.body) as String;
        return jsonResponse;

        // var itemCount = jsonResponse['totalItems'];
        // print('Number of books about http: $itemCount.');
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return 'Request failed with status: ${response.statusCode}.';
      }
    } catch (e) {
      print(e);
      return "Error: " + e.toString();
    }
  }

  Future deleteBix(int ind) async {
    var url = Uri.http(urlOrigin, '/api/bixes/' + ind.toString());
    try {
      var response = await http.delete(
        url,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': '*',
          'Access-Control-Allow-Headers': '*',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = convert.jsonDecode(response.body) as String;
        return jsonResponse;

        // var itemCount = jsonResponse['totalItems'];
        // print('Number of books about http: $itemCount.');
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return 'Request failed with status: ${response.statusCode}.';
      }
    } catch (e) {
      print(e);
      return "Error: " + e.toString();
    }
  }

  Future getAllBixes() async {
    var url = Uri.http(urlOrigin, '/api/bixes');
    try {
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
        return jsonResponse;

        // var itemCount = jsonResponse['totalItems'];
        // print('Number of books about http: $itemCount.');
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return 'Request failed with status: ${response.statusCode}.';
      }
    } catch (e) {
      print(e);
      return "Error: " + e.toString();
    }
  }

  Future getAllUsers() async {
    var url = Uri.http(urlOrigin, '/api/Users');
    try {
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
        return jsonResponse;

        // var itemCount = jsonResponse['totalItems'];
        // print('Number of books about http: $itemCount.');
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return 'Request failed with status: ${response.statusCode}.';
      }
    } catch (e) {
      print(e);
      return "Error: " + e.toString();
    }
  }

  Future getUserTypes() async {
    var url = Uri.http(urlOrigin, '/api/UserTypes');
    try {
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
        return jsonResponse;

        // var itemCount = jsonResponse['totalItems'];
        // print('Number of books about http: $itemCount.');
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return 'Request failed with status: ${response.statusCode}.';
      }
    } catch (e) {
      print(e);
      return "Error: " + e.toString();
    }
  }

  Future getBixesBuilds() async {
    var url = Uri.http(urlOrigin, '/api/Builds');
    try {
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
        return jsonResponse;

        // var itemCount = jsonResponse['totalItems'];
        // print('Number of books about http: $itemCount.');
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return 'Request failed with status: ${response.statusCode}.';
      }
    } catch (e) {
      print(e);
      return "Error: " + e.toString();
    }
  }

  Future putUser(User user) async {
    var url = Uri.http(urlOrigin, '/api/Users');
    try {
      var response = await http.post(
        url,
        body: convert.jsonEncode(user.toJson()),
        headers: header,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        return jsonResponse;
      } else {
        return 'Error Code: ' + response.statusCode.toString();
      }
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }

  Future putBix(Bix user) async {
    var url = Uri.http(urlOrigin, '/api/bixes');
    try {
      var response = await http.post(
        url,
        body: convert.jsonEncode(user.toJson()),
        headers: header,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        return jsonResponse;
      } else {
        return 'Error Code: ' + response.statusCode.toString();
      }
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }

  Future putBuilding(Building user) async {
    var url = Uri.http(urlOrigin, '/api/Build');
    try {
      var response = await http.post(
        url,
        body: convert.jsonEncode(user.toJson()),
        headers: header,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        return jsonResponse;
      } else {
        return 'Error Code: ' + response.statusCode.toString();
      }
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }

  Future putUserType(User_Type userType) async {
    var url = Uri.http(urlOrigin, '/api/User_Type');
    try {
      var response = await http.post(
        url,
        body: convert.jsonEncode(userType.toJson()),
        headers: header,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return 'Succesful';
      } else {
        return 'Error Code: ' + response.statusCode.toString();
      }
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }

  Future editUser(User user) async {
    var url = Uri.http(urlOrigin, '/api/Users/' + user.id.toString());
    try {
      var response = await http.put(
        url,
        body: convert.jsonEncode(user.toJson()),
        headers: header,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return 'Succesful';
      } else {
        return 'Error Code: ' + response.statusCode.toString();
      }
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }

  Future editBix(Bix user) async {
    var url = Uri.http(urlOrigin, '/api/bixes/' + user.ind.toString());
    try {
      var response = await http.put(
        url,
        body: convert.jsonEncode(user.toJson()),
        headers: header,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return 'Succesful';
      } else {
        return 'Error Code: ' + response.statusCode.toString();
      }
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }

  Future editUserType(User_Type userType) async {
    var url = Uri.http(urlOrigin, '/api/User_Type/' + userType.ind.toString());
    try {
      var response = await http.put(
        url,
        body: convert.jsonEncode(userType.toJson()),
        headers: header,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return 'Succesful';
      } else {
        return 'Error Code: ' + response.statusCode.toString();
      }
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }
}
