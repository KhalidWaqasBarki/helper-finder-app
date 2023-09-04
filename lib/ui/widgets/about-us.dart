// ignore_for_file: public_member_api_docs

import 'package:about/about.dart';

import 'package:flutter/material.dart';

class about extends MaterialPageRoute<void> {
  about()
      : super(
          builder: (BuildContext context) {
            final aboutPage = AboutPage(
              values: {
                'version': "1.0.0",
                //'buildNumber': Pubspec.versionBuild.toString(),
                'year': "2022", //DateTime.now().year.toString(),
                'author': "Waqas and Musawir" // Pubspec.authorsName.join(', '),
              },
              title: const Text('About'),
              applicationVersion: 'Version {{ version }}',
              applicationDescription: const Text(
                "Find the workers and save your time!\nFind top-rated workers,wherever you are\nProviding you ease in your household work. ",
                textAlign: TextAlign.justify,
              ),

              applicationIcon: Image.asset(
                "assets/images/worker.png",
                height: 100,
              ), //const FlutterLogo(size: 100),
              applicationLegalese: 'Copyright © {{ author }}, {{ year }}',
              children: const <Widget>[
                MarkdownPageListTile(
                  filename: 'assets/file/README.md',
                  title: Text('View Readme'),
                  icon: Icon(Icons.all_inclusive),
                ),
                //   MarkdownPageListTile(
                //     filename: 'CHANGELOG.md',
                //     title: Text('View Changelog'),
                //     icon: Icon(Icons.view_list),
                //   ),
                //MarkdownPageListTile(
                 // filename: 'assets/file/licens.md',
                  //title: Text('View License'),
                  //icon: Icon(Icons.description),
                //),
                //   MarkdownPageListTile(
                //     filename: 'CONTRIBUTING.md',
                //     title: Text('Contributing'),
                //     icon: Icon(Icons.share),
                //   ),
                //   MarkdownPageListTile(
                //     filename: 'CODE_OF_CONDUCT.md',
                //     title: Text('Code of conduct'),
                //     icon: Icon(Icons.sentiment_satisfied),
                //   ),
                //   LicensesPageListTile(
                //     title: Text('Open source Licenses'),
                //     icon: Icon(Icons.favorite),
                //   ),
              ],
            );
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'HELPER FINDER',
              home: aboutPage,
              theme: ThemeData(),
              darkTheme: ThemeData(brightness: Brightness.dark),
            );
          },
        );
}
