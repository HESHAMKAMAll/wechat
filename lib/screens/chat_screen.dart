import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance ;
late User signedInUser ; //دي هتكون فيها ال email

class ChatScreen extends StatefulWidget {
  static const String ScreenRoute = 'chat_screen' ;
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController() ;
  final _auth = FirebaseAuth.instance ;


   String? messageText ;   //دي هتكون فيها الرساله

  @override
  void initState() {
    super.initState();
    getCurrentUser() ;
  }

  void getCurrentUser(){
    final user = _auth.currentUser ;
    if(user != null){
      signedInUser = user ;
      print(signedInUser.email) ;
    }

    try {
      final user = _auth.currentUser ;
      if(user != null){
        signedInUser = user ;
      }
    } catch (e) {
      print(e) ;
    }

  }

  // void getMessages () async {
  //   final messages = await _firestore.collection('messages').get() ;
  //   for (var message in messages.docs) {
  //     print(message.data()) ;
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        title: Row(children: [
          Image.asset("images/3.png", height: 25),
          SizedBox(width: 10),
          Text("We Chat"),
        ]),
        actions: [
          IconButton(
              onPressed: () {
                // messagesStreams();
                _auth.signOut() ;
                Navigator.pop(context) ;
                // add her logout function
              },
              icon: Icon(Icons.close)),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:
            [
              MessageStreamBuilder(),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.teal,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
                children:
                [
              Expanded(
                  child: TextField(
                    controller: messageTextController,
                onChanged: (value) {
                  messageText = value ;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    hintText: 'Write Your Message Here...',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    )
                ),
              )
              ),
                  // TextButton(
                  //     onPressed: (){},
                  //     child: Text(
                  //         "Send",
                  //       style: TextStyle(
                  //         color: Colors.blue[900],
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 18,
                  //       ),
                  //     ),
                  // ),
                  IconButton(
                      onPressed: (){
                        messageTextController.clear() ;
                        _firestore.collection('messages').add({
                          'text' : messageText,
                          'sender' : signedInUser.email,
                          'time' : FieldValue.serverTimestamp(),
                        }) ;
                      },
                      icon: Icon(Icons.send,color: Colors.teal[800],size: 30),
                    style: ButtonStyle(
                    ),
                  ),
            ]
            ),
          ),
        ]),
      ),
    );
  }
}


class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context , snapshots){
        List<MessageLine> messageWidgets = [] ;

        if(!snapshots.hasData){
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
          //  add here a spinner
        }

        final messages = snapshots.data!.docs.reversed ;
        for(var message in messages){
          final messageText = message.get('text') ;
          final messageSender = message.get('sender') ;
          final currentUser = signedInUser.email ;



          final messageWidget = MessageLine(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );
          messageWidgets.add(messageWidget) ;
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            children: messageWidgets,
          ),
        ) ;
      },
    );
  }
}




class MessageLine extends StatelessWidget {
  const MessageLine({this.text,this.sender,required this.isMe, Key? key}) : super(key: key);

  final String? sender ;
  final String? text ;
  final bool isMe ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ?  CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text('$sender',style: TextStyle(fontSize: 12,color: Colors.teal[600]),),
          Material(
            elevation: 15,
            borderRadius: BorderRadius.only(
              topLeft: isMe ? Radius.circular(14) : Radius.circular(2),
              bottomLeft: isMe ? Radius.circular(14) : Radius.circular(30),
              bottomRight: isMe ? Radius.circular(30) : Radius.circular(14),
              topRight: isMe ?  Radius.circular(2) : Radius.circular(14),
            ),
            color: isMe ? Colors.teal[900] : Colors.teal[400] ,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Text(
                '$text',
                style: TextStyle(fontSize: 15, color:Colors.white),
              ),
            ),
          ),
        ],
      ),
    ) ;
  }
}

