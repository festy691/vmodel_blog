import 'package:blog/core/network/url_config.dart';
import 'package:blog/core/schemas/add_news.dart';
import 'package:blog/core/schemas/delete_news.dart';
import 'package:blog/core/schemas/get_all_news.dart';
import 'package:blog/core/schemas/get_single_news.dart';
import 'package:blog/core/schemas/update_news.dart';
import 'package:blog/models/api_response.dart';
import 'package:blog/models/new_model.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class NewsService {

  final UrlConfig urlConfig = UrlConfig();

  Future<APIResponse> getNews({
    required bool isLocal,
  }) async {
    try {
      APIResponse _response = APIResponse();
      ValueNotifier<GraphQLClient> _client = urlConfig.getClient();

      QueryResult result = await _client.value.query(QueryOptions(
          document: gql(GetAllNewsSchema.allNewsJson),
          fetchPolicy: isLocal == true ? null : FetchPolicy.networkOnly));

      if (result.hasException) {
        _response = _handleError(result);
      } else {
        _response.status = true;
        _response.message = "Data fetched...";
        _response.data = result.data!["allBlogPosts"];
      }
      return _response;
    } catch (e) {
      rethrow;
    }
  }

  Future<APIResponse> getSingleNews({
    required String id,
  }) async {
    try {
      APIResponse _response = APIResponse();
      ValueNotifier<GraphQLClient> _client = urlConfig.getClient();

      QueryResult result = await _client.value.query(QueryOptions(
          document: gql(GetSingleNewsSchema.singleNewsJson),
          variables: {
            'blogId': id,
          },
          fetchPolicy: FetchPolicy.networkOnly));

      if (result.hasException) {
        _response = _handleError(result);
      } else {
        _response.status = true;
        _response.message = "Data fetched...";
        _response.data = result.data!["blogPost"];
      }
      return _response;
    } catch (e) {
      rethrow;
    }
  }

  Future<APIResponse> deleteNews({
    required String id,
  }) async {
    try {
      APIResponse _response = APIResponse();
      ValueNotifier<GraphQLClient> _client = urlConfig.getClient();

      QueryResult result = await _client.value.mutate(
          MutationOptions(document: gql(DeleteNewsSchema.deleteNewsJson), variables: {
            'blogId': id,
          }));

      if (result.hasException) {
        _response = _handleError(result);
      } else {
        _response.status = true;
        _response.message = "Data deleted...";
      }
      return _response;
    } catch (e) {
      rethrow;
    }
  }

  Future<APIResponse> addNews({
    required NewsModel news,
  }) async {
    try {
      APIResponse _response = APIResponse();
      ValueNotifier<GraphQLClient> _client = urlConfig.getClient();

      QueryResult result = await _client.value.mutate(
          MutationOptions(document: gql(AddNewsSchema.addNewsJson), variables: news.toJson()));

      if (result.hasException) {
        _response = _handleError(result);
      } else {
        _response.status = true;
        _response.message = "Post added...";
      }
      return _response;
    } catch (e) {
      rethrow;
    }
  }

  Future<APIResponse> updateNews({
    required String id,
    required NewsModel news,
  }) async {
    try {
      APIResponse _response = APIResponse();
      ValueNotifier<GraphQLClient> _client = urlConfig.getClient();

      var payload = news.toJson();
      payload["blogId"] = id;

      QueryResult result = await _client.value.mutate(
          MutationOptions(document: gql(UpdateNewsSchema.updateNewsJson), variables: payload));

      if (result.hasException) {
        _response = _handleError(result);
      } else {
        _response.status = true;
        _response.message = "Post updated...";
      }
      return _response;
    } catch (e) {
      rethrow;
    }
  }


  APIResponse _handleError(QueryResult result){
    APIResponse _response = APIResponse();
    _response.status = false;
    if (result.exception!.graphqlErrors.isEmpty) {
      _response.message = "Internet is not found";
    } else {
      _response.message = result.exception!.graphqlErrors[0].message.toString();
    }
    return _response;
  }
}
