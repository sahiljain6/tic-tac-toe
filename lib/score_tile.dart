import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/constants.dart';

class ScoreTile extends StatefulWidget {
  const ScoreTile({
    super.key,
    required this.score,
    required this.player,
  });
  final int score;
  final String player;
  @override
  State<ScoreTile> createState() => _ScoreTileState();
}

class _ScoreTileState extends State<ScoreTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        height: 85,
        width: MediaQuery.of(context).size.width / 2 - 16,
        decoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.1),
            boxShadow: shadows,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text(
              'Player : ${widget.player}',
              style: GoogleFonts.montserrat(
                  color: Colors.white.withOpacity(0.5),
                  shadows: shadows,
                  fontSize: 22,
                  fontWeight: FontWeight.w100),
            ),
            const SizedBox(height: 8),
            Text(
              widget.score.toString(),
              style: GoogleFonts.montserrat(
                  color: Colors.white.withOpacity(0.5),
                  shadows: shadows,
                  fontSize: 22,
                  fontWeight: FontWeight.w200),
            ),
          ],
        ));
  }
}
