import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tradpool/App/app.dart';

import 'package:tradpool/Core/Consts.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/features/home/data/model/faq_model.dart';
import 'package:tradpool/features/home/presentation/bloc/home_bloc.dart';


import 'package:tradpool/features/login/presentation/pages/login.dart';
import 'package:tradpool/features/settings/presentation/widgets/add_preferences.dart';
import 'package:tradpool/features/settings/presentation/widgets/user_preferences.dart';
import 'package:tradpool/features/settings/presentation/widgets/winned_ads.dart';

import '../../../../Widgets/container.dart';
import '../../../../Widgets/default_app_bar.dart';
import '../../../../injection_container.dart';
import '../../../notifications/presentation/pages/notifications.dart';
import '../../../search/presentation/pages/search.dart';
import '../widgets/faq.dart';
import '../widgets/support_requests.dart';


class Profile extends StatefulWidget {
 const Profile({Key key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
} 

class _ProfileState extends State<Profile> {
 List< FaqModel> faqModel = [];
  HomeBloc homeBloc = sl<HomeBloc>();

@override
  void initState() {
    homeBloc.add(GetFAQEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      var size =  MediaQuery.of(context).size;
    return Scaffold(
           floatingActionButton:  BlocBuilder(
             bloc : homeBloc,
             builder: (context, state) {
               if (state is GetFAQState){
               
                 faqModel=state.faqModel;
               }
               return FloatingActionButton(
                 child: const Icon(Icons.question_mark,color: Colors.white,),
                 backgroundColor: 
      Colors.grey,
                   // Menu items
                  onPressed: (){
              nav(context, FAQ(faqModel: faqModel,));
                    },
                  
                 );
             },
           ),
      appBar: PreferredSize(preferredSize: Size.fromHeight(h(120),), child:       SizedBox(
        height: h(120),
        child:    SizedBox(height: h(40),
        width: w(300),
          child:const DefaultAppBar()),
      ),),
      body: SizedBox(
              width: size.width,
              height: size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: h(70),),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Row(
                                //   children: [
                                //     SizedBox(width: size.width * 0.07),
                                //     Padding(
                                //       padding:
                                //           EdgeInsets.only(top: 16, bottom: 3),
                                //       child: Text(
                                //         "name",
                                //         style: TextStyle(
                                //             fontSize: 30,
                                //             color: AppColor.blue,
                                //             fontWeight: FontWeight.bold),
                                //         textAlign: TextAlign.center,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // Row(
                                //   children: [
                                //     SizedBox(width: size.width * 0.07),
                                //     Padding(
                                //       padding:
                                //           EdgeInsets.only(top: 3, bottom: 16),
                                //       child: Text(
                                //         "emmail",
                                //         style: TextStyle(
                                //             fontSize: 15, color: AppColor.blue),
                                //         overflow: TextOverflow.ellipsis,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                Container(
                                  width: size.width * 0.5,
                                  height: size.height * 0.0007,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.3,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: size.width * 0.069),
                            
                                    SizedBox(width: size.width * 0.029),
                       
                
                                  ],
                                ),
                              ],
                            )
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: size.width * 0.8,
                        child: Column(
                          children: [
                           
               
                 
                        
                            ]  ),
                      ),
                    ),
              
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: size.width * 0.8,
                          child: Column(
                            children: [
                              GestureDetector(onTap: (){
                                nav(context, WinnedAds());
                              },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 8, right: 16, top: 8, bottom: 8),
                                      child: SvgPicture.asset(
                                        "assets/images/invite.svg",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      width: size.width * 0.55,
                                      child: Text(
                                        'Winned Ads',
                                        style: TextStyle(
                                            fontSize: 14.sp, color: AppColor.blue),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: AppColor.blue,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(
                                indent: 8,
                                endIndent: 8,
                              ),
                              GestureDetector(onTap:(){

                  
                              }
                            ,
                                child: GestureDetector(onTap: (){
                                  nav(context, SupportRequests());
                                },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 16,
                                            top: 8,
                                            bottom: 8),
                                        child: SvgPicture.asset(
                                          "assets/images/support.svg",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.55,
                                        child: Text(
                                          'Support Requests',
                                          style: TextStyle(
                                              fontSize: 14.sp, color: AppColor.blue),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: AppColor.blue,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                indent: 8,
                                endIndent: 8,
                              ),
                         
                                 GestureDetector(onTap: (){
                                   nav(context, const AddUserPreferences());
                                 },
                                   child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 16,
                                            top: 8,
                                            bottom: 8),
                                        child: SvgPicture.asset(
                                          "assets/images/rate.svg",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Container(
                                        width: size.width * 0.55,
                                        child: Text(
                                          'Add Preferences',
                                          style: TextStyle(
                                              fontSize: 14.sp, color: AppColor.blue),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: AppColor.blue,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                                                 ),
                                 ),
                              
                              const Divider(
                                indent: 8,
                                endIndent: 8,
                              ),
                              GestureDetector(
                                onTap: (){
                                  nav(context, const UserPreferences());
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8,
                                          right: 16,
                                          top: 8,
                                          bottom: 8),
                                      child: SvgPicture.asset(
                                        "assets/images/suggest.svg",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.55,
                                      child: Text(
                                        'Your Preferences',
                                        style: TextStyle(
                                            fontSize: 14.sp, color: AppColor.blue),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: AppColor.blue,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h(40),
                    ),
                    GestureDetector(onTap: (){
                      navWithReplaceAll(context,const Login());
                    },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: size.height * 0.05,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                border: Border.all(color: AppColor.blue)),
                            child: Center(
                              child: Text(
                                "LOG OUT",
                                style: TextStyle(
                                    color: AppColor.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
   
  }
}