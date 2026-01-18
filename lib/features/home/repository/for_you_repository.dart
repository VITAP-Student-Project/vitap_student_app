import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vit_ap_student_app/core/constants/server_constants.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/features/home/model/for_you_item.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';

part 'for_you_repository.g.dart';

@riverpod
ForYouRepository forYouRepository(ForYouRepositoryRef ref) {
  final client = serviceLocator<SupabaseClient>();
  return ForYouRepository(client);
}

class ForYouRepository {
  static const String _tableName = ServerConstants.forYouSupabaseTableName;
  final SupabaseClient _client;

  ForYouRepository(this._client);

  /// Fetch featured items for the carousel (limited count)
  Future<Either<Failure, List<ForYouItem>>> fetchFeaturedItems({
    int limit = 4,
  }) async {
    try {
      final response = await _client
          .from(_tableName)
          .select()
          .eq('is_approved', true)
          .eq('is_featured', true)
          .order('display_order', ascending: true)
          .limit(limit);

      final items = (response as List)
          .map((json) => ForYouItem.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(items);
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
      var query = _client.from(_tableName).select().eq('is_approved', true);

      // Apply type filter if specified
      if (typeFilter != null && typeFilter.isNotEmpty) {
        query = query.eq('type', typeFilter);
      }

      // Apply sorting
      final response = await query.order(sortBy, ascending: ascending);

      var items = (response as List)
          .map((json) => ForYouItem.fromJson(json as Map<String, dynamic>))
          .toList();

      // Apply search filter (client-side for flexibility)
      if (searchQuery != null && searchQuery.isNotEmpty) {
        final lowerQuery = searchQuery.toLowerCase();
        items = items.where((item) {
          return item.title.toLowerCase().contains(lowerQuery) ||
              item.author.toLowerCase().contains(lowerQuery) ||
              item.description.toLowerCase().contains(lowerQuery);
        }).toList();
      }

      return Right(items);
    } catch (e) {
      return Left(Failure('Failed to fetch items: ${e.toString()}'));
    }
  }

  /// Submit a new item for approval
  /// Returns Unit on success since RLS prevents reading back unapproved items
  Future<Either<Failure, Unit>> submitItem(
      ForYouItemSubmission submission) async {
    try {
      await _client.from(_tableName).insert(submission.toJson());

      return const Right(unit);
    } catch (e) {
      log(e.toString());
      return Left(Failure('Failed to submit item: ${e.toString()}'));
    }
  }

  /// Increment like count for an item
  Future<Either<Failure, ForYouItem>> likeItem(String itemId) async {
    try {
      // Use RPC or raw SQL for atomic increment
      await _client.rpc('increment_likes', params: {
        'item_id': itemId,
      });

      // Fetch updated item
      final itemResponse =
          await _client.from(_tableName).select().eq('id', itemId).single();

      final item = ForYouItem.fromJson(itemResponse);
      return Right(item);
    } catch (e) {
      // Fallback: fetch current value and update
      try {
        final current = await _client
            .from(_tableName)
            .select('likes')
            .eq('id', itemId)
            .single();

        final newLikes = (current['likes'] as int) + 1;

        final response = await _client
            .from(_tableName)
            .update({'likes': newLikes})
            .eq('id', itemId)
            .select()
            .single();

        final item = ForYouItem.fromJson(response);
        return Right(item);
      } catch (e2) {
        return Left(Failure('Failed to like item: ${e2.toString()}'));
      }
    }
  }

  /// Get distinct types for filtering
  Future<Either<Failure, List<String>>> fetchItemTypes() async {
    try {
      final response =
          await _client.from(_tableName).select('type').eq('is_approved', true);

      final types = (response as List)
          .map((json) => json['type'] as String)
          .toSet()
          .toList();

      return Right(types);
    } catch (e) {
      return Left(Failure('Failed to fetch types: ${e.toString()}'));
    }
  }
}
