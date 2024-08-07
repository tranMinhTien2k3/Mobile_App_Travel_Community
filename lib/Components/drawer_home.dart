import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_app/services/signout.dart';

class DrawerHome extends ConsumerWidget {
  DrawerHome({super.key});
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                accountName: Text(
                  "",
                  style: TextStyle(fontSize: 0),
                ),
                accountEmail: Text(user!.email!),
                currentAccountPictureSize: Size.square(100),
                currentAccountPicture: const CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage('lib/assets/image/mountain2.jpg'),
                  backgroundColor: Colors.transparent,
                )),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(' Profile '),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.luggage),
            title: const Text('My travel'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text(' Announcement '),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.video_label),
            title: const Text('Experience'),
            onTap: () {
              Navigator.pushNamed(context, '/exp');
            },
          ),
          ListTile(
            leading: const Icon(Icons.trip_origin),
            title: const Text('Service'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Log off'),

            onTap: () {
              signOut(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Setting'),
            onTap: () =>  Navigator.pushNamed(context, '/setting')

            

          )
        ],
      ),
    );
  }
}
