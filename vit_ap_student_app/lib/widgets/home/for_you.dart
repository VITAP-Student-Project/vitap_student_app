import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

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
      'title': 'Events',
      'author': 'VIT-AP',
      'imageUrl': '',
      'type': 'event',
      'description':
          """The VIT-AP Events Website is a comprehensive portal that highlights the wide range of workshops, Faculty Development Programs (FDPs), and events happening at VIT-AP University. It serves as a vibrant hub for discovering opportunities that enhance learning, promote networking, and facilitate professional growth. Whether you're a student seeking hands-on workshops, a faculty member looking for skill enhancement through FDPs, or simply interested in attending innovative campus events, this website offers a centralized platform to stay updated.""",
      'url': 'https://events.vitap.ac.in/',
    },
    {
      'title': 'Faculty Ranker',
      'author': 'Sarath',
      'imageUrl': '',
      'type': 'tools',
      'description':
          'The VIT-AP Faculty Rating Website allows students to rate and review their professors based on three key aspects: attendance, teaching effectiveness, and marks distribution. Students can assess how lenient faculty are with attendance, how engaging and clear their teaching is, and how fairly they grade assignments and exams. The platform provides an opportunity for students to make informed decisions about their courses and allows faculty to gain valuable feedback on their teaching methods. This transparent system fosters a more interactive and responsive academic environment, helping both students and faculty enhance their learning and teaching experiences.',
      'url': 'https://faculty-ranker.vercel.app',
    },
    {
      'title': 'PYQ\'s',
      'author': 'Sarath',
      'imageUrl': '',
      'type': 'tools',
      'description':
          'The Previous Year Question Papers website for VIT-AP University provides students with easy access to past exam papers across various subjects and courses. This platform serves as a valuable resource for students to practice and familiarize themselves with the exam format, types of questions, and important topics that have been covered in previous exams. By reviewing these question papers, students can improve their preparation, identify recurring themes, and boost their confidence for upcoming exams. The website offers a comprehensive collection of papers, enabling students to make well-informed study plans and perform better academically.',
      'url': 'https://exam-paper-uploader-vitap.vercel.app',
    },
    {
      'title': 'Timetable Scheduler',
      'author': 'Sarath',
      'imageUrl': '',
      'type': 'tools',
      'description':
          'The Time-Table Scheduler website for VIT-AP University is a tool designed to help students create personalized schedules for their academic year. Students can input their courses, preferred study times, and the tool will generate an optimized timetable that ensures efficient time management. This website helps students avoid scheduling conflicts, plan study sessions effectively, and allocate sufficient time for both academic and personal commitments. With an easy-to-use interface, it makes organizing the semester simpler and more manageable, enhancing productivity and reducing stress throughout the academic term.',
      'url': 'https://vitap-time-table-scheduler.vercel.app',
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
          onPressed: () async {
            final Uri webUrl = Uri.parse(url);
            if (!await launchUrl(webUrl)) {
              throw Exception('Could not launch $url');
            }
          },
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
