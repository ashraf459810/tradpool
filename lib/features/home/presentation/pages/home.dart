import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/Core/Consts.dart';
import 'package:tradpool/Widgets/carousel_pro.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/custom_list_view.dart';
import 'package:tradpool/Widgets/default_app_bar.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/features/auction_details/presentation/pages/auction_details.dart';
import 'package:tradpool/features/home/data/model/home_page_model.dart';
import 'package:tradpool/features/home/data/model/support_type_model.dart';
import 'package:tradpool/features/home/presentation/bloc/home_bloc.dart';
import 'package:tradpool/features/home/presentation/widgets/list_view_item_widget.dart';
import 'package:tradpool/features/home/presentation/widgets/support_widget.dart';
import 'package:tradpool/features/notifications/presentation/bloc/notifications_bloc.dart' ;

import 'package:tradpool/features/search/presentation/pages/search.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../App/app_localizations.dart';
import '../../../../injection_container.dart';



class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>  with SingleTickerProviderStateMixin {
     final  notificationsBloc= sl<NotificationsBloc>() ;
 SharedPreferences sharedPreferences = sl<SharedPreferences>();
    Animation<double> _animation;
  AnimationController _animationController;
  bool faviourite = false;
  TextEditingController searchc = TextEditingController();
  String search;
  ScrollController scrollController = ScrollController();
  bool scroll = false;
  int speedFactor = 20;
  List<TrendingBrand> trendingBrands  = [];
    int page = 0;
  int size = 10;
  List<HeaderElement> sliders = [];
  String notificationCount;
  List<SupportTypeModel> list= [];
  // List<HomeAuctions> homeAuctions = [];
  List<AboutToFinish> topAuctions = [];
  
 List<AboutToFinish> auctionsMayLike = [];

 List<AboutToFinish> auctionsAboutToFinish = [];

  @override
  void initState() {
               log(
                 sharedPreferences.getString("notificationCounter"));
    
    timer();  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (context) => sl<HomeBloc>()..add(GetHomePageEvent()),
        child:
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
              
                if (state is GetHomePageState) {
                  
                      
            sharedPreferences.setString("notificationCounter",state.homePageModel.notificationCounter.toString());
                notificationCount = state.homePageModel.notificationCounter.toString();
                  trendingBrands = state.homePageModel.trendingBrand;
                  topAuctions = state.homePageModel.topBoutiques;
                  auctionsAboutToFinish = state.homePageModel.aboutToFinish;
                  auctionsMayLike = state.homePageModel.matchPreferences;
                  sliders = state.homePageModel.headerElements;
                context.read<HomeBloc>().add(const SupportTypeEvent('request_assistance_types'));
                               
                }
                return 
         Scaffold(
           
           
           floatingActionButton:  BlocBuilder<HomeBloc, HomeState>(
             builder: (context, state) {
               if (state is SupportTypeState){
                 log('here from support state ');
                 list = state.supportTypeModel;
          notificationsBloc.add(NotificationRingEvent(notificationCount));
                 
               }
               
               return FloatingActionButton(
                 child: const Icon(Icons.support_agent),
                 backgroundColor: 
                 AppColor.blue,
                   // Menu items
                  onPressed: (){nav(context, Support(supportType: list,));},
                  
                 );
             },
           ),
    
          body: ListView(shrinkWrap: true, children: [
              SizedBox(
                height: h(40),
              ),
        SizedBox(height: h(40),
        width: w(300),
          child: DefaultAppBar()),
            SizedBox(
              height: h(25),
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
        
                return sliders.isNotEmpty? SizedBox(
                          height: h(250),
                          width: w(300),
                          child: Carousel(
                            autoplay: true,
                            showIndicator: true,
            
                            moveIndicatorFromBottom: 0,
                            dotSize: h(5),
                            indicatorBgPadding: 0,
            
                            // dotColor: AppColor.blue,
                            borderRadius: true,
            
                            // dotSize: 10.sp,
                            images:
                    sliders.isNotEmpty?       sliders
                        .map((item) => Stack(
                          children: [
                            Image.network(
                   item.attachments[0].publicUrl,
                   fit: BoxFit.fitHeight,
                   height: h(250),
                
                                ),
                                Positioned(
                                  bottom: h(5),
                                  left: w(10),
                                  child: GestureDetector(onTap: () async {
                                          await launch(
                            "https://"+ item.website,
                            universalLinksOnly: true,
                          );
                                },child: container(color: Colors.black,hight: h(40),width: w(80),borderRadius: 5,child: text(text:  AppLocalizations.of(context).translate('Visit website'),color: Colors.white,fontsize: 11.sp)))),

                                                                  Positioned(
                                  bottom: h(15),
                                  right: w(10),
                                  child:Row(children: [
                             item.facebookLink !=null?       GestureDetector(onTap:()async{
                                
                                
            String fbProtocolUrl;
if (Platform.isIOS) {
  fbProtocolUrl = 'fb://profile/${item.facebookLink}';
} else {
  fbProtocolUrl = 'fb://page/${item.facebookLink}';
 
}

String fallbackUrl = 'https://'+ item.facebookLink;


try {
  bool launched = await launch(fbProtocolUrl, forceSafariVC: false);

  if (!launched) {
    await launch(fallbackUrl, forceSafariVC: false);
  }
} catch (e) {
  await launch(fallbackUrl, forceSafariVC: false);
}

                             },
                               child: const Icon(Icons.facebook,color:Colors.blue)):const SizedBox(),
                                    SizedBox(width: w(5),),
                                     item.whatsappNumber !=null?            GestureDetector(
                                       onTap:() async{
                                             var whatsapp = item.whatsappNumber;
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=";
      if( await canLaunch(whatsappURl_android)){
        await launch(whatsappURl_android);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));
      }
                                          // launch('tel:${item.whatsappNumber}');
                                       },
                                       child: const Icon(Icons.whatsapp,color:Colors.green)):const SizedBox(),
                                                             SizedBox(width: w(5),),
                                                  item.instagramLink!=null?            GestureDetector(
                                                    onTap: () async{      
                                                                 if (await canLaunch("https://"+ item.instagramLink)) {
                          await launch(
                            "https://"+ item.instagramLink,
                            universalLinksOnly: true,
                          );
                        } else {
                      
                           await launch("https://"+ item.facebookLink,forceWebView: true);
                        }
                                                         
                                                         
                                                         } ,
                                                    child: const Icon(Icons.camera_alt_outlined,color:Colors.purple)):const SizedBox(),

                                  ],)
                                  )
                          ],
                        ))
                        .toList():[],
              
                          ),
                        ):SizedBox();
              },
            ),
            SizedBox(
              height: h(30),
            ),
            Row(
              children: [
                SizedBox(
                  width: w(10),
                ),
                text(
                    text: "Trending Brands",
                    fontsize: 31,
                    color: AppColor.darkBlue),
              ],
            ),
            SizedBox(
              height: h(5),
            ),
            Row(
              children: [
                SizedBox(
                  width: w(10),
                ),
                text(
                    text: "Explore the best selling brands",
                    fontsize: 15,
                    color: AppColor.hintcolor),
              ],
            ),
            SizedBox(
              height: h(10),
            ),
            SizedBox(
              height: h(80),
              child: Padding(
                padding: EdgeInsets.all(h(8)),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                  
                    itemCount: trendingBrands.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Padding(
                        padding:  EdgeInsets.symmetric(horizontal: w(10)),
                        child: GestureDetector(onTap: (){
                          nav(context, Search(trendingBrand:trendingBrands[index],));
                        },
                          child: Card(
                            child: container(
                              borderRadius: 15,
                             hight: h(20),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: text(text: trendingBrands[index].brand.name ,fontsize: 12.sp,color: AppColor.blue),
                              ),
                            // borderRadius: 15
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
       
            SizedBox(
              height: h(20),
            ),
            Row(
              children: [
                SizedBox(
                  width: w(10),
                ),
                text(text: "Top 10", fontsize: 31, color: AppColor.darkBlue),
              ],
            ),
            SizedBox(
              height: h(5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                text(
                    text: "Explore the top 10 boutique on Tradpool",
                    fontsize: 15.sp,
                    color: AppColor.hintcolor),
                SizedBox(
                  width: w(40),
                ),
    
              ],
            ),
            SizedBox(
              width: w(10),
            ),
            SizedBox(
              height: h(20),
            ),
        topAuctions.isNotEmpty
                    ? NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification is ScrollEndNotification &&
                              scrollController.position.extentAfter == 0) {
                          
                            page++;

                            context
                                .read<HomeBloc>()
                                .add(GetAuctionsEvent(page, size));
                          }

                          return false;
                        },
                        child: customlistview(
                            controller: scrollController,
                            direction: "horizon",
                            hight: h(280),
                            scroll: true,
                            itemcount: topAuctions.length,
                            padding: 1,
                            width: MediaQuery.of(context).size.width,
                            function: (context, index) {
                              return InkWell(
                                  onTap: () {
                        
                                    nav(
                                        context,
                                        AuctionDetails(
                                          auctionId: topAuctions[index].id,
                                        ));
                                  },
                                  child: ListViewSample(
                                    tags: topAuctions[index].tags,
                                  liked:topAuctions[index].liked,
                                    fixedPrice: topAuctions[index]
                                              .fixedPrice !=null? topAuctions[index]
                                              .fixedPrice.toString()
                                              :"_",
                                    id: topAuctions[index].id,
                                    viewers: topAuctions[index]
                                              .viewers.toString(),
                                    location: topAuctions[index]
                                              .location,
                                      image: topAuctions[index]
                                              .attachments
                                              .isNotEmpty
                                          ? topAuctions[index]
                                              .attachments[0]
                                              .publicUrl
                                          : null,
                                      brand: "",
                                      category: topAuctions[index].mainCategory.name
                                              
                                        ,
                                      name: topAuctions[index].subCategory.name,
                                      note: "",
                                      price:  topAuctions[index]
                                          .lastPrice!= null ?  topAuctions[index]
                                          .lastPrice
                                          .toString() :"_",
                                      timeToFinish: Duration(
                                        days:  int.parse( topAuctions[index].timeToEnd.split(':')[0] ),
                                          hours:
                                             int.parse( topAuctions[index].timeToEnd.split(':')[1]),
                                          minutes:  int.parse( topAuctions[index].timeToEnd.split(':')[2])
                                              ),
                                      adsType:
                                          topAuctions[index].sellType));
                            }))
                    : container(
                        hight: h(300),
                        width: w(300),
                        child: text(
                            text: "Sorry No Auctions Added",
                            fontsize: 16.sp,
                            color: Colors.tealAccent[700])),
              
            
            SizedBox(
              height: h(10),
            ),
            Row(
              children: [
                SizedBox(
                  width: w(10),
                ),
                text(
                    text: "Last Chance",
                    fontsize: 31,
                    color: AppColor.darkBlue),
              ],
            ),
            SizedBox(
              height: h(5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                text(
                    text: "Explore Auctions about to finish",
                    fontsize: 15.sp,
                    color: AppColor.hintcolor),
                SizedBox(
                  width: w(100),
                ),
         
              ],
            ),
            SizedBox(
              height: h(10),
            ),
            customlistview(
                padding: 1,
                controller: ScrollController(),
                direction: "horizon",
                itemcount: auctionsAboutToFinish.length,
                hight: h(280),
                width: w(330),
                scroll: true,
                function: (context, index) {
                  return auctionsAboutToFinish.isNotEmpty? GestureDetector(
                    onTap: () {
                      nav(context, AuctionDetails(auctionId: auctionsAboutToFinish[index].id,));
                    },
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: w(5)),
                        child:  ListViewSample(
                          tags: auctionsAboutToFinish[index].tags,
                          liked: auctionsAboutToFinish[index].liked,
                          fixedPrice:  auctionsAboutToFinish[index]
                                              .fixedPrice !=null? auctionsAboutToFinish[index]
                                              .fixedPrice.toString()
                                              :"_",
                          id:  auctionsAboutToFinish[index].id,
                                    viewers: auctionsAboutToFinish[index]
                                              .viewers.toString(),
                                    location: auctionsAboutToFinish[index]
                                              .location,
                                      image: auctionsAboutToFinish[index]
                                              .attachments
                                              .isNotEmpty
                                          ? auctionsAboutToFinish[index]
                                              .attachments[0]
                                              .publicUrl
                                          : null,
                                      brand: "",
                                      category: auctionsAboutToFinish[index].mainCategory.name
                                              
                                        ,
                                      name: auctionsAboutToFinish[index].subCategory.name,
                                      note: "",
                                      price:  auctionsAboutToFinish[index]
                                              .lastPrice !=null? auctionsAboutToFinish[index]
                                              .lastPrice.toString()
                                              :"_",
                                      timeToFinish: Duration(
                                        days:  int.parse( auctionsAboutToFinish[index].timeToEnd.split(':')[0] ),
                                          hours:
                                             int.parse( auctionsAboutToFinish[index].timeToEnd.split(':')[1]),
                                          minutes:  int.parse( auctionsAboutToFinish[index].timeToEnd.split(':')[2])
                                              ),
                                      adsType:
                                          auctionsAboutToFinish[index].sellType)),
                  ):const SizedBox();
                }),
          
          
            SizedBox(
              height: h(12),
            ),
            Row(
              children: [
                SizedBox(
                  width: w(10),
                ),
                text(
                    text: "Auctions you may like",
                    fontsize: 31.sp,
                    color: AppColor.darkBlue),
              ],
            ),
            SizedBox(
              height: h(5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: w(15),),
                text(
                    text: "Explore new auction",
                    fontsize: 15.sp,
                    color: AppColor.hintcolor),
          
                
              ],
            ),
            SizedBox(
              height: h(10),
            ),
            customlistview(
                padding: 1,
                controller: ScrollController(),
                direction: "horizon",
                itemcount: auctionsMayLike.length,
                hight: h(280),
                width: w(330),
                scroll: true,
                function: (context, index) {
                  return auctionsMayLike.isNotEmpty? GestureDetector(
                    onTap: () {
                      nav(context, AuctionDetails(auctionId: auctionsMayLike[index].id,));
                    },
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: w(5)),
                        child:  ListViewSample(
                          tags: auctionsMayLike[index].tags,

liked: auctionsMayLike[index].liked,
                          fixedPrice:  auctionsMayLike[index]
                                              .fixedPrice !=null? auctionsMayLike[index]
                                              .fixedPrice.toString()
                                              :"_",
                      
                          id: auctionsMayLike[index].id,
                                    viewers: auctionsMayLike[index]
                                              .viewers.toString(),
                                    location: auctionsMayLike[index]
                                              .location,
                                      image: auctionsMayLike[index]
                                              .attachments
                                              .isNotEmpty
                                          ? auctionsMayLike[index]
                                              .attachments[0]
                                              .publicUrl
                                          : null,
                                      brand: "",
                                      category: auctionsMayLike[index].mainCategory.name
                                              
                                        ,
                                      name: auctionsMayLike[index].subCategory.name,
                                      note: "",
                                      price:  auctionsMayLike[index]
                                              .lastPrice !=null? auctionsMayLike[index]
                                              .lastPrice.toString()
                                              :"_",
                                      timeToFinish: Duration(
                                        days:  int.parse( auctionsMayLike[index].timeToEnd.split(':')[0] ),
                                          hours:
                                             int.parse( auctionsMayLike[index].timeToEnd.split(':')[1]),
                                          minutes:  int.parse( auctionsMayLike[index].timeToEnd.split(':')[2])
                                              ),
                                      adsType:
                                          auctionsMayLike[index].sellType)),
                  ):const SizedBox();
                }),
          
          
         
          ]),
                );})
    );}
      void timer() {
    Future.delayed(const Duration(seconds: 10)).then((_) {
      if (mounted) {
        setState(() {
          sl<HomeBloc>().add(GetHomePageEvent());
          // Anything else you want
        });
        timer();
      }
    });
  }

}


