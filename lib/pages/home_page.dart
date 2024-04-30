import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:raj_dootam/constants/colors/colors.dart';
import 'package:raj_dootam/services/chat_service.dart';

import '../auth/auth_services.dart';
import '../components/my_drawer.dart';
import '../components/user_tile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final ChatService chatService = ChatService();
  final AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const MyDrawer(),
      drawerScrimColor: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.95),
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          'USERS',
          style: TextStyle(
              fontSize: 30,
              color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.8),
            letterSpacing: 4,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      // body: My_homePageBody(context),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder(
        stream: chatService.getUserStream(),
        builder: (context, snapshot){
          // error
          if(snapshot.hasError){
            return const Text('Error');
          }

          // loading...
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Text('Loading...');
          }

          // return list view
          return ListView(
            children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
          );
        }
    );
  }

  // build individual list tile for user
  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context){
    // display all users except current user
    if(userData["email"] != authServices.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          // tapped on a user --> go to chat page
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ChatPage(
                        recvEmail: userData["email"],
                        recvID: userData["uid"],
                      )
              )
          );
        },
      );
    } else{
      return Container();
    }
  }

  // Center My_homePageBody(BuildContext context) {
  //   return Center(
  //     child: Padding(
  //         padding: const EdgeInsets.all(10),
  //       child: CircularPercentIndicator(
  //         animation: true,
  //         animationDuration: 2000,
  //         radius: 170,
  //         lineWidth: 40,
  //         percent: 0.38,
  //         progressColor: tdBlue,
  //         backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
  //         circularStrokeCap: CircularStrokeCap.round,
  //         center: Text(
  //           '38%',
  //             style: GoogleFonts.rubikGlitch(
  //             fontSize: 70,
  //             color: tdGreen
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
