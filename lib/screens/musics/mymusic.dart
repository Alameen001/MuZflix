import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music1/function/function.dart';
import 'package:music1/screens/nowplay.dart';
import 'package:music1/screens/playlist/playlist.dart';
import 'package:music1/serch.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:permission_handler/permission_handler.dart';

class musicscreen extends StatefulWidget {
  const musicscreen({Key? key}) : super(key: key);

  @override
  State<musicscreen> createState() => _musicscreenState();
}

final audioquery = OnAudioQuery();
List<SongModel> allSongs = [];
List<Audio> songDetails = [];

class _musicscreenState extends State<musicscreen> {
  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() async {
    Permission.storage.request();
    allSongs = await audioquery.querySongs();
    for (var i in allSongs) {
      songDetails.add(Audio.file(i.uri.toString(),
          metas: Metas(
              title: i.title,
              artist: i.artist,
              id: i.id.toString(),
              album: i.album)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: SettingsScreen(),

//===========AppBar===============//

        appBar: AppBar(
          // leading: IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.arrow_back,
          //       color: Colors.yellow,
          //     )),
          backgroundColor: Colors.black,
          title: Text(
            'My Music',
            // style: TextStyle(
            //     color: Color.fromARGB(255, 233, 217, 72),
            //     fontWeight: FontWeight.w600,
            //     fontSize: 30,
            //     fontStyle: FontStyle.italic),
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(onPressed: () {
                  showSearch(
                  context: context,
                  delegate: deligatesearch(),
                );
              }, icon: Icon(Icons.search)),
            )
          ],
          centerTitle: true,
        ),
        body: FutureBuilder<List<SongModel>>(
            future: audioquery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true,
            ),
            builder: (context, item) {
              if (item.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (item.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No Songs to Display',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return Container(
                decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(18), topRight: Radius.circular(18)),
                  // color: Colors.grey[200],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black,
                      Color.fromARGB(255, 158, 48, 48),
                      Colors.black,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ListView.separated(
                    itemCount: item.data!.length,
                    itemBuilder: (context, index) => Slidable(
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              audioRoom.addTo(
                                RoomType.FAVORITES, // Specify the room type
                                allSongs[index].getMap.toFavoritesEntity(),
                                ignoreDuplicate: false, // Avoid the same song
                              );

                              final snackBar = SnackBar(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                backgroundColor: Colors.white,
                                content: const Text(
                                  ' Added to favourites',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            backgroundColor: Color.fromARGB(255, 50, 63, 77),
                            foregroundColor: Colors.white,
                            icon: Icons.favorite,
                            label: 'fav',
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              dialogBox(context, allSongs, audioRoom, index);

                             
                            },
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            icon: Icons.playlist_add,
                            label: 'Playlist',
                          )
                        ],
                      ),
                      child: ListTile(
                        onTap: () async {
                          await player.open(
                              Playlist(audios: songDetails, startIndex: index),
                              showNotification: true,
                              loopMode: LoopMode.playlist,
                              notificationSettings: const NotificationSettings(
                                  stopEnabled: false));
                        },
                        leading: QueryArtworkWidget(
                          artworkHeight: 60,
                          artworkWidth: 60,
                          size: 600,
                          id: item.data![index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(300),
                            ),
                            child: Image.asset(
                              'assets/hedphone.jpeg',
                              fit: BoxFit.cover,
                              width: 60,
                              height: 60,
                            ),
                          ),
                        ),
                        title: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            item.data![index].displayNameWOExt,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color.fromARGB(255, 202, 197, 197),
                            ),
                          ),
                        ),
                        // trailing: InkWell(
                        //   onTap: () {

                        //   },
                        //   child: const Icon(Icons.more_vert_outlined,color: Colors.black,size: 30,),
                        // ),
                      ),
                    ),
                    separatorBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 8, top: 8),
                        child: Divider(
                          thickness: 3.0,
                        ),
                      );
                    },
                  ),
                ),
              );
            }));
  }

  void songsLibrary(int index, List<Audio> audios) async {
    await player.open(
      Playlist(
        audios: audios,
        startIndex: index,
      ),
      showNotification: true,
      notificationSettings: const NotificationSettings(
        stopEnabled: false,
      ),
      playInBackground: PlayInBackground.enabled,
    );
  }
}
