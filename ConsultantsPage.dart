import 'package:flutter/material.dart';
import 'Chatpage.dart';

class ConsultantsPage extends StatelessWidget {
  ConsultantsPage({Key? key});

  final List<String> titles = [
    'John Wick',
    'Robert J.',
    'James Gunn',
    'Ricky Tales',
    'Micky Mose',
    'Pick War',
    'Leg Piece',
    'Apple Mac',
  ];

  final List<String> imagePaths = [
    'assets/a.png',
    'assets/b.png',
    'assets/c.png',
    'assets/d.png',
    'assets/e.png',
    'assets/f.png',
    'assets/g.png',
    'assets/h.png',
  ];

  final List<String> subtitles = [
    'mailto:jon.wick@gmail.com',
    'mailto:robert.j@gmail.com',
    'mailto:james.gunn@gmail.com',
    'mailto:ricky.tales@gmail.com',
    'mailto:micky.mose@gmail.com',
    'mailto:pick.war@gmail.com',
    'mailto:leg.piece@gmail.com',
    'mailto:apple.mac@gmail.com',
  ];

  final List<String> phoneNumbers = [
    '+1234567890',
    '+2345678901',
    '+3456789012',
    '+4567890123',
    '+5678901234',
    '+6789012345',
    '+7890123456',
    '+8901234567',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultants'),
      ),
      body: ListView.builder(
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: Image.asset(
                imagePaths[index],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(titles[index]),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(subtitles[index]),
                  Text(phoneNumbers[index]),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      consultantName: titles[index],
                      consultantImage: imagePaths[index],
                      consultantPhoneNumber: phoneNumbers[index], // Pass phone number
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
