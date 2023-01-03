import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/image_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final ImageController _imageController = Get.put(ImageController());
    final TextEditingController _imagetext = TextEditingController();



    return Scaffold(
      appBar: AppBar(
        title: Text("Open Ai",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: TextField(
                    controller: _imagetext,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type what you wish to generate",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                  ),
                ),
                ),
                const SizedBox(width: 20.0,),
               Obx(() {
                 return _imageController.isLoading.value ?
                     const Center(
                       child: CircularProgressIndicator(),
                     ) :
                   ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       elevation: 2,
                     ),
                     onPressed: () async{
                       await _imageController.getImage(imageText: _imagetext.text.trim());
                     }, child: Text("Generate"),
                   );
               })

              ],
            ),
            SizedBox(height: 30,),
          Obx(() {
            return _imageController.isLoading.value ?
                const Center(
                  child: CircularProgressIndicator(),
                ) :   Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(image: _imageController.data.value.isNotEmpty ?
                NetworkImage(_imageController.data.value)
                    : NetworkImage('https://raw.githubusercontent.com/CompVis/stable-diffusion/main/data/inpainting_examples/overture-creations-5sI6fQgYIuo.png'),
                )
              ),
            );
          })
          ],
        ),
      ),
    );
  }
}
