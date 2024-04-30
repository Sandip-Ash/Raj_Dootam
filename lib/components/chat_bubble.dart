import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raj_dootam/constants/colors/colors.dart';
import 'package:raj_dootam/constants/theme/theme_provider.dart';

class ChatBubble extends StatelessWidget {
  final String msg;
  final bool isCurUser;
  const ChatBubble({Key? key, required this.msg, required this.isCurUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    bool isDark = Provider.of<ThemeProvider>(context, listen: false).isDark;

    return Container(
      constraints: BoxConstraints(
        maxWidth: screenWidth*2/3,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isCurUser ? tdGreen : Theme.of(context).colorScheme.primary
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child:SelectableText(msg, style: TextStyle(color: Colors.white, fontSize: 16),),
    );
  }
}
