import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

class ForYouTiles extends ConsumerStatefulWidget {
  const ForYouTiles({super.key});

  @override
  ForYouTilesState createState() => ForYouTilesState();
}

class ForYouTilesState extends ConsumerState<ForYouTiles> {
  Map<String, dynamic>? gradesMap;

  // List of data for the tiles
  final List<Map<String, dynamic>> tilesData = [
    {
      'title': 'Vitopia',
      'author': 'VIT-AP',
      'imageUrl': '',
      'type': 'event',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      'url': '',
    },
    {
      'title': 'Faculty Ranker',
      'author': 'Sarath',
      'imageUrl': '',
      'type': 'tools',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      'url': 'https://faculty-ranker.vercel.app',
    },
    // {
    //   'title': 'Timetable Scheduler',
    //   'author': 'Sarath',
    //   'imageUrl': '',
    //    'type' : '',
    //   'description': 'Calculate your GPA',
    //   'details': 'Use this option to calculate your GPA based on your grades.',
    //   'url': 'https://vitap-time-table-scheduler.vercel.app',
    // },
    {
      'title': 'PYQ\'s',
      'author': 'Sarath',
      'imageUrl': '',
      'type': 'tools',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      'url': 'https://exam-paper-uploader-vitap.vercel.app',
    },
    {
      'title': 'GPA Calculator',
      'author': 'Udhay',
      'imageUrl': '',
      'type': 'tools',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      'url': 'https://exam-paper-uploader-vitap.vercel.app',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 375,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tilesData.length, // Dynamic count based on data list
        itemBuilder: (context, index) {
          final tile = tilesData[index]; // Get the current tile data
          return GestureDetector(
            onTap: () {
              // Navigate to TileDetailPage and pass the tile data
              Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  type: PageTransitionType.fade,
                  child: TileDetailPage(
                    title: tile['title'],
                    author: tile['author'],
                    description: tile['description'],
                    url: tile['url'],
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Theme.of(context).colorScheme.secondary,
              ),
              width: 225,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: Container(
                      height: 200,
                      width: 200,
                      color: Colors.green.shade100,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    flex: 0,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              color: tile['type'] == 'event'
                                  ? Colors.yellowAccent.shade700
                                      .withOpacity(0.20)
                                  : Colors.blueAccent.shade200
                                      .withOpacity(0.20),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  tile['type'],
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: tile['type'] == 'event'
                                        ? Colors.yellow.shade700
                                        : Colors.blue.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          tile['title'],
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'by ' + tile['author'],
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          tile['description'],
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Know more',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
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

// TileDetailPage to display data dynamically
class TileDetailPage extends StatelessWidget {
  final String title;
  final String author;
  final String description;
  final String url;

  const TileDetailPage({
    Key? key,
    required this.title,
    required this.description,
    required this.author,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: ElevatedButton.icon(
          onPressed: () {},
          label: Text("Visit Now"),
          iconAlignment: IconAlignment.end,
          icon: Icon(
            Icons.arrow_outward_rounded,
          ),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: Size(MediaQuery.sizeOf(context).width - 20, 40)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
