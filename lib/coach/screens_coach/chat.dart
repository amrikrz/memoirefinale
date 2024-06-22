
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';




class Chat extends StatefulWidget {
  Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat>{

  bool isVisible = true,isReleased = false;
  ScrollController _Vertical = ScrollController();

  List<String> links = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzZXmKIr5mtQzhz-DS4WirJxcEPlFJ0x4adg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRvMk1gN5f9wrsdXnIhwlFE80xoU6k15Fa7A&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcTQNJX5Ck-qcTTuFgapnlOB9BAXuF_D0Nfw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4ZU1bbOVV_7VYgqsh9_A0yEMpAAWiqmvmnQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTg013L3g110jMjMVQKFXFD3wdZoEUUfdn5-g&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpatsm0jlxjiKkXTHVqFBS3edC3qOO5RH_4A&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ64EmI8qgpJf3b9z0PWXKMVXfwRx0Hlm1NvQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdqvli5kQXRDqj400XhaKR-VEE3iu91lHoCg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCjyVuvsz5YtLO_eV-bSfywfdH-an5sqAXRLvCXyhJFwY2ah04HqPqBaSbVLmAkom1ZD8&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4ZU1bbOVV_7VYgqsh9_A0yEMpAAWiqmvmnQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdqvli5kQXRDqj400XhaKR-VEE3iu91lHoCg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpatsm0jlxjiKkXTHVqFBS3edC3qOO5RH_4A&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcTQNJX5Ck-qcTTuFgapnlOB9BAXuF_D0Nfw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpatsm0jlxjiKkXTHVqFBS3edC3qOO5RH_4A&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzZXmKIr5mtQzhz-DS4WirJxcEPlFJ0x4adg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvrLhamiUurJOGc1jSyxODFjaXtBw7Y9PuFQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCjyVuvsz5YtLO_eV-bSfywfdH-an5sqAXRLvCXyhJFwY2ah04HqPqBaSbVLmAkom1ZD8&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4ZU1bbOVV_7VYgqsh9_A0yEMpAAWiqmvmnQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdqvli5kQXRDqj400XhaKR-VEE3iu91lHoCg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpatsm0jlxjiKkXTHVqFBS3edC3qOO5RH_4A&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcTQNJX5Ck-qcTTuFgapnlOB9BAXuF_D0Nfw&usqp=CAU",




  ];

  List<String> names = [
    "Oussama Berredjem",
    "Akram Serim",
    "Sabri Benabas",
    "Aymen Mhamdia",
    "Imad Halouane",
    "Amine Hamadi",
    "Aggab Massinissa",
    "Kossai Guraichi",
    "Islam Siab",
    "Djamil Boughezran",
    "Aymen Mhamdia",
    "Imad Halouane",
    "Akram Serim",
    "Sabri Benabas",
    "Kossai Guraichi",
    "Islam Siab",
    "Kossai Guraichi",
    "Islam Siab",
    "Djamil Boughezran",
    "Aymen Mhamdia",
    "Imad Halouane",


  ];


  double pastVerOf=0;

  @override
  void initState() {
    // TODO: implement initState


    _Vertical.addListener(() {
      if (_Vertical.offset != 0.0) {



        if (pastVerOf > _Vertical.offset) {
          if(!isVisible){
            setState(() {
              isVisible = true;
              isReleased = false;
            });
          }

        } else {
          // Scrolled bottom to top
          if(isVisible){
            setState(() {
              isVisible = false;
              isReleased = false;
            });
          }
        }
        pastVerOf = _Vertical.offset;

      }
    });
    super.initState();
  }



  @override
  void dispose() {
    _Vertical.dispose();
    super.dispose();
  }







  @override
  Widget build(BuildContext context) {

        return  Scaffold(

          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: Icon(Icons.messenger),
            title: Text('QChat',style: TextStyle(color:Colors.deepPurple,fontWeight: FontWeight.w500),),
            backgroundColor: Colors.grey.shade50,
            bottomOpacity: 1,
            shadowColor: Colors.transparent,
            actions: [

              Container(
                margin: EdgeInsets.only(right: 10,left: 7),
                height: 37,
                width: 37,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white70,
                ),
                child: IconButton(onPressed: (){
                  Navigator.push(context, CupertinoPageRoute(builder: (context){
                    return Chat();
                  })
                  );
                }, icon: Icon(Icons.search,size: 27,color: Colors.black,)),
              ),
              /**Container(
                  margin: EdgeInsets.only(right: 10,left: 7),
                  height: 35,
                  width: 35,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white54,
                  ),
                  child: IconButton(onPressed: (){
                  Navigator.push(context, CupertinoPageRoute(builder: (context){
                  return Search();
                  })
                  );
                  }, icon: Icon(Icons.send,size: 19,color: Colors.black,)),
                  ),**/

            ],
          ),
          body: Stack(
              children:[
                DefaultTabController(
                  initialIndex: 0,
                  length: 3,
                  child: NestedScrollView(
                    controller: _Vertical,
                    floatHeaderSlivers: true,
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {

                      return [
                        SliverAppBar(
                          floating: true,
                          backgroundColor: Colors.white54,
                          toolbarHeight: 90,
                          leadingWidth: double.infinity,


                        ),

                      ];
                    },
                    body: Column(
                      children: [
                        PreferredSize(

                          preferredSize: Size.fromHeight(50),
                          child: Container(
                            color: Colors.transparent,
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xfffaf6f6),
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                              ),
                              child: TabBar(
                                tabs: [
                                  Text("Duscussion",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 12),),
                                  Text("Groupes",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 12),),
                                  Text("Channel",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 12),),

                                ],

                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [

                              Container(
                                color: Color(0xfffaf6f6),
                                padding: EdgeInsets.only(bottom: 6),
                                child: ListView.builder(
                                    itemCount:links.length,
                                    itemBuilder: (context,index){

                                      return  CupertinoContextMenu(
                                        actions: [
                                          CupertinoContextMenuAction(child: Text("Reponder")),
                                          CupertinoContextMenuAction(child: Text("Remove")),
                                          CupertinoContextMenuAction(child: Text("share")),

                                        ],
                                        child: Material(

                                          child: DecoratedBox(
                                            decoration: BoxDecoration(color: Colors.grey.shade100),
                                            child: Container(
                                             constraints: BoxConstraints(
                                               maxWidth: MediaQuery.of(context).size.width*0.95,
                                               maxHeight: 73
                                             ),

                                              height: 69,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(bottom: 7),
                                              child: ListTile(

                                                onTap: (){
                                                  //Navigator.push(context,CupertinoPageRoute(builder: (context)=>Conversation()));
                                                },
                                                leading: Container(
                                                  margin: EdgeInsets.only(left: 5),
                                                  height: 55,
                                                  width: 55,
                                                  child: CircleAvatar(
                                                    backgroundImage: NetworkImage(links[index]),
                                                  ),
                                                ),
                                                title: Text(names[index],style: TextStyle(fontWeight: FontWeight.bold),),
                                                subtitle: Text("hy i'm ${index+1}"),
                                                trailing: Text("",style: TextStyle(color: Colors.green),),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                Positioned(
                  bottom: 38,right: 15,

                  child:!isVisible?SizedBox():FloatingActionButton(
                      backgroundColor: Color(0xFF9c6de7),
                      onPressed: () async{

                       // BlocProvider.of<BlocChat>(context).listen("1");


                        /**  final images = await _picker.openPicker(
                            // Properties
                            cropping: true,
                            pickerOptions: HLPickerOptions(
                            enablePreview: true,
                            maxSelectedAssets: 5,

                            ),

                            );

                            _selectedImages = images;


                            showBottomSheet(context: context,enableDrag: true, builder: (context){
                            return Column(
                            children:List.generate(_selectedImages.length, (index) => Image.file(File(_selectedImages[index].path.toString()),)),
                            );
                            });**/

                        /*
                      showCupertinoDialog(context: context, builder: (context){
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: CupertinoAlertDialog(
                            title: Text('Alert Title'),
                            content: Text('This is the content of the alert dialog.'),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      });
                      */





                      },
                      child: Icon(Icons.add,color: Colors.white70,),
                    ),



                )]),
        );
  }




}
