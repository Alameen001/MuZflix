import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:music1/screens/musics/mymusic.dart';
import 'package:on_audio_query/on_audio_query.dart';

// class albumscreen extends StatelessWidget {
//    const albumscreen({ Key? key }) : super(key: key);

//    @override
//    Widget build(BuildContext context) {
//      return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text(
//           'Album',

//           style: TextStyle(
//               color: Color.fromARGB(255, 233, 217, 72),
//               fontWeight: FontWeight.bold,
//               fontSize: 30,
//               fontStyle: FontStyle.italic),
//         ),
//         leading: Icon(Icons.line_weight_rounded,color: Colors.yellow,size: 30,),
//         // actions: [Padding(
//         //   padding: const EdgeInsets.all(8.0),
//         //   child: Icon(Icons.search,color: Colors.yellow,size: 30,),
//         // )],
//         centerTitle: true,
//       ),
//       // body: Container(
//       //   color: Colors.black,
//       //   child: GridView.count(crossAxisCount: 2,

//       //       crossAxisSpacing: 10,
//       //    childAspectRatio: 25 / 28,
//       //   children: [

//       //       albumrfctor(imag1: 'assets/tylor.jpeg', title: 'Taylor Swift - (Songs)'),
//       //           albumrfctor(imag1: 'assets/weekend.jpeg', title: 'The Weeknd Reveals'),

//       //         albumrfctor(imag1: 'assets/zyn1.jpeg', title: 'ZAYN - Let Me (Official '),

//       //         albumrfctor(imag1: 'assets/just us.jpeg', title: 'Grover washington (Album)'),
//       //           albumrfctor(imag1: 'assets/dualipa.jpeg', title: 'Dua Lipa (album)'),
//       //          albumrfctor(imag1: 'assets/drike.jpg', title: 'Drake unveils'),
//       //            albumrfctor(imag1: 'assets/saleena.jpeg', title: 'Selena Gomez ‘Revelación’'),
//       //               albumrfctor(imag1: 'assets/xxtention.jpeg', title: 'Xxxtentacion (Album)'),

//       //   ],
//       //   ),

//       // ),
class AlbumPage extends StatefulWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

List<AlbumModel> allAlbums = [];

class _AlbumPageState extends State<AlbumPage> {
  @override
  Widget build(BuildContext context) { 
   // List<Audio> songs = [];
    // dynamic allsongs;
    
    //   List<SongModel> songmodel = allsongs.data!;
    //           // print(songmodel.length);

    //           for (var song in songmodel) {
    //             songs.add(Audio.file(
    //               song.uri.toString(),
    //               metas: Metas(
    //                 title: song.displayName,
    //                 artist: song.artist,
    //                 id: song.id.toString(),
    //               ),
    //             ));
    //           }
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Album',
         style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        leading: Icon(
          Icons.line_weight_rounded,
          color: Colors.yellow,
          size: 30,
        ),
        // actions: [Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Icon(Icons.search,color: Colors.yellow,size: 30,),
        // )],
        centerTitle: true,
      ),
      body: 
      Container(
         decoration: const BoxDecoration(
             
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
  
        child: GridView.builder(
          
          
          itemCount: allSongs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 0, childAspectRatio: 4 / 4),
          itemBuilder: (context, index) {
            print(allSongs.length);
            return Padding(
            
              padding: const EdgeInsets.all(4),
              child: FutureBuilder<List<AlbumModel>>(
                  future: audioquery.queryAlbums(),
                  builder: (context, songs) {
                    if (songs.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (songs.data!.isEmpty) {
                      return const Center(
                        child: Text('No Songs Found'),
                      );
                    }
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 8.0,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: 200,
                            width: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: QueryArtworkWidget(
                                id: songs.data![index].id,
                                type: ArtworkType.ALBUM,
                                artworkFit: BoxFit.cover,
                                artworkBorder: BorderRadius.circular(0),
                                quality: 100,
                                size: 400,
                                nullArtworkWidget: ClipRRect(
                                  child: Image.asset(
                                    'assets/hedphone.jpeg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF181717).withOpacity(.86),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            height: 55,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      songs.data![index].album,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(9, 5, 0, 0),
                                  child: Text(
                                    songs.data![index].artist.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}
