import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:lmloan/config/extensions.dart';
import 'package:lmloan/enums/enums.dart';
import 'package:lmloan/globalWidgets.dart';
import 'package:lmloan/provider/authentication/auth_provider.dart';
import 'package:lmloan/provider/loan/loan_provider.dart';
import 'package:lmloan/screens/loan_dashboard/local_widget/loan_info_card.dart';
import 'package:lmloan/shared/utils/currency_formatter.dart';
import 'package:lmloan/shared/widgets/busy_overlay.dart';
import 'package:lmloan/styles/color.dart';
import 'package:lmloan/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoanDashboardScreen extends StatefulWidget {
  const LoanDashboardScreen({super.key});

 

  @override
  State<LoanDashboardScreen> createState() => _LoanDashboardScreenState();
}

class _LoanDashboardScreenState extends State<LoanDashboardScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<LoanProviderImpl>(context, listen: false).viewLoan();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoanProviderImpl>(builder: (context, stateModel, child) {
      // final Size screensize=MediaQuery.of(context).size;
      final totalLoaned = stateModel.loans
          .where((element) => element.loanType == LoanType.LoanGivenByMe.name)
          .fold(0.0, (previousValue, element) => previousValue + double.parse(element.loanAmount));

      final totalOwed = stateModel.loans
          .where((element) => element.loanType == LoanType.LoanOwedByMe.name)
          .fold(0.0, (previousValue, element) => previousValue + double.parse(element.loanAmount));

      return BusyOverlay(
        show: stateModel.viewState == ViewState.Busy,
        title: stateModel.message,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 219, 221, 223),
          appBar: AppBar(
            title: Center(
              child: Text(
                "Lungujja Youths Club",
                style: AppTheme.titleStyle(color: Blue, isBold: true),
              ),
            ),
            backgroundColor: primaryColor,
            actions: [
              Image.asset('assets/images/Designer1.png', height: 50, width: 50,),
              // IconButton(
              //   onPressed: () {
              //     Provider.of<AuthenticationProviderImpl>(context, listen: false)
              //         .logoutUser()
              //         .then((value) => context.go('/'));
              //   },
              //   icon: const Icon(Icons.logout),
              // ),
              IconButton(
                onPressed: () {
                  context.push('/search_loan');
                },
                icon: const Icon(Icons.search_outlined),
              ),
              PopupMenuButton(itemBuilder: ((context) {
                return [
                  PopupMenuItem(child: const Text('View Loans'),onTap:() {
                    context.push('/search_loan');
                  },),
                  const PopupMenuItem(child: Text('Profile')), 
                  PopupMenuItem(child: TextButton(onPressed: 
                  () {
                    Provider.of<AuthenticationProviderImpl>(context, listen: false)
                      .logoutUser()
                      .then((value) => context.go('/'));
                  }, child: const Icon(Icons.logout_outlined)),),
                  
                ];
              }))
              
            ],
          
          ),
          body: Container(
          
            decoration: const BoxDecoration(color: bgColor),
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  FlutterCarousel(
                          options: CarouselOptions(
                            aspectRatio:1.5,
                            clipBehavior: Clip.none,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 8),
                             // height: 200,
                              viewportFraction:.9 ,
                              enlargeCenterPage: true,
                              // showIndicator: true,
                              // slideIndicator: const CircularSlideIndicator(
                              //     indicatorBorderColor: white,
                              //     currentIndicatorColor: mainOrange,
                              //     indicatorBackgroundColor: grey
                              // ),
                              floatingIndicator: false
                          ),
                          items: slider_first.map((item) {
                            return Builder(
                              builder: (BuildContext context) {
                                return item;
                              },
                            );
                          }).toList(),
                        ),
                  const SizedBox(
                  height: 20,
                ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            homepageicons(Icons.send_to_mobile_sharp,'Payment' ),
                            const SizedBox(
                              width: 15,
                            ),
                            homepageicons(Icons.history,'Loan history' ),
                            const SizedBox(
                              width: 15,
                            ),
                            homepageicons(Icons.account_balance_wallet_sharp,'Account' ),
                            const SizedBox(
                              width: 15,
                            ),
                            homepageicons(Icons.share_sharp,'Invite' ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                         textBaseline: TextBaseline.alphabetic,
                          children: [
                            const Text(
                              'Popular loan offers',
                              style: TextStyle(
                                  color:primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize:20
                              ),),
                            GestureDetector(
                              onTap: (){
                                //todo: show more loan offers
                              },
                              child: const Text(
                                'See more',
                                style: TextStyle(
                                    color:mainOrange,
                                    fontWeight: FontWeight.w800,
                                    fontSize:15
                                ),),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                  //  SizedBox(
                  //   width: 320,
                  //   height: 250,),
                  FlutterCarousel(
                  options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  height: 400.0,
                  showIndicator: true,
                  slideIndicator: const CircularSlideIndicator(
                    indicatorBorderColor: white,
                    currentIndicatorColor: mainOrange,
                    indicatorBackgroundColor: grey
                  ),
                floatingIndicator: false
              ),
              items: sliders.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: 400,
                        height: 400,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                            color: white
                        ),
                        child: Column(
                          children: [
                            Image(
                                height:250,
                                width:300,
                                fit: BoxFit.cover,
                                image: AssetImage(item.imagepath)),
                            SizedBox( height: 10,),

                            Text(item.textBody1,
                             style: TextStyle(
                                color:mainBlue,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),


                            ),

                            SizedBox( height: 5),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item.textBody2,
                                textAlign: TextAlign.center,
                              style:TextStyle(
                                color:grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                              ),
                            ),

                          ],
                        )
                    );
                  },
                );
              }).toList(),
            ),
            20.height(),

            Container(
                    // color: greyColor,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), border: Border.all(color: greyColor), color: const Color.fromRGBO(147, 179, 226, 0.2),),
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image : const DecorationImage(
                              image: AssetImage("assets/images/white.jpg"),
                              fit: BoxFit.fill,
                            ),
                          ),
                      child: IntrinsicHeight(
                        child: Container(
                          
                          child: Container(
                            child: Column(
                              children: [
                                10.height(),
                                Text('Current Status (Standing)', style: AppTheme.subTitleStyle(color: greenColor),),
                                20.height(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    "Total Loaned",
                                                    style: AppTheme.headerStyle(color: primaryColor),
                                                  ),
                                                ),
                                              ),
                                              const Icon(
                                                Icons.outbond,
                                                color: redColor,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "\$ -${currencyFormatter(totalLoaned)}",
                                            style: AppTheme.titleStyle(color: redColor),
                                          ),
                                          const Divider(),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    "Total Owed",
                                                    style: AppTheme.headerStyle(color: primaryColor),
                                                  ),
                                                ),
                                              ),
                                              const Icon(
                                                Icons.outbond,
                                                color: greenColor,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "\$ ${currencyFormatter(totalOwed)}",
                                            style: AppTheme.titleStyle(color: greenColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const VerticalDivider(),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image(image: AssetImage('assets/images/loan.png'), height: 30, width: 30,),
                                        Text(
                                          "Total Balance",
                                          style: AppTheme.headerStyle(color: primaryColor),
                                        ),
                                        Text(
                                          "\$ ${currencyFormatter(totalOwed - totalLoaned)}",
                                          style: AppTheme.titleStyle(color: greenColor),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  20.height(),

                  //pending loan view
                  Container(
                    width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image : const DecorationImage(
                          image: AssetImage("assets/images/orangeGeometric.jpg"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    child: Column(
                      children: [
                        Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            12.height(),
                            Center(
                              child: Text(
                                "Pending Loans",
                                style: AppTheme.headerStyle(color: Blue),
                              ),
                            ),
                            15.height(),
                            (stateModel.pendingLoans.isNotEmpty)
                                ? Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: List.generate(stateModel.pendingLoans.length, (index) {
                                          final data = stateModel.pendingLoans[index];
                                          return LoanInfoCard(
                                            loanData: data,
                                            onTap: () {
                                              context.push('/view_loan?loan_id=${data.loanId}');
                                            },
                                          );
                                        }),
                                      ),
                                    ),
                                )
                                : Center(child: Text("No Pending Loans", style: AppTheme.headerStyle()))
                          ],
                        ),
                        
                        10.height(),
                      ],
                    ),
                      ],
                    ),
                  ),

                  40.height(),

                // Completed Loans
                  Container(
                    width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image : const DecorationImage(
                          image: AssetImage("assets/images/wave.jpg"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    child: Column(
                      children: [
                        Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            12.height(),
                            Center(
                              child: Text(
                                "Completed Loans",
                                style: AppTheme.headerStyle(color: Blue),
                              ),
                            ),
                            10.height(),
                            (stateModel.completedLoans.isNotEmpty)
                                ? Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: List.generate(stateModel.completedLoans.length, (index) {
                                          final data = stateModel.completedLoans[index];
                                          return LoanInfoCard(
                                            loanData: data,
                                            onTap: () {
                                              context.push('/view_loan?loan_id=${data.loanId}');
                                            },
                                          );
                                        }),
                                      ),
                                    ),
                                )
                                : Center(child: Text("No Completed Loans", style: AppTheme.headerStyle()))
                          ],
                        ),
                        
                        5.height(),
                      ],
                    ),
                      ],
                    ),
                  ),
                   60.height(),

                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () {
              context.push('/add_loan');
            },
            child: const Icon(Icons.add),
          ),
        ),
      );
    });
  }
}


class BuildCarousel{
  String imagepath;
  String textBody1;
  String textBody2;
  BuildCarousel (this.imagepath,this.textBody1,this.textBody2);
}


List sliders= [
  BuildCarousel('assets/images/african.webp',
  'Affordable Sacco loans', 'Build your savings to enjoy higher affordable Sacco loan limits.'
  ),
  BuildCarousel('assets/images/mortgage-contract-house-figurine_23-2147737962.jpg',
      'Education Loans', 'Borrow at low interest to finance your needs, business, school or project.'
  ),
  BuildCarousel('assets/images/photoplant.webp',
      'Sacco Investment shares', 'Shares give you dividends as well as financial backups.'
  ),
  BuildCarousel('assets/images/Money income.gif',
      'Increased Income', 'Invest on Sacco properties and earn dividends.'
  ),
];


Column buildColumn(String title, String value) {
    return Column(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text(
                                        title,
                                        style: TextStyle(
                                            color: mainOrange,
                                            fontWeight: FontWeight.w500,
                                            fontSize:20
                                        ),),
                                       const SizedBox(
                                         height: 5,
                                       ),
                                       Text(
                                         value,
                                         style: TextStyle(
                                             color: black,
                                             fontWeight: FontWeight.w400,
                                             fontSize:15
                                         ),),
                                     ],
                                   );
  }

  Column homepageicons(IconData icons , String action) {
    return Column(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration:   BoxDecoration(
                                borderRadius: BorderRadius.circular(15),

                                color: cream
                            ),
                            child:Center(
                              child: IconButton(
                                color: mainBlue,
                                iconSize: 30,
                                onPressed: () {
                                  //todo: action
                                },
                                icon:  Icon(
                                  icons
                                ),

                              ),
                            ) ,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        Text(
                            action,
                            style: const TextStyle(
                                color:black,
                                fontWeight: FontWeight.w400,
                                fontSize:15
                            ),),
                        ],
                      );
  }



List slider_first=[
  Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image : const DecorationImage(
        image: AssetImage("assets/images/orange.jpg"),
        fit: BoxFit.fill,
      ),
    ),
    child: Column(
      children: [
        const SizedBox(
          height: 2,
        ),
        const Text(
          'You can get upto',
          style: TextStyle(
              color: white,
              fontWeight: FontWeight.w500,
              fontSize:15
          ),),const SizedBox(
          height: 5,
        ),
        const Text(
          'Ugx 1,000,000',
          style: TextStyle(
              color: white,
              fontWeight: FontWeight.w600,
              fontSize:30
          ),),
        const SizedBox(
          height: 4,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '3min application | 24hr disbursement',
              style: AppTheme.subTitleStyle(color: white)),
          ),
        ),
        const SizedBox(
          height: 1,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Low Interest rates',
              style: AppTheme.subTitleStyle(color: white)),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        ElavatedButton('Apply loan' , mainOrange, white,() {
          //:todo loan application
        },3),
        
       

        // const SizedBox(height: 20,)

      ],
    ),
  ),



  Container(
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: mainBlue
    ),
    child:Padding(
      padding: const EdgeInsets.only(left: 20 ,right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
            child: const Text(
              'Considering a savings account ?',
              style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.w500,
                  fontSize:15
              ),),
          ),const SizedBox(
            height: 10,
          ),
          const Text(
            'Grow your savings with ease! Our high-yield savings account offers competitive rates, with our platform, you can easily manage your money anytime, anywhere. ',
            style: TextStyle(
                color: white,
                fontWeight: FontWeight.w300,
                fontSize:13
            ),)
          ,
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ElavatedButton('Learn more' , mainOrange, white,() {
              //:todo take to savings webpage
            },3),
          ),

        ],
      ),
    ),
  ),

];

class Item{IconData _icondata;

  IconData get icondata => _icondata;

  set icondata(IconData value) {
    _icondata = value;
  }
String typeOfLoan;
String max;
String interest;
String duration;
Item(this._icondata,this.typeOfLoan,this.max,this.interest,this.duration);}



List popular=[
  Item(Icons.history_edu_sharp, 'Education Loan', 'Ushs 2 million', '1% pm', '3 years'),
  Item(Icons.house, 'Mortgage', 'Ushs 5 million', '1% pm', '10 years'),
  Item(Icons.business_center_sharp, 'Business Loan', 'Ushs 10 million', '2% pm', '10 years'),
  Item(Icons.car_rental, 'Car Loan', 'Ushs 2 million', '1% pm', '5 years')
];




