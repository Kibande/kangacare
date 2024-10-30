import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../core/util/queries_and_muations.dart';
import '../../../../core/error/custom_exceptions.dart';
import '../../domain/entities/user.dart';
import '../models/user.dart';

abstract class UserAuthenticationRemoteDataSource {
  Future<bool> changePassword(
      {required String newPassword, required String oldPassword});

  Future<bool> changeProfilePic({required String profilePicUrl});

  Future<bool> changeUserEmail(
      {required String newUserEmail, required String accountPassword});

  Future<bool> changeUserNames(
      {required String newFirstUserName,
      required String newSecondUserName,
      required String accountPassword});

  Future<bool> changeUserPhoneNumber(
      {required String newUserPhoneNumber, required String accountPassword});

  Future<bool> deleteAccount({required String accountPassword});

  Future<bool> invalidateTokens({required String accountPassword});

  Future<User> login(
      {required String userEmailOrTel, required String password});

  Future<bool> logout();

  Future<User> me();

  Future<User> registerUser(
      {required String userFirstName,
      required String userSecondName,
      required String userEmail,
      required String userTel,
      required String dpImage,
      required String password});

  Future<bool> sendEmailVerificationCode();

  Future<bool> sendPhoneVerificationCode();

  Future<bool> verifyEmailVerificationCode({required String code});

  Future<bool> verifyPhoneVerificationCode({required String code});
}

class UserAuthenticationRemoteDataSourceImpl
    implements UserAuthenticationRemoteDataSource {
  final GraphQLClient graphqlClient;

  UserAuthenticationRemoteDataSourceImpl({required this.graphqlClient});
  // ignore: non_constant_identifier_names
  final empty_user_object = User(
      userFirstName: "Error",
      userSecondName: "Error",
      userEmail: "",
      userTel: "",
      dpImage: "",
      phoneVerified: false,
      emailVerified: false);
  @override
  Future<bool> changePassword(
      {required String newPassword, required String oldPassword}) async {
    try {
      QueryMutation queryMutation = QueryMutation();
      QueryResult result = await graphqlClient.mutate(
        MutationOptions(
          document: gql(queryMutation.changePassword(
              newPassword: newPassword,
              oldPassword:
                  oldPassword)), // this is the query string you just created
        ),
      );
      if (result.exception != null) {
        debugPrint("WE HAVE EXCEPTIONS");
      }
      if (result.hasException) {
        throw CustomeServerException(
            msg: result.exception?.graphqlErrors.toString());
      }
      if (result.data == null) {
        debugPrint("DATA WAS NULL");
        return false;
      }

      return result.data!['changePassword'];
    } on Exception catch (exception) {
      throw CustomeServerException(msg: exception.toString());
    }
  }

  @override
  Future<bool> changeProfilePic({required String profilePicUrl}) async {
    try {
      QueryMutation queryMutation = QueryMutation();
      QueryResult result = await graphqlClient.mutate(
        MutationOptions(
          document: gql(queryMutation.changeProfilePic(
              profilePicUrl:
                  profilePicUrl)), // this is the query string you just created
        ),
      );
      if (result.exception != null) {
        debugPrint("WE HAVE EXCEPTIONS");
      }
      if (result.hasException) {
        throw CustomeServerException(
            msg: result.exception?.graphqlErrors.toString());
      }
      if (result.data == null) {
        debugPrint("DATA WAS NULL");
        return false;
      }

      return result.data!['changeProfilePic'];
    } on Exception catch (exception) {
      throw CustomeServerException(msg: exception.toString());
    }
  }

  @override
  Future<bool> changeUserEmail(
      {required String newUserEmail, required String accountPassword}) async {
    try {
      QueryMutation queryMutation = QueryMutation();
      QueryResult result = await graphqlClient.mutate(
        MutationOptions(
          document: gql(
            queryMutation.changeUserEmail(
                newUserEmail: newUserEmail, accountPassword: accountPassword),
          ), // this is the query string you just created
        ),
      );
      if (result.exception != null) {
        debugPrint("WE HAVE EXCEPTIONS");
      }
      if (result.hasException) {
        throw CustomeServerException(
            msg: result.exception?.graphqlErrors.toString());
      }
      if (result.data == null) {
        debugPrint("DATA WAS NULL");
        return false;
      }

      return result.data!['changeUserEmail'];
    } on Exception catch (exception) {
      throw CustomeServerException(msg: exception.toString());
    }
  }

  @override
  Future<bool> changeUserNames(
      {required String newFirstUserName,
      required String newSecondUserName,
      required String accountPassword}) async {
    try {
      QueryMutation queryMutation = QueryMutation();
      QueryResult result = await graphqlClient.mutate(
        MutationOptions(
          document: gql(queryMutation.changeUserNames(
              newFirstUserName: newFirstUserName,
              newSecondUserName: newSecondUserName,
              accountPassword:
                  accountPassword)), // this is the query string you just created
        ),
      );
      if (result.exception != null) {
        debugPrint("WE HAVE EXCEPTIONS");
      }
      if (result.hasException) {
        throw CustomeServerException(
            msg: result.exception?.graphqlErrors.toString());
      }
      if (result.data == null) {
        debugPrint("DATA WAS NULL");
        return false;
      }

      return result.data!['changeUserNames'];
    } on Exception catch (exception) {
      throw CustomeServerException(msg: exception.toString());
    }
  }

  @override
  Future<bool> changeUserPhoneNumber(
      {required String newUserPhoneNumber,
      required String accountPassword}) async {
    try {
      QueryMutation queryMutation = QueryMutation();
      QueryResult result = await graphqlClient.mutate(
        MutationOptions(
          document: gql(queryMutation.changeUserPhoneNumber(
              newUserPhoneNumber: newUserPhoneNumber,
              accountPassword:
                  accountPassword)), // this is the query string you just created
        ),
      );
      if (result.exception != null) {
        debugPrint("WE HAVE EXCEPTIONS");
      }
      if (result.hasException) {
        throw CustomeServerException(
            msg: result.exception?.graphqlErrors.toString());
      }
      if (result.data == null) {
        debugPrint("DATA WAS NULL");
        return false;
      }

      return result.data!['changeUserNames'];
    } on Exception catch (exception) {
      throw CustomeServerException(msg: exception.toString());
    }
  }

  @override
  Future<bool> deleteAccount({required String accountPassword}) async {
    try {
      QueryMutation queryMutation = QueryMutation();
      QueryResult result = await graphqlClient.mutate(MutationOptions(
        document: gql(
          queryMutation.deleteAccount(
              accountPassword:
                  accountPassword), // this is the query string you just created
        ),
      ));
      if (result.exception != null) {
        debugPrint("WE HAVE EXCEPTIONS");
      }
      if (result.hasException) {
        throw CustomeServerException(
            msg: result.exception?.graphqlErrors.toString());
      }
      if (result.data == null) {
        debugPrint("DATA WAS NULL");
        return false;
      }

      return result.data!['deleteAccount'];
    } on Exception catch (exception) {
      throw CustomeServerException(msg: exception.toString());
    }
  }

  @override
  Future<bool> invalidateTokens({required String accountPassword}) async {
    try {
      QueryMutation queryMutation = QueryMutation();
      QueryResult result = await graphqlClient.mutate(MutationOptions(
        document: gql(
          queryMutation.invalidateTokens(
              accountPassword:
                  accountPassword), // this is the query string you just created
        ),
      ));
      if (result.exception != null) {
        debugPrint("WE HAVE EXCEPTIONS");
      }
      if (result.hasException) {
        throw CustomeServerException(
            msg: result.exception?.graphqlErrors.toString());
      }
      if (result.data == null) {
        debugPrint("DATA WAS NULL");
        return false;
      }

      return result.data!['invalidateTokens'];
    } on Exception catch (exception) {
      throw CustomeServerException(msg: exception.toString());
    }
  }

  @override
  Future<User> login(
      {required String userEmailOrTel, required String password}) async {
    try {
      QueryMutation queryMutation = QueryMutation();
      QueryResult result = await graphqlClient.mutate(
        MutationOptions(
          document: gql(
            queryMutation.login(
                userEmailOrTel: userEmailOrTel,
                password:
                    password), // this is the query string you just created
          ),
          onError: ((error) {
            throw CustomeServerException(
                msg: error?.graphqlErrors.first.message);
          }),
        ),
      );
      if (result.data == null) {
        return empty_user_object;
      }
      return UserModel.fromJson(result.data!['login']);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      QueryMutation queryMutation = QueryMutation();
      QueryResult result = await graphqlClient.mutate(MutationOptions(
        document: gql(
          queryMutation.logout(), // this is the query string you just created
        ),
      ));
      if (result.exception != null) {
        debugPrint("WE HAVE EXCEPTIONS");
      }
      if (result.hasException) {
        throw CustomeServerException(
            msg: result.exception?.graphqlErrors.toString());
      }
      if (result.data == null) {
        debugPrint("DATA WAS NULL");
        return false;
      }

      return result.data!['logout'];
    } on Exception catch (exception) {
      throw CustomeServerException(msg: exception.toString());
    }
  }

  @override
  Future<User> me() async {
    try {
      QueryMutation queryMutation = QueryMutation();
      QueryResult result = await graphqlClient.query(
        QueryOptions(
          document: gql(
              queryMutation.me()), // this is the query string you just created

          pollInterval: const Duration(seconds: 3),
          fetchPolicy: FetchPolicy.networkOnly,
          onError: ((error) {
            debugPrint(error.toString());
            throw CustomeServerException(
                msg: error?.graphqlErrors.first.message);
          }),
        ),
      );
      if (result.data == null) {
        throw CustomeServerException(msg: "No data recieved back.");
      }
      return UserModel.fromJson(result.data!['me']);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<User> registerUser(
      {required String userFirstName,
      required String userSecondName,
      required String userEmail,
      required String userTel,
      required String dpImage,
      required String password}) async {
    try {
      QueryMutation queryMutation = QueryMutation();
      QueryResult result = await graphqlClient.mutate(
        MutationOptions(
          document: gql(
            queryMutation.registerUser(
              userFirstName: userFirstName,
              userSecondName: userSecondName,
              userEmail: userEmail,
              userTel: userTel,
              dpImage: dpImage,
              password: password,
            ), // this is the query string you just created
          ),
          onError: ((error) {
            throw CustomeServerException(
                msg: error?.graphqlErrors.first.message);
          }),
        ),
      );

      if (result.data == null) {
        return empty_user_object;
      }
      return UserModel.fromJson(result.data!['registerUser']);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<bool> sendEmailVerificationCode() async {
    try {
      QueryMutation queryMutation = QueryMutation();
      QueryResult result = await graphqlClient.mutate(MutationOptions(
        document: gql(
          queryMutation
              .sendEmailVerificationCode(), // this is the query string you just created
        ),
      ));
      if (result.exception != null) {
        debugPrint("WE HAVE EXCEPTIONS");
      }
      if (result.hasException) {
        throw CustomeServerException(
            msg: result.exception?.graphqlErrors.toString());
      }
      if (result.data == null) {
        debugPrint("DATA WAS NULL");
        return false;
      }

      return result.data!['sendEmailVerificationCode'];
    } on Exception catch (exception) {
      throw CustomeServerException(msg: exception.toString());
    }
  }

  @override
  Future<bool> sendPhoneVerificationCode() async {
    try {
      QueryMutation queryMutation = QueryMutation();
      QueryResult result = await graphqlClient.mutate(MutationOptions(
        document: gql(
          queryMutation
              .sendPhoneVerificationCode(), // this is the query string you just created
        ),
      ));
      if (result.exception != null) {
        debugPrint("WE HAVE EXCEPTIONS");
      }
      if (result.hasException) {
        throw CustomeServerException(
            msg: result.exception?.graphqlErrors.toString());
      }
      if (result.data == null) {
        debugPrint("DATA WAS NULL");
        return false;
      }

      return result.data!['sendPhoneVerificationCode'];
    } on Exception catch (exception) {
      throw CustomeServerException(msg: exception.toString());
    }
  }

  @override
  Future<bool> verifyEmailVerificationCode({required String code}) async {
    try {
      QueryMutation queryMutation = QueryMutation();
      QueryResult result = await graphqlClient.mutate(MutationOptions(
        document: gql(
          queryMutation.verifyEmailverificationCode(
              verificationCode:
                  code), // this is the query string you just created
        ),
      ));
      if (result.exception != null) {
        debugPrint("WE HAVE EXCEPTIONS");
      }
      if (result.hasException) {
        throw CustomeServerException(
            msg: result.exception?.graphqlErrors.toString());
      }
      if (result.data == null) {
        debugPrint("DATA WAS NULL");
        return false;
      }

      return result.data!['verifyEmailverificationCode'];
    } on Exception catch (exception) {
      throw CustomeServerException(msg: exception.toString());
    }
  }

  @override
  Future<bool> verifyPhoneVerificationCode({required String code}) async {
    try {
      QueryMutation queryMutation = QueryMutation();
      QueryResult result = await graphqlClient.mutate(MutationOptions(
        document: gql(
          queryMutation.verifyPhoneVerificationCode(
              verificationCode:
                  code), // this is the query string you just created
        ),
      ));
      if (result.exception != null) {
        debugPrint("WE HAVE EXCEPTIONS");
      }
      if (result.hasException) {
        throw CustomeServerException(
            msg: result.exception?.graphqlErrors.toString());
      }
      if (result.data == null) {
        debugPrint("DATA WAS NULL");
        return false;
      }

      return result.data!['verifyPhoneVerificationCode'];
    } on Exception catch (exception) {
      throw CustomeServerException(msg: exception.toString());
    }
  }
}
