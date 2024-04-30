import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raj_dootam/auth/auth_services.dart';
import 'package:raj_dootam/components/chat_bubble.dart';
import 'package:raj_dootam/components/my_textfield.dart';
import 'package:raj_dootam/constants/colors/colors.dart';
import 'package:raj_dootam/services/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String recvEmail;
  final String recvID;
  ChatPage({super.key, required this.recvEmail, required this.recvID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // text controller
  final TextEditingController msgController = TextEditingController();

  // chat and auth services
  final ChatService chatService = ChatService();
  final AuthServices authServices = AuthServices();

  FocusNode myFocusNode = FocusNode();

  // scroll controller
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Add listener to focus node
    myFocusNode.addListener(() {
      if(myFocusNode.hasFocus){
        // cause a delay so that the keyboard has time to show up
        // then the amount of remaining space will be calculated,
        // the scroll down
        Future.delayed(
          const Duration(milliseconds: 500),
              () => scrollDown(),
        );
      }
    });

    Future.delayed(
      const Duration(milliseconds: 500),
          () => scrollDown(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    myFocusNode.dispose();
    msgController.dispose();
    super.dispose();
  }

  void scrollDown(){
    scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn
    );
  }

  // send message
  void sendMsg() async {
    // if there is something in the textfield
    if (msgController.text.isNotEmpty) {
      // send the message
      await chatService.sendMessage(widget.recvID, msgController.text);

      // Clear the controller
      msgController.clear();
    }

    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          widget.recvEmail,
          style: TextStyle(
              fontSize: 30,
              color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.8),
              letterSpacing: 4,
              fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      body: Column(
        children: [
          // display all messages
          Expanded(
              child: _buildMsgList()
          ),

          // user input
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMsgList() {
    String senderID = authServices.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: chatService.getMessages(widget.recvID, senderID),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text("Error");
          }

          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          // List View
          return ListView(
            controller: scrollController,
            children:
                snapshot.data!.docs.map((doc) => _buildMsgItem(doc)).toList(),
          );
        });
  }

  Widget _buildMsgItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurUser = data["senderID"] == authServices.getCurrentUser()!.uid;

    // align message to right if sender is the current user, otherwise left
    var alignment = isCurUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
        child: Column(
          crossAxisAlignment: isCurUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(msg: data["message"], isCurUser: isCurUser),
          ],
        )
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: [
          // textfield should take up most of the space
          Expanded(
              child: MyTextField(
                hintText: 'Type a message',
                obscureText: false,
                controller: msgController,
                focusNode: myFocusNode,
              )
          ),

          // send button
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: tdGreen
            ),
            margin: const EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: sendMsg,
                icon: const Icon(Icons.send)
            ),
          )
        ],
      ),
    );
  }
}
