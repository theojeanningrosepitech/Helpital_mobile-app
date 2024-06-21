import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:helpital_mobile_app/Models/Rooms/Room.dart';
import 'package:helpital_mobile_app/View/Rooms/blockRooms.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

class ListBlocksRooms extends StatefulWidget {
  List<Room> listRoom;

  ListBlocksRooms({this.listRoom});
  @override
  _ListBlocksRoomsState createState() => _ListBlocksRoomsState(
    listRoom: this.listRoom
  );
}

class _ListBlocksRoomsState extends State<ListBlocksRooms> {
  List<Room> listRoom;

  _ListBlocksRoomsState({this.listRoom});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (listRoom != null) {

    return Container(
      height: size.height* 0.2,
      width: double.infinity,
      child:  LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: viewportConstraints.maxWidth
                  ),
                  child: AnimationLimiter(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listRoom.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              horizontalOffset: 50.0,
                              child: FadeInAnimation(
                                child: new Material(
                                    color: Colors.transparent,
                                    child: BlocksRooms(room: listRoom[index])),
                              ),
                            ),
                          );
                        },
                      )),

                ));
          })
    );
    } else {
      return Center(
        child: Text(HelpitalStrings.NO_ROOM),
      );
    }
  }
}
