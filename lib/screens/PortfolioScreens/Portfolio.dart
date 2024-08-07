import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/Providers/NavBarProvider.dart';
import 'package:portfolio/Utils/text.dart';
import 'package:portfolio/constants/Color.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

import '../../constants/FontSize.dart';
import '../../constants/FontWeights.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({Key? key}) : super(key: key);

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> with TickerProviderStateMixin{
  late AnimationController controller;
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> myAnimation;

  String currentYear = '2023';

  ScrollController _scrollController = ScrollController();

  // Create GlobalKeys for each section
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey portfolioKey = GlobalKey();
  final GlobalKey letsTalkKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    _scrollController.animateTo(
      position.dy,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  String getCurrentYear() {
    DateTime now = DateTime.now();
    return now.year.toString();
  }

  String startingYear = '2023';
  @override
  void initState() {
    super.initState();
    currentYear = getCurrentYear();
    _controller = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(
      begin: 1.0,
      end: -1.0,
    ).animate(_controller);


    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    myAnimation = Tween<double>(begin: 37.5, end: 50.0).animate(controller);
  }
  void _hover(bool isHovered) {
    if (isHovered) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    controller.dispose();
    super.dispose();
  }
  bool isSentMessage = false;
  @override
  Widget build(BuildContext context) {
    final navBarProvider = Provider.of<NavBarProvider>(context,listen: true);
    final provider = Provider.of<NavBarProvider>(context,listen: true);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  key: homeKey,
                  width: w,
                  height: h*0.91,
                  color: purple,
                  child : Row(
                    crossAxisAlignment:CrossAxisAlignment.center ,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Container(
                          width: w*0.027,
                          height: h*0.2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width:w*0.5,
                                height: h*0.4,
                                child: SvgPicture.asset('ciao.svg',fit: BoxFit.contain,)),
                            SizedBox(height: h*0.03,),
                            textRoboto("I'm Zakriya", textColor, w800, sizeX),
                            SizedBox(height: h*0.012,),
                            textRoboto("Mobile & Web Application Developer", textColor, w500, size28),
                          ],
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        Container(
                          margin: EdgeInsets.only(right: w*0.02,bottom: w*0.02),
                          width: 130,
                          height: 130,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Icon(Icons.arrow_downward,color: textColor,weight: 20,size: 60,),
                              ),
                              AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: _controller.value * 2 * math.pi,
                                  child: child,
                                );
                              },
                              child: SvgPicture.asset(
                                'scroll-badge.svg', // Make sure to add your SVG asset here
                                width: 130,
                                height: 130,
                              ),
                      ),
                            ],
                          ),
                        ),
                        ],
                      )
                    ],
                  )
                ),

                experienceContainer(w,h),

                Container(
                  key: portfolioKey,
                  width: w,
                  padding: EdgeInsets.only(top: 80,bottom: 80),
                  decoration: BoxDecoration(
                    border:Border(top: BorderSide(color: textColor,width: 4),bottom: BorderSide(color: textColor,width: 4)),
                    color: purple,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      textRoboto('PORTFOLIO', textColor, w700, sizeX+20),
                      SizedBox(height: 50,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          portfolioContainer(
                              provider, 'Asaan Makaan',
                              "Asaan Makaan is a mobile application designed to simplify the process of finding and listing real estate properties.",
                              "• Search for properties based on location, price, and other filters.\n• Detailed property listings with images and descriptions.\n• User profiles for buyers and sellers.\n• Integrated chat for buyer-seller communication"
                              ,'mockup2.png', 0),
                          SizedBox(width: 35,),
                          portfolioContainer(provider, 'URL2Go', 'URL2Go is a web application designed to simplify the process of saving and managing URLs, allowing users to easily organize and access their favorite links.',
                              "• Save URLs with custom titles and descriptions.\n• Categorize links for better organization.\n• Creates an organization, access other people's shared urls, direct communication or chatting and sharing.\n• Quick search and filter options to find saved URLs",
                              'mockup3Web.png',1),
                        ],
                      ),
                      SizedBox(height: 30,),
                      portfolioContainer(provider,  'Anonymous Chat App', "Anonymous Chat App is a mobile application that enables users to engage in group and private chats without the need for account creation or personal information, promoting privacy and ease of use.",
                          "• Users can enter the app and join groups without any registration, email, or password. All users are identified as 'Visitor'.\n• Tapping on any user's message within a group initiates a private chat between the two users, maintaining anonymity and privacy.\n• Only admins can create groups, ensuring organized and structured group chats.",
                          'mockup1.png',2),

                      SizedBox(height: 50,),
                      letsTalkContainer(w),
                      contactContainer(w),
                      // SizedBox(height: 40,),
                      copyrightContainer(w)
                    ],
                  ),
                )

              ],
            ),
          ),
         if(isSendingMessage) Align(alignment: Alignment.center,
          child: LottieBuilder.asset('loadingAnimation.json',animate: true,alignment: Alignment.center,width: 300,height: 300,),
          ),
          if(isSentMessage) Align(alignment: Alignment.center,
          child: LottieBuilder.asset('winAnimation.json',animate: true,alignment: Alignment.center,width: 300,height: 300,),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child:       InkWell(
              onTap:()async{
                try{

                    await launchUrl(Uri.parse('assets/resume.pdf'));

                }
                catch(e){
                  print(e.toString());
                }

              },
              child: Container(
                width: w*0.027,
                height: h*0.2,
                decoration: BoxDecoration(
                  color: white,
                  border: Border.all(color: textColor,width: 5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset('pdf.svg',width: 40,height: 40,),
                    RotatedBox(
                        quarterTurns: 3,
                        child: textRoboto('Resume', textColor, w500, size16))
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment:Alignment.topCenter,
            child:                 Container(
              width: w,
              height: h*0.09,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: textColor,width: 2)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: white,
                    width:w*0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        navBarButton(navBarProvider, 'Home'),
                        navBarButton(navBarProvider, 'Experience'),
                        navBarButton(navBarProvider, 'Portfolio'),
                        navBarButton(navBarProvider, "Let's Talk"),
                        navBarButton(navBarProvider, 'Contact'),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(right: w*0.03),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) => _hover(true),
                            onExit: (_) => _hover(false),
                            child: AnimatedBuilder(
                                animation: myAnimation,
                                builder: (context, child) =>
                                    InkWell(
                                        onTap:()async{
                                          try{
                                            await launchUrl(Uri.parse('https://www.fiverr.com/zakriyamateen'));
                                          }
                                          catch(e){
                                            print(e.toString());
                                          }
                                        },
                                        child: Image.asset('fiverrIcon.png', color:textColor,width: myAnimation.value-10,height:  myAnimation.value-10,))))
                      ],
                    ),
                  )
                ],
              ),
            ),

          )

        ],
      ),
    );
  }
  bool isSendingMessage = false;

  Widget contactContainer(double w){
    return     Container(
      key: contactKey,
      width: w,
      padding: EdgeInsets.symmetric(vertical: 70),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color:textColor,width:2)),
          color:purple
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          textRoboto("CONTACT", textColor, w700, sizeX+20),
          SizedBox(height: 50,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 400,
                height: 300,
                decoration: BoxDecoration(
                    color: yellow,
                    border: Border.all(color:textColor,width:4)
                ),
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.all(40),
                        decoration: BoxDecoration(
                            color: purple,
                            shape: BoxShape.circle,
                            border: Border.all(color:textColor,width: 3)
                        ),
                        child: Icon(Icons.call,color: yellow,size: size40,)),
                    SizedBox(height: 25,),
                    InkWell(
                        onTap: ()async{
                          try{
                            final Uri phoneUri = Uri.parse('tel:+923161451031'); // Include country code
                            if (await canLaunch(phoneUri.toString())) {
                              await launchUrl(phoneUri);
                            } else {
                              throw 'Could not launch $phoneUri';
                            }                                         }
                          catch(e){
                            print(e.toString());
                          }
                        },
                        child:
                        textRoboto("(+92) 316 1451031" , textColor, w500, size18)

                    ),
                    SizedBox(height: 3,),
                    InkWell(
                        onTap: ()async{
                          try{
                            final Uri phoneUri = Uri.parse('tel:+923154067544'); // Include country code
                            if (await canLaunch(phoneUri.toString())) {
                              await launchUrl(phoneUri);
                            } else {
                              throw 'Could not launch $phoneUri';
                            }                                         }
                          catch(e){
                            print(e.toString());
                          }
                        },
                        child:

                        textRoboto("(+92) 315 4067544", textColor, w500, size18)
                    ),
                  ],
                ),
              ),
              SizedBox(width: 70,),
              Container(
                width: 400,
                height: 300,
                decoration: BoxDecoration(
                    color: yellow,
                    border: Border.all(color:textColor,width:4)
                ),
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.all(40),
                        decoration: BoxDecoration(
                            color: purple,
                            shape: BoxShape.circle,
                            border: Border.all(color:textColor,width: 3)
                        ),
                        child: Icon(Icons.alternate_email,color: yellow,size: size40,)),
                    SizedBox(height: 25,),
                    InkWell(
                        onTap: ()async{
                          try{
                            await launchUrl(Uri.parse('mailto:zakriyamateen3@gmail.com'));
                          }
                          catch(e){
                            print(e.toString());
                          }
                        },
                        child: textRoboto("zakriyamateen3@gmail.com", textColor, w500, size18)
                    ),
                    // SizedBox(height: 3,),
                    // textRoboto("(+92) 315 4067544", textColor, w500, size18),
                  ],
                ),
              ),
            ],
          )

        ],
      ),
    );
  }

  Widget copyrightContainer(double w){
    return Container(
      width: w,
      height: 45,
      decoration: BoxDecoration(
          color: white,
          border:Border.all(color:textColor,width:2)
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          textRoboto('Copyright © $startingYear - $currentYear  Zakriya', textColor, w300, size15)
        ],
      ),
    );
  }
  Widget experienceContainer(double w,double h){
    return Container(
      key: experienceKey,
      child: Column(

        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: w,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: textColor,width: 4),
                    bottom: BorderSide(color: textColor,width: 4)
                ),
                color: white
            ),
            padding: EdgeInsets.symmetric(vertical: size30),
            alignment: Alignment.center,
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_animation.value * MediaQuery.of(context).size.width, 0),
                      child: child,
                    );
                  },
                  child: Row(
                    children: [
                      textRobotoHollow('EXPERIENCE', textColor, w800, sizeX+40),
                      SizedBox(width: w*0.12), // Space between texts
                      textRoboto('EXPERIENCE', textColor, w800, sizeX+40),

                    ],
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(_animation.value * MediaQuery.of(context).size.width + MediaQuery.of(context).size.width, 0),
                          child: child,
                        );
                      },
                      child: Row(
                        children: [
                          textRobotoHollow('EXPERIENCE', textColor, w800, sizeX+40),
                          SizedBox(width: w*0.12), // Space between texts
                          textRoboto('EXPERIENCE', textColor, w800, sizeX+40),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: h*0.04,),
          Container(
            width: w,
            height: h*0.08,
            padding: EdgeInsets.symmetric(horizontal: w*0.035),
            child: textCenter("Flutter Developer with over 2 years of freelancing experience on Fiverr with 4.7 stars rating. Completed 11+ projects, including beautiful mobile and web apps", textColor, w400, size20),
          ),

          skillsColumn(w),
          SizedBox(height: 50,),
        ],
      ),
    );
  }

  Widget letsTalkContainer(double w){
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController messageController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Container(
      key: letsTalkKey,
      width: w,
      padding: EdgeInsets.only(top: 50,bottom: 50),
      decoration: BoxDecoration(
        color: white,
        border: Border(top: BorderSide(color: textColor,width: 1),bottom: BorderSide(color: textColor,width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          textRoboto("LET'S TALK", textColor, w700, sizeX+20),
          SizedBox(height: 50,),
          Container(
            width: 820,
            height: 510,
            decoration: BoxDecoration(
              color: yellow,
              border: Border.all(color: textColor,width: 3)
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 19),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            textRoboto('Name', textColor, w600, size18),
                            SizedBox(height: 4,),
                            Container(
                              width: 380,
                              height: 45,
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: white,
                                border: Border.all(color: textColor,width: 2),
                              ),                      alignment: Alignment.center,

                              child: TextFormField(
                                controller: nameController,
                                style: GoogleFonts.robotoMono(
                                  textStyle: TextStyle(color: textColor, letterSpacing: .5,fontWeight: w400,fontSize: size16),
                                ),
                                decoration: InputDecoration.collapsed(hintText: '',),
                                validator: (v){
                                  return v!.isEmpty?'Please provide your name':null;
                                },
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            textRoboto('Email', textColor, w600, size18),
                            SizedBox(height: 4,),
                            Container(
                              width: 380,
                              height: 45,
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: white,
                                border: Border.all(color: textColor,width: 2),
                              ),
                              alignment: Alignment.center,

                              child: TextFormField(
                                controller: emailController,

                                style: GoogleFonts.robotoMono(
                                  textStyle: TextStyle(color: textColor, letterSpacing: .5,fontWeight: w400,fontSize: size16),
                                ),
                                decoration: InputDecoration.collapsed(hintText: '',),
                                validator: (v){
                                  return EmailValidator.validate(v!.toString())?null:"Please provide your valid email!";
                                },
                              ),
                            )
                          ],
                        ),


                      ],
                    ),
                  ),
                  SizedBox(height: 8,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      textRoboto('Message', textColor, w600, size18),
                      SizedBox(height: 4,),
                      Container(
                          width: 780,
                        height: 300,
                        decoration: BoxDecoration(
                          color: white,
                          border: Border.all(color: textColor,width: 2),
                        ),
                        padding: EdgeInsets.all(3),
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: messageController,

                          maxLines: 50,
                          style: GoogleFonts.robotoMono(
                            textStyle: TextStyle(color: textColor, letterSpacing: .5,fontWeight: w400,fontSize: size16),
                          ),
                          decoration: InputDecoration.collapsed(hintText: '',),
                          validator: (v){
                            return v!.isEmpty?'Please type a message!':null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  InkWell(
                    onTap: ()async{
                      if(formKey.currentState!.validate()){
                        try{
                          setState((){
                            isSendingMessage = true;
                          });
                          await FirebaseFirestore.instance.collection('Messages').add(
                            {
                              'name':nameController.text.toString(),
                              'email':emailController.text.toString(),
                              'message':messageController.text.toString()
                            }
                          ).then((v){
                            setState((){
                              isSendingMessage = false;
                              isSentMessage = true;
                            });
                            Future.delayed(Duration(seconds: 5), () {
                            setState(() {
                              isSentMessage = false;
                            });
                            });

                          });
                        }
                        catch(e){
                          setState((){
                            isSendingMessage = false;
                          });
                          print(e.toString());}
                      }
                      },
                    child: Container(
                      width: 780,
                      height: 45,
                      decoration: BoxDecoration(
                          color: seaGreen,
                          border: Border.all(color: textColor,width: 2)
                      ),
                      child: Center(
                        child: textRoboto('SUBMIT', textColor,w600, size18),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget portfolioContainer(NavBarProvider provider, String title,String description,  String feature,String imageUrl,int index){
    return Consumer<NavBarProvider>(
      builder: (context,provider,_){
       return Container(

         width: 800,
         height: 500,
         child: Stack(
           children: [
             Container(
                width: 800,
                height: 500,
                decoration: BoxDecoration(
                    color: yellow,
                    border: Border(top: BorderSide(color: textColor,width: 2),bottom:  BorderSide(color: textColor,width: 5),left:  BorderSide(color: textColor,width: 2),right:  BorderSide(color: textColor,width: 5))
                ),
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width:400,
                        height: 400,
                        child: Image.asset(imageUrl,fit: BoxFit.contain,)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        title=='URL2Go'?
                        InkWell(
                          onTap:()async{
                            try{
                              if(await canLaunch('url2goweb.web.app')){
                                   await launchUrl(Uri.parse('url2goweb.web.app'));
                              }
                            }
                            catch(e){
                              print(e.toString());
                            }
                          },
                          child: textRoboto('$title', textColor, w700, size27),
                        ):
                        textRoboto('$title', textColor, w700, size27),
                        SizedBox(height: 10,),
                        Container(
                          width: 350,
                          alignment: AlignmentDirectional.topStart,
                          child: textLeftRubik('$description', textColor, w500, size18 ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: 350,
                          alignment: AlignmentDirectional.topStart,
                          child: textLeftRubik('$feature', textColor, w400, size18 ),
                        ),
                        SizedBox(height: 20,),

                      ],
                    )
                  ],
                ),
              ),
             Align(
               alignment: Alignment.bottomRight,
               child: Padding(
                 padding: EdgeInsets.only(right: 25,bottom: 15),
                 child:  InkWell(
                   onTap:
                       index == 0?
                       ()async{
                     try{
                       await launchUrl(Uri.parse('https://github.com/ZakriyaMateen/Asaan-Makaan'));
                     }
                     catch(e){
                       print(e.toString());
                     }
                   }:  index == 1?
                       ()async{
                     try{
                       await launchUrl(Uri.parse("https://github.com/ZakriyaMateen/URL2GoWeb"));
                     }
                     catch(e){
                       print(e.toString());
                     }
                   }:  index == 2?
                       ()async{
                     try{
                       await launchUrl(Uri.parse('https://github.com/ZakriyaMateen/anonymouschat'));
                     }
                     catch(e){
                       print(e.toString());
                     }
                   }:null,
                   child: MouseRegion(
                     onEnter: (v){provider.updatePortfolioLearnMoreList(index);},
                     onExit: (v){provider.resetPortfolioLearnMoreList();},
                     child: Container(
                       width: 150,
                       height: 45,
                       decoration: BoxDecoration(
                           color: seaGreen,
                           border: Border(top: BorderSide(color: textColor,width: 2),bottom:  BorderSide(color: textColor,width:  provider.portfolioLearnMoreList[index]?7:4),left:  BorderSide(color: textColor,width: 2),right: BorderSide(color: textColor,width: provider.portfolioLearnMoreList[index]?7:4),)
                       ),
                       child: Center(
                           child:textRoboto('LEARN MORE', textColor, w500, size20)
                       ),
                     ),
                   ),
                 ),
               ),
             )
           ],
         ),
       );
      },
    );
  }
  Widget skillsColumn(double w,){

    return Consumer<NavBarProvider>(
      builder: (context,provider,_){
        return MouseRegion(
          onExit: (v){
            provider.resetSkillsList();
          },
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap:()async{
                        try{await launchUrl(Uri.parse('https://www.flutter.dev'));}catch(e){print(e.toString);}
                    },
                      child: MouseRegion(
                          onEnter: (v){provider.updateSkillsList(0);},
                          child: skillsContainer('flutter.svg', w,false,0,provider)),
                    ),
                    InkWell(
                      onTap:()async{
                        try{await launchUrl(Uri.parse('https://firebase.google.com/'));}catch(e){print(e.toString);}
                      },
                      child: MouseRegion(
                          onEnter: (v){provider.updateSkillsList(1);},
                          child: skillsContainer('firebase.svg', w,false,1,provider)),
                    ),
                    InkWell(
                      onTap:()async{
                        try{await launchUrl(Uri.parse('https://docs.flutter.dev/data-and-backend/state-mgmt/intro'));}catch(e){print(e.toString);}
                      },
                      child: MouseRegion(
                          onEnter: (v){provider.updateSkillsList(2);},
                          child: skillsContainerWithTextAndImage('flutter2.png', w,'State Management',2,provider)),
                    ),
                    InkWell(
                      onTap:()async{
                        try{await launchUrl(Uri.parse('https://docs.flutter.dev/cookbook/networking/fetch-data'));}catch(e){print(e.toString);}
                      },
                      child: MouseRegion(
                          onEnter: (v){provider.updateSkillsList(3);},
                          child: skillsContainer('restApi.svg', w,false,3,provider)),
                    ),
                    InkWell(
                      onTap:()async{
                        try{await launchUrl(Uri.parse('https://flutter.dev/multi-platform/web'));}catch(e){print(e.toString);}
                      },
                      child: MouseRegion(
                          onEnter: (v){provider.updateSkillsList(4);},
                          child: skillsContainerWithTextAndImage('webApp.png', w,'Web Applications',4,provider)),
                    ),

                  ],
                ),
                SizedBox(height: 22,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    InkWell(
                      onTap:()async{
                        try{await launchUrl(Uri.parse('https://flutter.dev/multi-platform?gad_source=1&gclid=Cj0KCQjwtsy1BhD7ARIsAHOi4xaEWLCHki9YARZrgsCnZpZ4cmjrVYWncI4WTYHOBORx5NTi7BiVtfgaAsRWEALw_wcB&gclsrc=aw.ds'));}catch(e){print(e.toString);}
                      },
                      child: MouseRegion(
                          onEnter: (v){provider.updateSkillsList(5);},
                          child: skillsContainerWithTextAndImage('android.png', w,'Android',5,provider)),
                    ),
                    InkWell(
                      onTap:()async{
                        try{await launchUrl(Uri.parse('https://flutter.dev/multi-platform/ios'));}catch(e){print(e.toString);}
                      },
                      child: MouseRegion(
                          onEnter: (v){provider.updateSkillsList(6);},
                          child: skillsContainerWithTextAndImage('ios.png', w,'IOS',6,provider)),
                    ),
                    InkWell(
                      onTap:()async{
                        try{await launchUrl(Uri.parse('https://pub.dev/'));}catch(e){print(e.toString);}
                      },
                      child: MouseRegion(
                          onEnter: (v){provider.updateSkillsList(7);},
                          child: pubDevContainer(w,7,provider)),
                    ),
                    InkWell(
                      onTap:()async{
                        try{await launchUrl(Uri.parse('https://flutter.dev/'));}catch(e){print(e.toString);}
                      },
                      child: MouseRegion(
                          onEnter: (v){provider.updateSkillsList(8);},
                          child: skillsContainer('mobileAppDevelopment.svg', w,true,8,provider)),
                    ),
                    InkWell(
                      onTap:()async{
                        try{await launchUrl(Uri.parse('https://pub.dev/packages/flutter_webview_pro'));}catch(e){print(e.toString);}
                      },
                      child: MouseRegion(
                          onEnter: (v){provider.updateSkillsList(9);},
                          child: skillsContainerOnlyText(w,'WebView Applications',9,provider)),
                    ),


                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
  Widget skillsContainer(String url,double w,bool isPurple,int index,NavBarProvider provider){
    return
      Container(
        width: 200,
        height: 170,
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
          color: white,
          // borderRadius: BorderRadius.circular(5),
          border: Border(
            top: BorderSide(
                color: textColor,width: 2
            ),
            bottom:BorderSide(
                color: textColor,width: provider.skillsList[index]? 7:3
            ),
            left: BorderSide(
                color: textColor,width: 2
            ),
            right: BorderSide(
                color: textColor,width: provider.skillsList[index]? 7:3
            ),
          )
      ),
      child: Center(
        child:
        url.endsWith('.svg')?SvgPicture.asset(url,width: 150,height: 100,fit: BoxFit.contain,color: isPurple?Colors.deepPurple:null,):
        Image.asset(url,width: 150,height: 100,fit: BoxFit.contain,color: isPurple?Colors.deepPurple:null,),
      ),
    );

  }

  Widget pubDevContainer(double w,int index,NavBarProvider provider){
    return
      Container(
        width: 200,
        height: 170,
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
          color: Color(0xff1c2834),
          // borderRadius: BorderRadius.circular(5),
          border: Border(
            top: BorderSide(
                color: textColor,width: 2
            ),
            bottom:BorderSide(
                color: textColor,width: provider.skillsList[index]? 7:3
            ),
            left: BorderSide(
                color: textColor,width: 2
            ),
            right: BorderSide(
                color: textColor,width: provider.skillsList[index]? 7:3
            ),
          )
      ),
      child: Center(
        child:

        Image.asset('pubDev.png',width: 150,height: 100,fit: BoxFit.contain),
      ),
    );

  }
  Widget skillsContainerWithTextAndImage(String imageUrl,double w,String text,int index,NavBarProvider provider){
    return
      Container(
        width: 200,
        height: 170,
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            color: white,
            // borderRadius: BorderRadius.circular(5),
            border: Border(
              top: BorderSide(
                  color: textColor,width: 2
              ),
              bottom:BorderSide(
                  color: textColor,width: provider.skillsList[index]? 7:3
              ),
              left: BorderSide(
                  color: textColor,width: 2
              ),
              right: BorderSide(
                  color: textColor,width: provider.skillsList[index]? 7:3
              ),
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageUrl,width: 150,height: 100,fit: BoxFit.contain,),
            SizedBox(height: 3,),
            Container(
              width: 190,
                alignment: Alignment.center,
                child: textRobotoMessage(text, textColor, w600, size18))
          ],
        ),
      );

  }
  Widget skillsContainerOnlyText(double w,String text,int index,NavBarProvider provider){
    return
      Container(
        width: 200,
        height: 170,
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            color: white,
            // borderRadius: BorderRadius.circular(5),
            border: Border(
              top: BorderSide(
                  color: textColor,width: 2
              ),
              bottom:BorderSide(
                  color: textColor,width: provider.skillsList[index]? 7:3
              ),
              left: BorderSide(
                  color: textColor,width: 2
              ),
              right: BorderSide(
                  color: textColor,width: provider.skillsList[index]? 7:3
              ),
            )
        ),
        child: Container(
          width: 170,
            alignment: Alignment.center,
            child: textRobotoMessage(text, textColor, w600, size22)),
      );

  }
  Widget navBarButton(NavBarProvider navBarProvider, String text){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(

            onHover: (v){
              v?

              text == 'Home'?
              navBarProvider.updateHomeHover(true):
              text == 'Experience'?
              navBarProvider.updateExperienceHover(true):
              text == 'Portfolio'?
              navBarProvider.updatePortfolioHover(true):
              text=="Let's Talk"?
              navBarProvider.updateArticlesHover(true):
              text=='Contact'?
              navBarProvider.updateContactHover(true):(){}:


              text == 'Home'?
              navBarProvider.updateHomeHover(false):
              text == 'Experience'?
              navBarProvider.updateExperienceHover(false):
              text == 'Portfolio'?
              navBarProvider.updatePortfolioHover(false):
              text=="Let's Talk"?
              navBarProvider.updateArticlesHover(false):
              text=='Contact'?
              navBarProvider.updateContactHover(false):(){};
            },
            onTap: (){
              text=='Home'?
              Scrollable.ensureVisible(homeKey.currentContext!):
              text=='Experience'?
              Scrollable.ensureVisible(experienceKey.currentContext!):
              text=='Portfolio'?
              Scrollable.ensureVisible(portfolioKey.currentContext!):
              text=="Let's Talk"?
              Scrollable.ensureVisible(letsTalkKey.currentContext!):
              text=='Contact'?
              Scrollable.ensureVisible(contactKey.currentContext!):null;
            },
            child: textRoboto('$text', textColor,
                text=='Home'?
                navBarProvider.homeHover?w700:w400:
                text=='Experience'?
                navBarProvider.experienceHover?w700:w400:
                text=='Portfolio'?
                navBarProvider.portfolioHover?w700:w400:
                text=="Let's Talk"?
                navBarProvider.articlesHover?w700:w400:
                text=='Contact'?
                navBarProvider.contactHover?w700:w400:w400,

                size25

            )),

      ],
    );

  }
}
