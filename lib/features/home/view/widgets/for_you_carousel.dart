import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/features/home/view/pages/tile_detail_page.dart';

class ForYouCarousel extends ConsumerStatefulWidget {
  const ForYouCarousel({super.key});

  @override
  ForYouTilesState createState() => ForYouTilesState();
}

class ForYouTilesState extends ConsumerState<ForYouCarousel> {
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
      'title': 'Slotify',
      'author': 'Venu K',
      'imageUrl': '',
      'type': 'tools',
      'description':
          'Slotify is a smart timetable scheduler built for students at VIT-AP University to easily plan their semester. Instead of manually figuring out class slots, students can upload course lists (PDF/Excel/CSV), choose their subjects, and instantly see a clash-free timetable. With features like real-time clash detection, visual timetable view, and export to PDF/Excel, Slotify helps organize your schedule effortlessly. It’s designed to be fast, user-friendly, and stress-free—making academic planning more efficient and manageable.',
      'url': 'https://slotify-vitap.vercel.app/',
    },
    {
      'title': 'AWS Study',
      'author': 'Aditya W',
      'imageUrl': '',
      'type': 'tools',
      'description':
          'Built by a student for students, this site helps you master AWS (STS3007) with focused practice. Tackle 100+ curated questions across all modules, grouped into Easy, Medium, and Hard. Sharpen your skills with interactive quizzes that track progress and reinforce concepts. Speed-revise with concise flashcards designed for quick last-minute reviews. AWS practice, simplified—study smarter and ace STS3007.',
      'url': 'https://aws-exam-prep.vercel.app/',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 375,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tilesData.length,
        itemBuilder: (context, index) {
          final tile = tilesData[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => TileDetailPage(
                      title: tile['title'],
                      author: tile['author'],
                      description: tile['description'],
                      url: tile['url'],
                    ),
                  ));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Theme.of(context).colorScheme.surfaceContainerLow,
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
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "by ${tile['author']}",
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
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Know more',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary,
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
