import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music1/function/function.dart';
import 'package:music1/miniplayer.dart';
import 'package:music1/openplayer.dart';

import 'package:music1/screens/musics/mymusic.dart';
import 'package:music1/screens/nowplay.dart';
import 'package:music1/screens/playlist/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class deligatesearch extends SearchDelegate {
  List<String> allData = [''];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        color: Colors.grey,
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      hintColor: Colors.grey,
      appBarTheme: const AppBarTheme(
        color: Colors.black,
      ),
      textTheme: TextTheme(),
      inputDecorationTheme: searchFieldDecorationTheme ??
          const InputDecorationTheme(
              border: InputBorder.none, fillColor: Colors.black),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: GoogleFonts.nunito(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchSongItem = query.isEmpty
        ? allSongs
        : allSongs
            .where(
              (element) => element.title.toLowerCase().contains(
                    query.toLowerCase().toString(),
                  ),
            )
            .toList();

    return Scaffold(
      body: Container(
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
        child: searchSongItem.isEmpty
            ? Center(
                child: Text(
                  "No Songs Found",
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    letterSpacing: 1,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.separated(
                itemCount: searchSongItem.length,
                itemBuilder: (context, index) {
                  // int currentINdex = songDetails.indexWhere((element) =>
                  //     element.metas.title! == searchSongItem[index]);
                  // print(currentINdex);
                  // print(
                  //     '===============================================================================');

                  return ListTile(
                        
                    // onTap: () async {

                    //   await player.open(
                    //       Playlist(audios: searchSongItem, startIndex: index),
                    //       showNotification: true,
                    //       loopMode: LoopMode.playlist,
                    //       notificationSettings: const NotificationSettings(
                    //           stopEnabled: false));
                    // },

                    onTap: () async {
                      List<Audio> searchAudio = [];

                      for (var item in allSongs) {
                        searchAudio.add(Audio.file(item.uri!,
                            metas: Metas(
                              id: item.id.toString(),
                              title: item.title,
                              artist: item.artist,
                            )));
                      }

                      int currentIndex = allSongs.indexWhere((element) => element.id == searchSongItem[index].id);
                           
                      await OpenMusic(
                        fullSongs: [],
                        index: currentIndex,
                      ).openAssetPlayer(index: currentIndex, songs: searchAudio);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) =>  NowPlaying()),
                        ),
                      );
                    },
                    leading: QueryArtworkWidget(
                      artworkHeight: 60,
                      artworkWidth: 60,
                      size: 600,
                      id: searchSongItem[index].id,
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
                      child: Text(searchSongItem[index].title, 
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
                  );
                },
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
  }
}


// class deligatesearch extends SearchDelegate {
//   List<String> allData = [''];

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         color: Colors.grey,
//         onPressed: () {
//           if (query.isEmpty) {
//             close(context, null);
//           } else {
//             query = '';
//           }
//         },
//         icon: const Icon(Icons.clear),
//       ),
//     ];
//   }

//   @override
//   ThemeData appBarTheme(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     return theme.copyWith(
//       hintColor: Colors.grey,
//       appBarTheme: const AppBarTheme(
//         color: Color.fromARGB(255, 221, 255, 252),
//       ),
//       inputDecorationTheme: searchFieldDecorationTheme ??
//           const InputDecorationTheme(
//               border: InputBorder.none, fillColor: Colors.black),
//     );
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: const Icon(
//         Icons.arrow_back,
//         color: Colors.grey,
//       ),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return Center(
//       child: Text(
//         query,
//         style: GoogleFonts.nunito(
//           fontSize: 20,
//           color: Colors.black,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final searchSongItem = query.isEmpty
//         ? songDetails
//         : songDetails
//                 .where(
//                   (element) => element.metas.title!.toLowerCase().contains(
//                         query.toLowerCase().toString(),
//                       ),
//                 )
//                 .toList() +
//             songDetails
//                 .where(
//                   (element) => element.metas.artist!.toLowerCase().contains(
//                         query.toLowerCase().toString(),
//                       ),
//                 )
//                 .toList();
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 221, 255, 252),
//       body: searchSongItem.isEmpty
//           ? Center(
//               child: Text(
//                 "No Songs Found",
//                 style: GoogleFonts.nunito(
//                   fontSize: 20,
//                   letterSpacing: 1,
//                   color: Colors.grey,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             )
//           : ListView.builder(
//               physics: const BouncingScrollPhysics(),
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
//                   child: Container(
//                     height: 90,
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(10),
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.2),
//                           spreadRadius: 0.3,
//                           blurRadius: 1,
//                           offset: const Offset(3, 3),
//                         ),
//                       ],
//                       gradient: LinearGradient(
//                         colors: [
//                           Colors.purpleAccent.withOpacity(0.35),
//                           Colors.purpleAccent.withOpacity(0.015),
//                         ],
//                         begin: Alignment.bottomCenter,
//                         end: Alignment.topCenter,
//                       ),
//                     ),
//                     child: Center(
//                       child: ListTile(
//                         onTap: (() async {
//                           await 
//                           OpenMusic(
//                             fullSongs: [],
//                             index: index,
//                           ).openAssetPlayer(
//                             index: index,
//                             songs: searchSongItem,
//                           );
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: ((context) =>NowPlaying()),
//                             ),
//                           );
//                         }),
//                         leading: QueryArtworkWidget(
//                           nullArtworkWidget: ClipRRect(
//                             borderRadius: const BorderRadius.all(
//                               Radius.circular(50),
//                             ),
//                             child: Image.asset(
//                               'assets/images/Apple-Music-Artist-Lover.png',
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           id: int.parse(searchSongItem[index].metas.id!),
//                           type: ArtworkType.AUDIO,
//                         ),
//                         title:
//                             // SizedBox(
//                             //   height: 30,
//                             //   child: Marquee(
//                             //     blankSpace: 20,
//                             //     velocity: 20,
//                             //     text: searchSongItem[index].metas.title!,
//                             //     style: GoogleFonts.nunito(
//                             //       fontSize: 25,
//                             //       fontWeight: FontWeight.w600,
//                             //       color: Colors.black,
//                             //     ),
//                             //   ),
//                             // ),
//                             Text(
//                               searchSongItem[index].metas.title!,
//                               overflow: TextOverflow.ellipsis,
//                               style: GoogleFonts.nunito(
//                                 fontSize: 20,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                         subtitle:
//                             // SizedBox(
//                             //   height: 20,
//                             //   child: Marquee(
//                             //     blankSpace: 20,
//                             //     velocity: -20,
//                             //     pauseAfterRound: const Duration(seconds: 2),
//                             //     startPadding: 10,
//                             //     text: searchSongItem[index].metas.artist!,
//                             //     style: GoogleFonts.nunito(
//                             //       fontSize: 15,
//                             //       fontWeight: FontWeight.w600,
//                             //       color: Colors.black,
//                             //     ),
//                             //   ),
//                             // ),
//                             Text(
//                               searchSongItem[index].metas.artist!,
//                               overflow: TextOverflow.ellipsis,
//                               style: GoogleFonts.nunito(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black,
//                               ),
//                             ),
//                         trailing: IconButton(
//                           onPressed: () {},
//                           icon: const Icon(
//                             Icons.more_vert_rounded,
//                             color: Colors.grey,
//                             size: 30,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               itemCount: searchSongItem.length,
//             ),
//     );
//   }
// }


