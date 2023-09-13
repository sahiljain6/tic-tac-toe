import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/score_tile.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String winner() {
    for (int i = 0; i < 3; i++) {
      if (l[i] == l[i + 3] && l[i + 3] == l[i + 6] && l[i] != '') {
        return l[i];
      }
    }
    for (int i = 0; i < 8; i += 3) {
      if (l[i] == l[i + 1] && l[i + 1] == l[i + 2] && l[i] != '') {
        return l[i];
      }
    }
    if (l[0] == l[4] && l[4] == l[8] && l[0] != '') {
      return l[0];
    } else if (l[2] == l[4] && l[4] == l[6] && l[2] != '') {
      return l[2];
    }

    return '';
  }

  void tap(int i) {
    if (l[i] == '') {
      setState(() {
        c++;
        if (f) {
          l[i] = 'o';
        } else {
          l[i] = 'x';
        }
        String w = winner();
        if (w == '' && c == 9) {
          showDraw();
        } else if (w != '') {
          if (w == 'x') {
            x++;
          } else {
            o++;
          }
          show(w);
        }

        f = !f;
      });
    }
  }

  void show(String w) {
    setox();

    confetti.play();
    // ignore: use_build_context_synchronously
    showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      context: context,
      builder: (context) => AlertDialog(
        elevation: 0,
        contentPadding: const EdgeInsets.all(0),
        content: Container(
            padding: const EdgeInsets.all(8),
            height: 155,
            decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.purple,
                      blurStyle: BlurStyle.outer,
                      spreadRadius: .1,
                      blurRadius: 5),
                  BoxShadow(
                      color: Colors.purple,
                      blurStyle: BlurStyle.outer,
                      spreadRadius: .1,
                      blurRadius: 5)
                ],
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Text(
                  ' Congratulations !!',
                  style: GoogleFonts.montserrat(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w200),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Player : ',
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w100),
                    ),
                    Text(
                      "$w ",
                      style: GoogleFonts.montserrat(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'wins',
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  onTap: reset,
                  child: Center(
                    child: Container(
                        height: 35,
                        width: 110,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.white,
                                  blurStyle: BlurStyle.outer,
                                  spreadRadius: .1,
                                  blurRadius: 1),
                              BoxShadow(
                                  color: Colors.white,
                                  blurStyle: BlurStyle.outer,
                                  spreadRadius: .1,
                                  blurRadius: 1)
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.black,
                                  Colors.black.withOpacity(0.85)
                                ]),
                          ),
                          child: Center(
                            child: Text(
                              'Play Again',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white,
                                  fontSize: 14),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            )),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)
            // borderRadius: BorderRadius.circular(18),
            ),
        backgroundColor: Colors.black,
        alignment: Alignment.center,
      ),
    );
  }

  void showDraw() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        elevation: 0,
        contentPadding: const EdgeInsets.all(0),
        content: Container(
            padding: const EdgeInsets.all(8),
            height: 155,
            decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.purple,
                      blurStyle: BlurStyle.outer,
                      spreadRadius: .1,
                      blurRadius: 5),
                  BoxShadow(
                      color: Colors.purple,
                      blurStyle: BlurStyle.outer,
                      spreadRadius: .1,
                      blurRadius: 5)
                ],
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Drawn !',
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w100),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  onTap: reset,
                  child: Center(
                    child: Container(
                        height: 35,
                        width: 110,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.white,
                                  blurStyle: BlurStyle.outer,
                                  spreadRadius: .1,
                                  blurRadius: 1),
                              BoxShadow(
                                  color: Colors.white,
                                  blurStyle: BlurStyle.outer,
                                  spreadRadius: .1,
                                  blurRadius: 1)
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.black,
                                  Colors.black.withOpacity(0.85)
                                ]),
                          ),
                          child: Center(
                            child: Text(
                              'Play Again',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white,
                                  fontSize: 14),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            )),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)
            // borderRadius: BorderRadius.circular(18),
            ),
        backgroundColor: Colors.black,
        alignment: Alignment.center,
      ),
    );
  }

  void reset() {
    setState(() {
      confetti.stop();
      Navigator.of(context).pop();
      for (int i = 0; i < 9; i++) {
        l[i] = '';
      }
    });
    f = true;
    c = 0;
  }

  void getox() async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      o = pref.getInt('o')!;
      x = pref.getInt('x')!;
    });
  }

  void setox() async {
    var pref = await SharedPreferences.getInstance();
    pref.setInt('o', o);
    pref.setInt('x', x);
  }

  late ConfettiController confetti;
  int o = 0;
  int x = 0;
  bool f = true;
  int c = 0;
  List<String> l = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  @override
  void initState() {
    confetti = ConfettiController(duration: const Duration(seconds: 2));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    getox();
    super.initState();
  }

  @override
  void dispose() {
    confetti.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black.withOpacity(.1),
          title: Text(
            'Tic - Tac - Toe',
            style: GoogleFonts.charmonman(
                color: Colors.white.withOpacity(0.5),
                shadows: const [
                  BoxShadow(
                      color: Colors.purple, blurRadius: 5, spreadRadius: 0.1),
                  BoxShadow(
                      color: Colors.purple, blurRadius: 5, spreadRadius: 0.1)
                ],
                fontSize: 25,
                fontWeight: FontWeight.w100),
          )),
      backgroundColor: const Color.fromARGB(255, 12, 11, 11).withOpacity(1),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(children: [
                ScoreTile(player: 'o', score: o),
                const SizedBox(
                  width: 12,
                ),
                ScoreTile(player: 'x', score: x),
              ]),
            ),
            Container(
                padding: const EdgeInsets.all(8),
                height: 70,
                width: MediaQuery.of(context).size.width - 16,
                decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.1),
                    boxShadow: shadows,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Current chance : ',
                      style: GoogleFonts.montserrat(
                          color: Colors.white.withOpacity(0.5),
                          shadows: shadows,
                          fontSize: 20,
                          fontWeight: FontWeight.w100),
                    ),
                    Text(
                      f ? 'o' : 'x',
                      style: GoogleFonts.montserrat(
                          color: Colors.white.withOpacity(0.5),
                          shadows: shadows,
                          fontSize: 22,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 450,
              child: Stack(children: [
                GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      tap(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2.5)),
                          boxShadow: gridShadows,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.black
                                ]),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(2.5)),
                            boxShadow: [
                              BoxShadow(
                                  blurStyle: BlurStyle.outer,
                                  color: Colors.grey[800]!,
                                  spreadRadius: 0.1,
                                  blurRadius: 1,
                                  offset: const Offset(1, 1)),
                              const BoxShadow(
                                  blurStyle: BlurStyle.outer,
                                  color: Colors.black,
                                  spreadRadius: 0.1,
                                  blurRadius: 1,
                                  offset: Offset(-1, -1)),
                            ],
                          ),
                          child: Center(
                              child: Text(
                            l[index],
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                shadows: [
                                  BoxShadow(
                                      color: l[index] == 'x'
                                          ? Colors.purple
                                          : Colors.white,
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                      blurStyle: BlurStyle.outer),
                                  BoxShadow(
                                      color: l[index] == 'x'
                                          ? Colors.purple
                                          : Colors.white,
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                      blurStyle: BlurStyle.outer)
                                ],
                                color: l[index] == 'x'
                                    ? Colors.purple
                                    : Colors.white,
                                fontSize: 30),
                          )),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: ConfettiWidget(
                      blastDirectionality: BlastDirectionality.explosive,
                      gravity: 0.05,
                      blastDirection: pi / 2,
                      emissionFrequency: 0.04,
                      colors: const [Colors.purple, Colors.pink, Colors.white],
                      confettiController: confetti),
                ),
              ]),
            ),
            InkWell(
              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
              onTap: () {
                setState(() {
                  o = 0;
                  x = 0;
                });
                setox();
              },
              child: Center(
                child: Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.white,
                              blurStyle: BlurStyle.outer,
                              spreadRadius: .1,
                              blurRadius: 1),
                          BoxShadow(
                              color: Colors.white,
                              blurStyle: BlurStyle.outer,
                              spreadRadius: .1,
                              blurRadius: 1)
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.black,
                              Colors.black.withOpacity(0.85)
                            ]),
                      ),
                      child: Center(
                        child: Text(
                          'Reset Stats',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w200,
                              color: Colors.white,
                              fontSize: 13),
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
