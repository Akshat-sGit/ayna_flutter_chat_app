import 'package:ayna/utility/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'chat_page.dart'; // Assuming ChatPage is in a separate file

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Contacts',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey.withOpacity(0.05),
      ),
      body: isDesktop(context)
          ? Row(
              children: [
                Flexible(
                  flex: 2,
                  child: contactsList(),
                ),
                const Flexible(
                  flex: 3,
                  child: ChatPage(),
                ),
              ],
            )
          : contactsList(),
    );
  }

  Padding contactsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.separated(
        itemCount: 10, // Hardcoded 10 contacts
        separatorBuilder: (context, index) => const SizedBox(height: 16.0),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (!isDesktop(context)) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ChatPage(),
                  ),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: const BoxDecoration(
                color: CupertinoColors.darkBackgroundGray,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    height: 48.0,
                    width: 48.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: CupertinoColors.systemGrey,
                      image: DecorationImage(
                        image: AssetImage('assets/images/akshat.jpg'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  const Text(
                    'Akshat Agarwal',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16.0,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
