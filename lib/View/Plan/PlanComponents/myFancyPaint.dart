import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Models/Rooms/Room.dart';

class MyFancyPainter extends CustomPainter {
  List<Room> listRoom;
  int floor;
  int serviceId;
  MyFancyPainter({
    this.listRoom,
    this.floor,
    this.serviceId
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paintRoom1 = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeMiterLimit = 2.0;
    var paintRoom2 = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.2;

    var paintRoom3 = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    var paintRoom4 = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
    var paintRoom5 = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    TextPainter textPainter;
    textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    //a rectangle
    listRoom.forEach((element) {
      if (element.service.id == this.serviceId) {
        if (element.floor == this.floor) {
          final cross = Path()
          ..relativeMoveTo(element.positionX*5.0, element.positionY*5.0)
          ..close();
          //cross.moveTo(element.positionX*1.0, element.positionY * 1.0);
          List<Offset> listPoint = [];
        /*  if(element.corners.length > 4) {
*/
          //listPoint.add(new Offset(element.positionX*0.5, element.positionY * 0.5));
          double multX = -5.0;
          double multY = -5.0;
         /* if (element.corners[0].x > element.corners[1].x)
            multX = 5.0;
          else {
            multX = -5.0;
          }
          if (element.corners.first.y > element.corners.last.y)
            multY = 5.0;
          else {
            multY = -5.0;
          }*/

          for(int i = 0; i < element.corners.length; i++) {
            listPoint.add(new Offset((element.positionX* multX - element.corners[i].x* multX) , (element.positionY* multY - element.corners[i].y* multY)));
          }
          cross.addPolygon(listPoint, false);
       /*   } else {
            cross.addRect(Offset(element.positionX*0.5, element.positionY*0.5) && Size(
              element.corners[0].x - element.corners[1].x,
                element.corners[0].y - element.corners[1].y
            ));
          }*/

          switch (element.type.id ){
            case 1: {
              canvas.drawPath(cross, paintRoom1);
            }
            break;
            case 2: {
              canvas.drawPath(cross, paintRoom2);
            }
            break;
            case 3: {
              canvas.drawPath(cross, paintRoom3);
            }
            break;
            case 4: {
              canvas.drawPath(cross, paintRoom4);
            }
            break;
            case 5: {
              canvas.drawPath(cross, paintRoom5);
            }
            break;
            default: {
              canvas.drawPath(cross, paintRoom5);
            }
            break;
          }
          textPainter.text = TextSpan(
            text: element.title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 2,
            ),
          );
          Offset position = Offset(
            (element.positionX * multX - element.corners.first.x * multX),
            (element.positionY * multY - element.corners.first.y * multY),
          );
          textPainter.layout();
          textPainter.paint(canvas, position);
        }
      }


    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

