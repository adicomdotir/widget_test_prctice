import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.cyan,
        ),
        home: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProfileUi(),
    );
  }
}

class ProfileUi extends StatelessWidget {
  const ProfileUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Image(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              fit: BoxFit.cover,
              image: const NetworkImage(
                'https://upload.wikimedia.org/wikipedia/commons/e/e7/Everest_North_Face_toward_Base_Camp_Tibet_Luca_Galuzzi_2006.jpg',
              ),
            ),
            const Positioned(
              bottom: -50,
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  'https://learnenglish.britishcouncil.org/sites/podcasts/files/styles/max_1300x1300/public/2021-10/RS6715_492969113-hig.jpg?itok=W4AjyK_X',
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        const ListTile(
          title: Center(child: Text('Hadi Nouri')),
          subtitle: Center(child: Text('Native Android & Flutter Developer')),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.blue,
          ),
          child: TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.mail,
              color: Colors.white,
            ),
            label: const Text(
              'Hire Me',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const ListTile(
          title: Text('About Me'),
          subtitle: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
          ),
        )
      ],
    );
  }
}
