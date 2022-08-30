import 'package:flutter/material.dart';
import 'package:ong_nft/test/album.dart';
import 'package:ong_nft/test/album_stream_controller.dart';

class StreamPage extends StatefulWidget {
  const StreamPage({Key? key}) : super(key: key);

  @override
  State<StreamPage> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  final AlbumStreamController _streamController = AlbumStreamController();

  @override
  void initState() {
    super.initState();
    _streamController.combineStream.listen((values){
      debugPrint("listener: ${values.first}, ${values.second}");
    });
  }
  @override
  void dispose() {
    _streamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rxdart test"),
      ),
      body: Center(
        child: StreamBuilder<Pair<List<Album>, bool>>(
          stream: _streamController.combineStream,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("No data yet");
            }
            if (snapshot.hasError) {
              return const Text("Error");
            }
            if (snapshot.hasData) {
              return Text("${snapshot.data!.first}, ${snapshot.data!.second}");
            }
            return const Text("");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _streamController.toggle();
        },
        child: const Icon(Icons.swap_calls),
      ),
    );
  }
}
