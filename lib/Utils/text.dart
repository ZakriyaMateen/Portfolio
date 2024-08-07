import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text textRoboto(String label, Color color, FontWeight weight, double size){
  return Text(
    label,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.robotoMono(
      textStyle: TextStyle(color: color, letterSpacing: .5,fontWeight: weight,fontSize: size),
    ),
  );
}Text textRobotoHollow(String label, Color color, FontWeight weight, double size){
  return Text(
    label,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.robotoMono(
      textStyle: TextStyle( letterSpacing: .5,fontWeight: weight,fontSize: size,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..blendMode = BlendMode.hardLight
          ..strokeWidth = 1.5
          ..isAntiAlias = true
          ..strokeMiterLimit = 20
          ..strokeCap = StrokeCap.butt
          ..color = color,),
    ),
  );
}
Text textRobotoMessage(String label, Color color, FontWeight weight, double size){
  return Text(
    label,
    overflow: TextOverflow.visible,
    textAlign: TextAlign.center,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(color: color, letterSpacing: .5,fontWeight: weight,fontSize: size),
    ),
  );
}Text textLink(String label, Color color, FontWeight weight, double size){
  return Text(
    label.length>=60?label.substring(0,59):label,
    overflow: TextOverflow.visible,
    style: GoogleFonts.roboto(
      decoration: TextDecoration.underline,
      textStyle: TextStyle(color: color, letterSpacing: .5,fontWeight: weight,fontSize: size),
    ),

  );
}
Text textRubik(String label, Color color, FontWeight weight, double size){
  return Text(
    label,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.rubik(
      textStyle: TextStyle(color: color, letterSpacing: .5,fontWeight: weight,fontSize: size),
    ),
  );
}

Text textCenter(String label, Color color, FontWeight weight, double size){
  return Text(
    label,
    textAlign: TextAlign.center,
    overflow: TextOverflow.visible,
    style: GoogleFonts.robotoMono(
      textStyle: TextStyle(color: color, letterSpacing: .5,fontWeight: weight,fontSize: size),
    ),
  );

}

Text textLeftRubik(String label, Color color, FontWeight weight, double size){
  return Text(
    label,
    textAlign: TextAlign.left,
    overflow: TextOverflow.visible,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(color: color, letterSpacing: .5,fontWeight: weight,fontSize: size),
    ),
  );

}
Text textBullet(String label, Color color, FontWeight weight, double size) {
  return Text(
    '• $label',
    textAlign: TextAlign.left,
    overflow: TextOverflow.visible,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(color: color, letterSpacing: .5, fontWeight: weight, fontSize: size),
    ),
  );
}