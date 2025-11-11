import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final supabase = Supabase.instance.client;
  List<String> emails = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response = await supabase.from('users').select('email').execute();
    if (response.error == null) {
      final data = response.data as List<dynamic>;
      setState(() {
        emails = data.map((e) => e['email'] as String).toList();
      });
    } else {
      print('Error fetching users: ${response.error!.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users List')),
      body: ListView.builder(
        itemCount: emails.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(emails[index]));
        },
      ),
    );
  }
}
