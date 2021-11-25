
import 'package:flutter/material.dart';
import 'package:memophobia/memeblock.dart';
import 'package:flutter/services.dart';

class MemePage extends StatefulWidget {
  const MemePage({Key? key}) : super(key: key);
  @override
  State<MemePage> createState() => _MemePageState();
}

class _MemePageState extends State<MemePage> {
  String addedText = "";
  String currentURL = "https:\/\/i.imgflip.com\/30b1gx.jpg";
  MemeBloc memeBloc = MemeBloc();
  bool showFetched = true;

  void addText(newText) {
    setState(() {
      addedText = newText;
    });
  }

  void copyImage(context) async {
    Image img = Image.network(currentURL);
    ClipboardData data = ClipboardData(text: currentURL);
    await Clipboard.setData(data);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Copied!"),
    ));
  }

  void setImage(url) {
    setState(() {
      currentURL = url;
    });
  }

  void setFetched(bool val) {
    setState(() {
      showFetched = val;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Text(
                'Your meme picture: ',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              height: 150,
              width: 150,
              child: showFetched
                  ? StreamBuilder(
                      stream: memeBloc.memeUrl,
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return Image.network(
                              (snapshot.data as Map)['url'].toString());
                        } else
                          return Image.network(
                              "data:image/jpeg;base64,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");
                      })
                  : StreamBuilder(
                      stream: memeBloc.signUrl,
                      builder: (context, snapshot) {
                        return Image.network(snapshot.data.toString());
                      }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: TextButton(
                onPressed: () {
                  memeBloc.newMeme.add(null);
                  setFetched(true);
                },
                child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(color: Colors.blue[100]),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Get next meme idea",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ),
            ),
            Container(
              width: 200,
              height: 150,
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: TextField(
                onChanged: (String value) {
                  if (value != "") {
                    addText(value);
                  }
                  ;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Think about signing next meme',
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: StreamBuilder(
                    stream: memeBloc.memeUrl,
                    builder: (context, snapshot) {
                      return TextButton(
                        onPressed: () {
                          if (snapshot.data != null) {

                          setImage((snapshot.data as Map)['url'].toString());
                            memeBloc.createMeme.add({
                              'id': (snapshot.data as Map)['id'],
                              'text': addedText
                            });

                            setFetched(false);
                          }
                        },
                        child: Container(
                            width: 200,
                            height: 25,
                            decoration: BoxDecoration(color: Colors.blue[100]),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Sign",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      );
                    })),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {copyImage(context)},
        tooltip: 'Increment',
        child: const Icon(Icons.copy),
      ),
    );
  }
}
