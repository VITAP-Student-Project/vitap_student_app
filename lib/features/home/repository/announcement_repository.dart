import 'dart:convert';
import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/constants/server_constants.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/features/home/model/announcement.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';

part 'announcement_repository.g.dart';

@riverpod
AnnouncementRepository announcementRepository(AnnouncementRepositoryRef ref) {
  final client = serviceLocator<http.Client>();
  return AnnouncementRepository(client);
}

class AnnouncementRepository {
  final http.Client client;

  // GitHub raw file URL for the announcements.json in the same repository
  static const String _announcementsUrl =
      '${ServerConstants.githubBaseUrl}/announcements.json';

  AnnouncementRepository(this.client);

  Future<Either<Failure, List<Announcement>>> fetchAnnouncements() async {
    try {
      final response = await client.get(
        Uri.parse(_announcementsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        final announcementResponse =
            AnnouncementResponse.fromJson(responseData);

        // Filter announcements: only active ones that haven't expired
        final now = DateTime.now();
        final activeAnnouncements =
            announcementResponse.announcements.where((announcement) {
          if (!announcement.isActive) return false;

          // Check if announcement has expired
          final expiresAt = DateTime.parse(announcement.expiresAt);
          return now.isBefore(expiresAt);
        }).toList();

        // Sort by importance (critical > high > medium > low) and then by creation date
        activeAnnouncements.sort((a, b) {
          final importanceOrder = {
            'critical': 4,
            'high': 3,
            'medium': 2,
            'low': 1,
          };

          final aImportance = importanceOrder[a.importance] ?? 0;
          final bImportance = importanceOrder[b.importance] ?? 0;

          if (aImportance != bImportance) {
            return bImportance
                .compareTo(aImportance); // Higher importance first
          }

          // If same importance, sort by creation date (newer first)
          return DateTime.parse(b.createdAt)
              .compareTo(DateTime.parse(a.createdAt));
        });

        return Right(activeAnnouncements);
      } else {
        return Left(
            Failure('Failed to fetch announcements: ${response.statusCode}'));
      }
    } on SocketException {
      return Left(Failure("No internet connection"));
    } on FormatException catch (e) {
      return Left(Failure("Invalid response format: ${e.message}"));
    } catch (e) {
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }
}
