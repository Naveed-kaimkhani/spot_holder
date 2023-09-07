import 'package:http/http.dart' as http;
import 'package:spot_holder/utils/utils.dart';

class NetworkUtility{
// Future<String>? fetchUrl(Uri uri, {Map<String,String>? headers,context})async{
//   try {
//       final response= await http.get(uri,headers: headers);
//     if (response.statusCode==200) {
//         return response.body;
//     }
//   } catch (e) {
//     utils.flushBarErrorMessage("error fetching places $e", context);
    
//   }
  
//   return null;
// }
static Future<String>? fetchUrl(Uri uri, {Map<String, String>? headers, context}) async {
  try {
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      utils.flushBarErrorMessage('HTTP request failed with status: ${response.statusCode}', context);
      throw Exception('HTTP request failed with status: ${response.statusCode}');
  //  return null;
    }
  } catch (e) {
    // return null;
    utils.flushBarErrorMessage("error fetching places $e", context);
    throw Exception('Error fetching places: $e');
  }
}
}