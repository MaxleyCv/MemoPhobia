import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class MemeBloc {
  MemeBloc() {
    _memeGetController.stream.listen(_memeStreamFunc);
    _memePostController.stream.listen(_memeStreamSignFunc);
  }

  final _memeStream = BehaviorSubject<Map<String, String>>.seeded({});

  Stream get memeUrl => _memeStream.stream;
  Sink get _addValue => _memeStream.sink;

  StreamController _memeGetController = StreamController();
  StreamSink get newMeme => _memeGetController.sink;

  final _signStream = BehaviorSubject<String>.seeded("https:\/\/i.imgflip.com\/30b1gx.jpg");

  Stream get signUrl => _signStream.stream;
  Sink get _addSignValue => _signStream.sink;

  StreamController _memePostController = StreamController();
  StreamSink get createMeme => _memePostController.sink;

  void _memeStreamFunc(data) async {
    final client = http.Client();

    final res = await http.get(Uri.parse('https://api.imgflip.com/get_memes'));

    // Dear Ihor, on this spot I could write my own API to process randomness and host it on GCP,
    // although it's 3:47 AM and I have a daily scrum meet at 9

    Random rnd = new Random();
    var memesList = jsonDecode(res.body)["data"]["memes"];
    _addValue.add({
      'id': memesList[rnd.nextInt(memesList.length)]['id'].toString(),
      'url': memesList[rnd.nextInt(memesList.length)]['url'].toString()
    });
  }

  void _memeStreamSignFunc(data) async {
    final client = http.Client();

    final Map<String, String> payload = {
      'template_id': data['id'],
      'username': 'memophobia',
      'password': 'wellerman',
      'text0': '',
      'text1': data['text'],
    };
    print(payload);

    final res = await http.post(
      Uri.https('api.imgflip.com', '/caption_image', payload),
    );
    var p = jsonDecode(res.body).toString();
    print(p);
    var meme = jsonDecode(res.body)['data']['url'].toString();
    _addSignValue.add(meme);
  }

  void dispose() {
    _memeStream.close();
    _memeGetController.close();
  }
}
