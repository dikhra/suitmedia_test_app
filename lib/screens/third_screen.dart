import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Third Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
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
      body: provider.isLoading && provider.users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                provider.currentPage = 1;
                provider.users.clear();
                provider.hasMoreData = true;
                await provider.fetchUsers(1);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount:
                      provider.users.length + 1, // +1 for the loading indicator
                  itemBuilder: (context, index) {
                    if (index < provider.users.length) {
                      final user = provider.users[index];
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                            horizontalTitleGap: 6,
                            leading: CircleAvatar(
                                radius: 46,
                                backgroundImage: NetworkImage(user['avatar'])),
                            title: Text(
                              '${user['first_name']} ${user['last_name']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            subtitle: Text('${user['email']}'.toUpperCase()),
                            onTap: () {
                              provider.selectUser(
                                  user['first_name'], user['last_name']);
                              Navigator.pop(context);
                            },
                          ),
                          Divider()
                        ],
                      );
                    } else if (provider.hasMoreData) {
                      provider.fetchUsers(provider.currentPage);
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Center(child: Text('No more users'));
                    }
                  },
                ),
              ),
            ),
    );
  }
}
