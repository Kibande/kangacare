class QueryMutation {
  String hello() {
    return """
    
        query hello{
                hello
          }
    
    """;
  }

  String getAllMyUnReadNotifications() {
    return """
    
        query getAllMyUnReadNotifications{
          getAllMyUnReadNotifications{
            id
            header
            title
            body
            footer
            isRead
          }
        }
    
    """;
  }

  String getAllMyNotifications() {
    return """
    
        query getAllMyNotifications{
          getAllMyNotifications{
            id
            header
            title
            body
            footer
            isRead
          }
        }
    
    """;
  }

  ///       Mutations /////

  String changePassword(
      {required String newPassword, required String oldPassword}) {
    return """
     mutation changePassword{
                 changePassword(newPassword:"$newPassword",password:"$oldPassword")
            }

    """;
  }

  String changeProfilePic({required String profilePicUrl}) {
    return """
              mutation changeProfilePic{
                      changeProfilePic(profilePicUrl:"$profilePicUrl")
                  }
        """;
  }

  String changeUserEmail(
      {required String newUserEmail, required String accountPassword}) {
    return """
     mutation changeUserEmail{
                 changeUserEmail(newUserEmail:"$newUserEmail",accountPassword:"$accountPassword")
            }

    """;
  }

  String changeUserNames(
      {required String newFirstUserName,
      required String newSecondUserName,
      required String accountPassword}) {
    return """
     mutation changeUserNames{
                 changeUserNames(newFirstUserName:"$newFirstUserName",newSecondUserName:"$newSecondUserName",accountPassword:"$accountPassword"){
            userFirstName
            userSecondName
            userEmail
            userTel
            dpImage
            phoneVerified
            emailVerified
                 }
            }

    """;
  }

  String changeUserPhoneNumber(
      {required String newUserPhoneNumber, required String accountPassword}) {
    return """
     mutation changeUserPhoneNumber{
                 changeUserPhoneNumber(newUserPhoneNumber:"$newUserPhoneNumber",accountPassword:"$accountPassword")
            }

    """;
  }

  String deleteAccount({required String accountPassword}) {
    return """
        mutation deleteAccount{
                  deleteAccount(accountPassword:"$accountPassword")
                }
        
            """;
  }

  String invalidateTokens({required String accountPassword}) {
    return """
              mutation invalidateTokens{
                      invalidateTokens(accountPassword:"$accountPassword")
                  }
        """;
  }

  String login({required String userEmailOrTel, required String password}) {
    return """
     mutation login{
                 login(userEmailOrTel:"$userEmailOrTel",password:"$password"){
            userFirstName
            userSecondName
            userEmail
            userTel
            dpImage
            phoneVerified
            emailVerified
                 }
            }

    """;
  }

  String logout() {
    return """
              mutation logout{
                  logout
                }
        """;
  }

  String me() {
    return """
        query me{
          me{
            userFirstName
            userSecondName
            userEmail
            userTel
            dpImage
            phoneVerified
            emailVerified
          }
        }
    """;
  }

  String registerUser(
      {required String userFirstName,
      required String userSecondName,
      required String userEmail,
      required String userTel,
      required String dpImage,
      required String password}) {
    return """
     mutation registerUser{
                 registerUser(userFirstName:"$userFirstName",userSecondName:"$userSecondName",userEmail:"$userEmail",userTel:"$userTel",password:"$password")

                 {
            userFirstName
            userSecondName
            userEmail
            userTel
            dpImage
            phoneVerified
            emailVerified
            
                  }
        
              }
    """;
  }

  String sendEmailVerificationCode() {
    return """
    
        mutation sendEmailVerificationCode{
                sendEmailVerificationCode
          }
    
    """;
  }

  String sendPhoneVerificationCode() {
    return """
    
        mutation sendPhoneVerificationCode{
                sendPhoneVerificationCode
          }
    
    """;
  }

  String verifyEmailverificationCode({required String verificationCode}) {
    return """
              mutation verifyEmailverificationCode{
                      verifyEmailverificationCode(verificationCode:"$verificationCode")
                  }
        """;
  }

  String verifyPhoneVerificationCode({required String verificationCode}) {
    return """
              mutation verifyPhoneVerificationCode{
                      verifyPhoneVerificationCode(verificationCode:"$verificationCode")
                  }
        """;
  }
}
