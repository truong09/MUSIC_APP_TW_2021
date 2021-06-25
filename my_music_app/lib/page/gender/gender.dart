import 'package:flutter/material.dart';
import 'package:my_music_app/core/search_album.dart';
import 'package:my_music_app/model/service/song_service.dart';

import 'package:my_music_app/page/gender/gender_detail.dart';

class GenderPage extends StatefulWidget {
  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  List<String> genderName = [];
  List<String> temp = [];
  String word;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Thể loại",
            style: TextStyle(color: Colors.blue),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Tìm theo tên thể loại",
                  prefixIcon: Icon(Icons.search),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    word = value;
                  });
                },
              ),
            ),
            Expanded(
              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                  future: SongService().getGenrderName(),
                  builder: (context, snapshot) {
                    print(snapshot.data.toString());
                    if (snapshot.hasData) {
                      temp = snapshot.data;
                      genderName = findGender(word, temp);
                      return ListView.builder(
                        itemCount: genderName.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(genderName[index]),
                            onTap: () {
                              print("${genderName[index]}a");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GenderDetail(
                                      genderName: genderName[index],
                                    ),
                                  ));
                            },
                          );
                        },
                      );
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),

              // Positioned(
              //   child: MiniBar(),
              //   bottom: 0,
              //   right: 0,
              //   left: 0,
              // ),
            ),
          ]),
        ),
      ),
    );
  }
}
