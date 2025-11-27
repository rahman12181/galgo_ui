import 'package:http.http.dart' as http;

class AuthService {
    Future<Map<String , dynamic>> signUp(String username, String emailAddress, String password,)async{
        final url=Uri.parse("here is your backend url");

        try {
           final response=await http.post(
            url,
            body:{
                "username" : username,
                "emailAddress" : emailAddress,
                "password" : password,
            }
           );
        } catch (e) {
          return{
            "success": false,
            "message":"something went wrong: $e"
          };
        }
    }
}