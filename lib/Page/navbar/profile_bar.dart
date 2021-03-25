import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // ignore: missing_return
  Future<String> _getAPI() async {
    var url = Uri.https(
        'https://newsapi.org',
        '/v2/everything?q=Apple&from=2021-03-22&sortBy=popularity&apiKey=463f3c8b3f8e406dbcd258313907a03f',
        {'q': '{http}'});
    http.Response response = await http.get(url);
    print(response.body);
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
