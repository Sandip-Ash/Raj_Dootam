import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:raj_dootam/models/message.dart';

class ChatService {
  //get instance of firestore and auth
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  // get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return firestore.collection("Users").snapshots().map((snapshot){
      return snapshot.docs.map((doc) {
        // go through each individual user
        final user = doc.data();

        return user;
      }).toList();
    });
  }

  // Send message
  Future<void> sendMessage(String recvID, msg) async{
    // get current user info
    final String curUserID = auth.currentUser!.uid;
    final String curUserEmail = auth.currentUser!.email!;
    final Timestamp timeStamp = Timestamp.now();

    // Create a new message
    Message newMessage = Message(
        senderId: curUserID,
        senderEmail: curUserEmail,
        recvID: recvID,
        msg: msg,
        timeStamp: timeStamp
    );

    // Construct chat room ID for the 2 users (sorted to ensure uniqueness)
    List<String> IDs = [curUserID, recvID];
    IDs.sort(); // sort the ID's (this ensures the chatroom ID is the same for any 2 people)
    String chatroomID = IDs.join('_');

    // add new message to database
    await firestore.collection("chat_rooms").doc(chatroomID).collection("message").add(newMessage.toMap());
  }

  // Get message
  Stream<QuerySnapshot> getMessages(String userID, otherUserID){
    // construct a chatroom ID for the 2 users
    List<String> IDs = [userID, otherUserID];
    IDs.sort();
    String chatroomID = IDs.join('_');
    return firestore.collection("chat_rooms").doc(chatroomID).collection("message").orderBy("timestamp", descending: false).snapshots();
  }
}