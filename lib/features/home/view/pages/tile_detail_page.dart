import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/core/constants/analytics_constants.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/core/utils/launch_web.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';

class TileDetailPage extends StatefulWidget {
  final String title;
  final String author;
  final String description;
  final String url;

  const TileDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.author,
    required this.url,
  });

  @override
  State<TileDetailPage> createState() => _TileDetailPageState();
}

class _TileDetailPageState extends State<TileDetailPage> {
  @override
  void initState() {
    super.initState();
    serviceLocator<AnalyticsService>().logScreen('TileDetailPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await directToWeb(widget.url);
                    serviceLocator<AnalyticsService>().logEvent(
                      AnalyticsEvents.tileDetailLinkOpened,
                      {AnalyticsParams.target: widget.title},
                    );
                  },
                  label: const Text('Visit Now'),
                  iconAlignment: IconAlignment.start,
                  icon: const Icon(
                    Iconsax.export_3_copy,
                    size: 16,
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    minimumSize:
                        Size(MediaQuery.sizeOf(context).width - 150, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
