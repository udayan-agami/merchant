import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color(0xFF2D2F41),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF42455E),
          ),
        ),
        Positioned(
          height: MediaQuery.of(context).size.width * 0.35,
          width: MediaQuery.of(context).size.width * 0.35,
          top: 150,
          child: SvgPicture.asset('agami_logo.svg'),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.only(top: 15, right: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    color: const Color(0xFF2D2F41),
                    width: 5,
                    style: BorderStyle.solid)),
            child: IconButton(
              icon: const Icon(Icons.lightbulb_outline_rounded),
              onPressed: () {},
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CustomPaint(
            painter: WirePainter(),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.all(30),
          child: const Text('Powered by Agami Labs',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Roboto Condensed')),
        )
      ],
    ));
  }
}

class WirePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    //linepaint.strokeWidth = 6;
    //linepaint.color = const Color(0xFF2D2F41);
    //linepaint.style = PaintingStyle.stroke;
    //linepaint.strokeCap = StrokeCap.round;

    path.moveTo(size.width - 50, 82);
    path.lineTo(size.width - 50, size.height - 100);
    path.quadraticBezierTo(
        size.width - 50, size.height - 100, size.width - 60, size.height - 90);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
