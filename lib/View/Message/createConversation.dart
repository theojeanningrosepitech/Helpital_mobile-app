import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

import '../../Models/Conversation/conversation.dart';
import '../../Models/User/User.dart';
import '../../Services/conversationService.dart';
import 'infoElementOfConversation.dart';

class CreateConversation extends SearchDelegate {
  List<User> list;
  List<Conversation> listConv;
  CreateConversation({
    this.list
});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildCore(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildCore(context);
  }

  Widget buildCore(BuildContext context) {
    List<User> queryMatch = [];
    for (User obj in list) {
      if (obj.firstName.toLowerCase().contains(query.toLowerCase()) || obj.lastName.toLowerCase().contains(query.toLowerCase())) {
        queryMatch.add(obj);
      }
    }
    return ListView.builder(
        itemCount: queryMatch.length,
        itemBuilder: (context, index) {
          var result = queryMatch[index];
          return InkWell(
              onTap: () async {

                Conversation conv = await ConversationService().setNewConversation(result);
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InfoElementOfConversation(conversation: conv)));
              },
              child: ListTile(
                title: Text(result.firstName + ' ' + result.lastName),
              )
          );
        });
  }
}

