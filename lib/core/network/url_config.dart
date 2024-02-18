import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

enum Environment { development, staging, qa, production }

class UrlConfig {
  static Environment environment = Environment.staging;

  static const String STAGING_URL =
      "https://uat-api.vmodel.app/graphql/";
  static const String PRODUCTION_URL =
      "https://uat-api.vmodel.app/graphql/";

  static final coreBaseUrl =
  environment == Environment.production ? PRODUCTION_URL : STAGING_URL;

  static final String URL = environment == Environment.production
      ? PRODUCTION_URL
      : STAGING_URL;

  ValueNotifier<GraphQLClient> getClient(){
    log("Getting Client");
    ValueNotifier<GraphQLClient> _client = ValueNotifier(
        GraphQLClient(
          link: HttpLink(URL),

          cache: GraphQLCache(store: HiveStore()),
        )
    );

    return _client;
  }
}