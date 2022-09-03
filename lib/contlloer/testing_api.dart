import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import 'Model/model.dart';
class getdatahome extends GetxController{
List<modeldata>news=[];
List<modeldata>Mainnews=[];


// رقم الصفحه
int page=1;
// كود ال pagination
  // بنادي علي كود ده في زرار في صفحه تانيه
getnewdata(){
  // مينفعش اعمل كلير للداتا ال list
  //عشان كده هيمسح الصفحه الفاتت تمام
  //زي كده
  // news.clear();
// هنا بزود رقم page
page++;
// هنا بنادي علي الداتا الجديده
gethome();
// بعمل ابديت عشان يسمع تمام
  update();
}

getdatahome(){
    gethome();
  }

  Future gethome()async{
try{
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://jsonplaceholder.typicode.com/posts?_start=$page&_limit=10'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    // print(await response.stream.bytesToString());
    var body = await response.stream.bytesToString();
    var responsebody = jsonDecode(body);
print(responsebody);

    for (int x = 0; x < responsebody.length; x++) {
      news.add(modeldata.fromMap(responsebody[x]));
    }


    // for(int i=0; i<test.length;i++){
    //   test.add(homemodel.fromMap(test[i]));
    // }
  }else {

    // print(response.reasonPhrase);
  }

}catch(e){
  print(e);
}
update();
  }


}