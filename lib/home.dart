import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:shop_app/model.dart';
import 'package:shop_app/recipeView.dart';
import 'searchPage.dart';
import 'package:google_fonts/google_fonts.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool isLoading = true;
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = new TextEditingController();
  String url = "https://api.edamam.com/api/recipes/v2?type=any&q=chicken&app_id=$Your_App_id&app_key=$your_Api_key";
  void getRecipe(String query)async
  {
   String url = "https://api.edamam.com/api/recipes/v2?type=any&q=$query&app_id=$Your_App_id&app_key=$your_Api_key";
   Response response = await get(Uri.parse("https://api.edamam.com/api/recipes/v2?type=any&q=$query&app_id=$Your_App_id&app_key=$your_Api_key"));
   Map data = jsonDecode(response.body);
   setState(() {
     isLoading = false;
   });

   log(data.toString());

   data["hits"].forEach((element){
     RecipeModel recipeModel = new RecipeModel();
     recipeModel = RecipeModel.fromMap(element["recipe"]);
     recipeList.add(recipeModel);
     log(recipeList.toString());
   });

   recipeList.forEach((recipe) {
     print(recipe.appCalories);
     print(recipe.appLabel);
   });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipe("biryani");
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration:const BoxDecoration(
              color: Colors.orange
            ),
          ),
          Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20,right: 15,left: 15),
                  child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(15)),

                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          if((searchController.text).replaceAll(" ","")==""){
                            print("blank search");
                          }
                          else{
                            Navigator.push(context ,MaterialPageRoute(
                              builder: (context) => searchPage(searchController.text),));
                            }
                          },
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          child: const Icon(Icons.search,color: Colors.black87,size: 35,),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: "Let's cook something..!",border: InputBorder.none),
                      )),
                    ],
                  ),
                  ),
                ),),
              const SizedBox(height: 12,),
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(left: 7),child:Text("Cook like you never cooked before...",
                                style: GoogleFonts.specialElite(
                                    textStyle:const TextStyle(color: Colors.black,fontSize: 40,fontWeight: FontWeight.bold))),),
                          ],
                        ),
                      ),
                      Container(
                        padding:const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: isLoading ? const CircularProgressIndicator(color: Colors.white,) : ListView.builder(
                          shrinkWrap: true,
                          physics:const NeverScrollableScrollPhysics(),
                          itemCount: recipeList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => RecipePage(recipeList[index].appUrl),));
                              },
                              child: Card(
                                shape:const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(26))),
                                margin:const EdgeInsets.fromLTRB(3, 10, 3, 10),
                                elevation: 0,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      child: Image.network(
                                        fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 250,
                                          recipeList[index].appImgUrl),
                                          borderRadius:const BorderRadius.all(Radius.circular(26)),
                                    ),
                                    Positioned(
                                        left: 0,
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 4),
                                          decoration:const BoxDecoration(
                                            color: Colors.black45,
                                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(26)),
                                          ),
                                          child: Text(recipeList[index].appLabel,style:const TextStyle(
                                              color: Colors.white,fontSize: 17,
                                              fontWeight: FontWeight.bold),),
                                        )),
                                    Positioned(
                                      right: 0,top: 0,
                                       height: 32,
                                       width: 95,
                                       child: Container(
                                         padding:const EdgeInsets.all(4),
                                         decoration:const BoxDecoration(
                                           color: Colors.white54,
                                           borderRadius: BorderRadius.only(topRight: Radius.circular(26),
                                               bottomLeft: Radius.circular(26)),
                                         ),
                                         child: Row(
                                           children: [
                                             const Icon(Icons.local_fire_department,
                                               color: Colors.redAccent//Color.fromRGBO(212,105,34,10),
                                              ),
                                             Text(recipeList[index].appCalories.toStringAsFixed(2),
                                               style:const TextStyle(color: Colors.black),),
                                           ],
                                         ),
                                       )),
                                  ],
                                ),
                              ),
                            );
                          },),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ],
      )
    );
  }
}
