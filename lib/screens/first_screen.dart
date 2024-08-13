import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class FirstScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final sentenceController = TextEditingController();

  FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background PNG
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png', // Path ke file PNG
              fit: BoxFit.cover, // Mengisi area yang tersedia
            ),
          ),
          // Konten lainnya
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          const CircleAvatar(
                            radius: 60,
                            backgroundColor: Color.fromARGB(255, 146, 197, 205),
                            foregroundColor: Colors.white,
                            child: Icon(
                              Icons.person_add_alt_1,
                              size: 35,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Name',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: sentenceController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Palindrome',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                                padding: const EdgeInsets.all(16),
                                backgroundColor:
                                    const Color.fromARGB(255, 43, 99, 123),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              onPressed: () {
                                context
                                    .read<UserProvider>()
                                    .setName(nameController.text);
                                context
                                    .read<UserProvider>()
                                    .checkPalindrome(sentenceController.text);
                                final isPalindrome =
                                    context.read<UserProvider>().isPalindrome;
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Text(isPalindrome!
                                        ? 'Palindrome'
                                        : 'Not Palindrome'),
                                  ),
                                );
                              },
                              child: const Text('CHECK'),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                                padding: const EdgeInsets.all(16),
                                backgroundColor:
                                    const Color.fromARGB(255, 43, 99, 123),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/second');
                              },
                              child: const Text('NEXT'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
