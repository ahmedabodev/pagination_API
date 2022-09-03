import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:testing_alot_of_page/contlloer/testing_api.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
   // خد متغير من ميثود هنا الهو c
   final getdatahome c=Get.put(getdatahome());
   ScrollController Scroll = ScrollController();
   RefreshController _refreshController =
   RefreshController(initialRefresh: false);
   void _onRefresh() async{
     // monitor network fetch
     await Future.delayed(Duration(milliseconds: 1000));
     // if failed,use refreshFailed()
     c.getnewdata();

     _refreshController.refreshCompleted();
   }

   void _onLoading() async{
     // monitor network fetch
     await Future.delayed(Duration(milliseconds: 1000));
     // if failed,use loadFailed(),if no data return,use LoadNodata()
   c.getnewdata();
     _refreshController.loadComplete();
   }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            // هنا ناديت علي ميثود الهناك مش محتاجه جيت بليلدر عشان هنا مفيش حاجه هتتغير تمام
            c.getnewdata();
          }, icon: Icon(Icons.add))
        ],
      ),
      body: Container(
       child: GetBuilder<getdatahome>(builder: ( controller) {
         return     SmartRefresher(

           controller: _refreshController,
           onRefresh: _onRefresh,
           onLoading: _onLoading,
           enablePullUp: true,
           enablePullDown: true,
           child: ListView.builder(
             controller:Scroll ,
             itemCount: controller.news.length,
             itemBuilder: (BuildContext context, int index,) {
               return Card(
                 child: Column(
                   children: [
                     Text(controller.news[index].id.toString()),
                     Text(controller.news[index].body),
                     Text(controller.news[index].title),

                   ],
                 ),
               );
             },),
           footer: CustomFooter(

             builder: (BuildContext context, LoadStatus? mode) {
               Widget body;
               if (mode == LoadStatus.loading) {
                 body = const CircularProgressIndicator();
               } else if (mode == LoadStatus.idle) {
                 body = const Text("");
               } else if (mode == LoadStatus.failed) {
                 body = const Text("Load Failed!Click retry!");
               } else if (mode == LoadStatus.canLoading) {
                 body = const Text("release to load more");
               } else if (mode == LoadStatus.noMore) {
                 body = const Text("No more data");
               } else {
                 body = const Text("Load more");
               }
               return SizedBox(
                 height: 55.0,
                 child: Center(child: body),
               );
             },
           ),
         );

       },)
        ,
      ),
    );
  }
}
