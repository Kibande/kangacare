import 'dart:convert';
import 'package:flutter/foundation.dart';
import "package:graphql_flutter/graphql_flutter.dart";
import '../credentials_provider.dart';
import '../../util/const.dart';

class GraphQLConfiguration with ChangeNotifier {
  AuthLink authLink = AuthLink(
      getToken: () async =>
          'access-token=${CredentialsProvider.getAccesToken};refresh-token=${CredentialsProvider.getRefreshToken}');
  WebSocketLink websocketLink = WebSocketLink(
    Constants.graphQLSubscriotionsUrl,
    config: const SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 30),
      initialPayload: {
        'headers': {'Authorization': "appsub"},
      },
    ),
  );

  ValueNotifier<GraphQLClient> graphqlClient() {
    return ValueNotifier(
      clientToQuery(),
    );
  }

  GraphQLClient clientToQuery() {
    Link link = authLink
        .concat(
          HttpLink(
            Constants.graphQLEndPoinUrl,
            defaultHeaders: {
              'cookie':
                  'access-token=${CredentialsProvider.getAccesToken};refresh-token=${CredentialsProvider.getRefreshToken}'
            },
            httpResponseDecoder: (httpResponse) async {
              try {
                String tokenString = httpResponse.headers['set-cookie']!;
                if (tokenString != "") {
                  List<String> cookieParts = tokenString.split(";");
                  List<String> newCookieParts = [];
                  for (var item in cookieParts) {
                    if (item.contains('access-token') ||
                        item.contains('refresh-token')) {
                      if (item.contains('Path=/,')) {
                        item = item.split('=/,').last;
                      }
                      newCookieParts.add(item);
                    }
                  }
                  for (var item in newCookieParts) {
                    if (item.contains('access-token')) {
                      CredentialsProvider.setnewDeviceAccessToken(
                          newAccessToken: item.split('=').last);
                    }
                    if (item.contains('refresh-token')) {
                      CredentialsProvider.setnewDeviceRefreshToken(
                          newRefreshToken: item.split('=').last);
                    }
                  }
                  CredentialsProvider.findTokens();
                  // notifyListeners(); // calling notifyListeners here is resting all app states and clearing all state set data
                }
              } catch (e) {
                debugPrint(
                    "ERROR WHEN READING COOKIES ${e.toString()}, HTTP RESPONSE ${httpResponse.headers.toString()}");
                debugPrint(
                    "ERROR WHEN READING COOKIES ${e.toString()}, HTTP REQUEST ${httpResponse.request..toString()}");
              }
              return await compute(jsonDecode, httpResponse.body)
                  as Map<String, dynamic>;
            },
          ),
        )
        .concat(websocketLink);

    return GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: link,
    );
  }
}
