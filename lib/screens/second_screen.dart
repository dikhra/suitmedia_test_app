import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Second Screen',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Color.fromARGB(255, 85, 74, 240),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: Container(
            color: Color.fromARGB(255, 226, 227, 228),
            height: 1,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome'),
            Text('${provider.name}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '${provider.selectedUserName ?? 'Selected User Name'}',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                  padding: const EdgeInsets.all(16),
                  backgroundColor: const Color.fromARGB(255, 43, 99, 123),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/third');
                },
                child: const Text('Choose a user'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
