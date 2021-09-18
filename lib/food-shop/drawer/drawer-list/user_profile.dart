import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // ignore: missing_return
  Future<String> _getAPI() async {
    Uri url = Uri.https(
        'https://newsapi.org',
        '/v2/everything?q=Apple&from=2021-03-22&sortBy=popularity&apiKey=463f3c8b3f8e406dbcd258313907a03f',
        {'q': '{http}'});
    http.Response response = await http.get(url);
    print(response.body);
    return "fetch data success";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('dsaopdas'),
        ),
        body: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
          onPressed: () {
            _getAPI();
          },
          child: Text('dlspadls'),
        ),
      ),
    );
  }
}
