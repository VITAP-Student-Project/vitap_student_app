import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

const String URL = "https://hfw.vitap.ac.in:8090/httpclient.html";
const int LOGIN = 191;
const int LOGOUT = 193;
const int WEB = 0;
const int IOS = 1;
const int ANDROID = 2;

Future<String> login(String username, String password,
    {int producttype = WEB}) async {
  try {
    if (username.length < 6) {
      return "Username too short";
    }
    if (password.length < 6) {
      return "Password too short";
    }

    int timestamp = DateTime.now().millisecondsSinceEpoch;

    Map<String, dynamic> data = {
      "mode": LOGIN,
      "username": username,
      "password": password,
      "a": timestamp,
      "producttype": producttype,
    };

    // Make the POST request
    http.Response response = await http.post(
      Uri.parse(URL),
      body: data,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
      },
    );

    // Parse the XML response
    var document = xml.XmlDocument.parse(response.body);
    var messageElement = document.findAllElements('message').first;

    String message = messageElement.innerText;
    if (message.contains("You are signed in as")) {
      return "You are signed in as $username";
    } else {
      return message;
    }
  } catch (e) {
    if (e.toString().contains("HandshakeException")) {
      return "Login Failed\nMake sure you are connected\nto hostel Wi-Fi";
    }
    return "Error: $e";
  }
}

Future<String> logout(String username, String password,
    {int producttype = WEB}) async {
  try {
    if (username.length < 6) {
      return "Username too short";
    }
    if (password.length < 6) {
      return "Password too short";
    }

    int timestamp = DateTime.now().millisecondsSinceEpoch;

    Map<String, dynamic> data = {
      "mode": LOGOUT,
      "username": username,
      "password": password,
      "a": timestamp,
      "producttype": producttype,
    };

    // Make the POST request
    http.Response response = await http.post(
      Uri.parse(URL),
      body: data,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
      },
    );

    // Parse the XML response
    var document = xml.XmlDocument.parse(response.body);
    var messageElement = document.findAllElements('message').first;

    String message = messageElement.innerText;
    if (message.contains("signed out")) {
      return "Successfully Signed Out";
    } else {
      return "Signout failed. Please Sign-in first to Sign out.";
    }
  } catch (e) {
    if (e.toString().contains("HandshakeException")) {
      return "Logout Failed\nMake sure you are connected\nto hostel Wi-Fi";
    }
    return "Error: $e";
  }
}
