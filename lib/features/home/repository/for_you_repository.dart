import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/constants/server_constants.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/features/home/model/for_you_item.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';

part 'for_you_repository.g.dart';

@riverpod
ForYouRepository forYouRepository(Ref ref) {
  final client = serviceLocator<http.Client>();
  return ForYouRepository(client);
}

class ForYouRepository {
  final http.Client _client;
  final String _baseUrl = ServerConstants.forYouApiBaseUrl;

  ForYouRepository(this._client);

  Map<String, String> get _headers {
    final apiKey = dotenv.env['FOR_YOU_API_KEY'] ?? '';
    return {'X-API-Key': apiKey, 'Content-Type': 'application/json'};
  }

  /// Fetch featured items for the carousel (limited count)
  Future<Either<Failure, List<ForYouItem>>> fetchFeaturedItems({
    int limit = 4,
  }) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/items'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        final items =
            data
                .map(
                  (json) => ForYouItem.fromJson(json as Map<String, dynamic>),
                )
                .where((item) => item.isApproved && item.isFeatured)
                .toList()
              ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

        return Right(items.take(limit).toList());
      } else {
        return Left(
          Failure('Failed to fetch featured items: ${response.statusCode}'),
        );
      }
    } catch (e) {
      return Left(Failure('Failed to fetch featured items: ${e.toString()}'));
    }
  }

  /// Fetch all approved items for the "View All" page
  Future<Either<Failure, List<ForYouItem>>> fetchAllItems({
    String? searchQuery,
    String? typeFilter,
    String sortBy = 'created_at',
    bool ascending = false,
  }) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/items'),
        headers: _headers,
      );

      log(response.body.toString());

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        var items = data
            .map((json) => ForYouItem.fromJson(json as Map<String, dynamic>))
            .where((item) => item.isApproved)
            .toList();

        // Apply type filter
        if (typeFilter != null && typeFilter.isNotEmpty) {
          items = items.where((item) => item.type == typeFilter).toList();
        }

        // Apply search filter
        if (searchQuery != null && searchQuery.isNotEmpty) {
          final lowerQuery = searchQuery.toLowerCase();
          items = items.where((item) {
            return item.title.toLowerCase().contains(lowerQuery) ||
                item.author.toLowerCase().contains(lowerQuery) ||
                item.description.toLowerCase().contains(lowerQuery);
          }).toList();
        }

        // Apply sorting
        items.sort((a, b) {
          int comparison;
          switch (sortBy) {
            case 'likes':
              comparison = a.likes.compareTo(b.likes);
              break;
            case 'created_at':
              comparison = a.createdAt.compareTo(b.createdAt);
              break;
            default:
              comparison = a.likes.compareTo(b.likes);
          }
          return ascending ? comparison : -comparison;
        });

        return Right(items);
      } else {
        return Left(Failure('Failed to fetch items: ${response.statusCode}'));
      }
    } catch (e) {
      return Left(Failure('Failed to fetch items: ${e.toString()}'));
    }
  }

  /// Submit a new item for approval
  /// Returns Unit on success since unapproved items won't be visible
  Future<Either<Failure, Unit>> submitItem(
    ForYouItemSubmission submission,
  ) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/items'),
        headers: _headers,
        body: json.encode(submission.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(unit);
      } else {
        return Left(Failure('Failed to submit item: ${response.statusCode}'));
      }
    } catch (e) {
      log(e.toString());
      return Left(Failure('Failed to submit item: ${e.toString()}'));
    }
  }

  /// Increment like count for an item
  Future<Either<Failure, ForYouItem>> likeItem(String itemId) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/items/$itemId/like'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final item = ForYouItem.fromJson(data);
        return Right(item);
      } else {
        return Left(Failure('Failed to like item: ${response.statusCode}'));
      }
    } catch (e) {
      return Left(Failure('Failed to like item: ${e.toString()}'));
    }
  }

  /// Get distinct types for filtering
  Future<Either<Failure, List<String>>> fetchItemTypes() async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/items'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        final types = data
            .where((item) => item['is_approved'] == true)
            .map((json) => json['type'] as String)
            .toSet()
            .toList();

        return Right(types);
      } else {
        return Left(Failure('Failed to fetch types: ${response.statusCode}'));
      }
    } catch (e) {
      return Left(Failure('Failed to fetch types: ${e.toString()}'));
    }
  }
}
