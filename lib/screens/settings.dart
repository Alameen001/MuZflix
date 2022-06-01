import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Settingsscreen extends StatelessWidget {
  const Settingsscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
        title: Text(
          'Settings',
         style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
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
       
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.share_outlined),
              title: Text(
                'Share App',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text(
                'Privacy policy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.star_border),
              title: Text(
                'Rate Us',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Sign Out',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 20,
                ),
              ),
            ),
            Spacer(),
            Column(
              children: [
                Text(
                  'Version',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  '2.4.2',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}
