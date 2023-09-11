import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:for_two/modules/dashboard/controller/dashboard_controller.dart';
import 'package:for_two/modules/dashboard/view/tool_bar.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class InvitationList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DashboardController>(
          init: DashboardController(),
          builder: (controller) {
            return controller.isLoading
                ? const Center(
              child: CircularProgressIndicator(
                valueColor:
                AlwaysStoppedAnimation<Color>(Color(0xFFDF1721)),
              ),
            )
                : Padding(
              padding:
              const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: Column(
                children: [
                  CustomToolbar(),
                  Expanded(
                    child: Container(
                      // padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: const Color(0XFFF49DA2).withOpacity(0.15),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            width: size.width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10),
                            decoration: BoxDecoration(
                              color: const Color(0XFFF49DA2)
                                  .withOpacity(0.5),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Your Invitation List',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                        backgroundColor:
                                        Colors.red.shade500),
                                    onPressed: () {
                                      //  Get.to(() => const ViewAllRecord());
                                    },
                                    child: Text(
                                      'View all',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          ?.copyWith(
                                          color: kWhiteColor
                                              ?.withOpacity(0.8),
                                          fontWeight:
                                          FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Expanded(
                            child: !controller.invitationLists.isNull
                                ? const Center(child: Text('Empty List'))
                                : Obx(
                                  () => ListView.builder(
                                itemCount: controller.invitationLists?.length ?? 0,
                                itemBuilder: (BuildContext context,
                                    int index) {
                                  print(controller.invitationLists?[index].inviteeName);
                                  final _todoModel = controller.invitationLists?[index];
                                  return Container(
                                    margin:
                                    const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius:
                                      BorderRadius.circular(4),
                                    ),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Card(
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    10),
                                              ),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets
                                                    .all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      "Invitee name :${_todoModel?.inviteeName}",
                                                      style:
                                                      TextStyle(
                                                        fontFamily:
                                                        'Montserrat',
                                                        color: Colors
                                                            .black
                                                            .withOpacity(
                                                            0.6),
                                                        fontSize:
                                                        13,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        height: 6),
                                                    Text(
                                                      "Phone Number :${_todoModel?.inviteePhoneNumber}",
                                                      style:
                                                      TextStyle(
                                                        fontFamily:
                                                        'Montserrat',
                                                        color: Colors
                                                            .black
                                                            .withOpacity(
                                                            0.6),
                                                        fontSize:
                                                        13,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        height: 6),
                                                    Text(
                                                      "Meeting Date :${_todoModel?.meetingDate}",
                                                      style:
                                                      TextStyle(
                                                        fontFamily:
                                                        'Montserrat',
                                                        color: Colors
                                                            .black
                                                            .withOpacity(
                                                            0.6),
                                                        fontSize:
                                                        13,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        height: 6),
                                                    Text(
                                                      "Meeting Time :${_todoModel?.meetingTime}",
                                                      style:
                                                      TextStyle(
                                                        fontFamily:
                                                        'Montserrat',
                                                        color: Colors
                                                            .black
                                                            .withOpacity(
                                                            0.6),
                                                        fontSize:
                                                        13,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        height: 6),
                                                    Text(
                                                      "Meeting Status :${_todoModel?.meetingStatus}",
                                                      style:
                                                      TextStyle(
                                                        fontFamily:
                                                        'Montserrat',
                                                        color: Colors
                                                            .black
                                                            .withOpacity(
                                                            0.6),
                                                        fontSize:
                                                        13,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        height: 6),
                                                    Text(
                                                      "Meeting Address :${_todoModel?.meetingAddress}",
                                                      style:
                                                      TextStyle(
                                                        fontFamily:
                                                        'Montserrat',
                                                        color: Colors
                                                            .black
                                                            .withOpacity(
                                                            0.6),
                                                        fontSize:
                                                        13,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        height: 6),
                                                    const SizedBox(
                                                        height: 6),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Checkbox(
                                          //   value: _todoModel.isDone,
                                          //   onChanged: (status) {
                                          //     FirestoreDb.updateStatus(
                                          //       status!,
                                          //       _todoModel.documentId,
                                          //     );
                                          //   },
                                          // ),
                                          IconButton(
                                            onPressed: () {
                                              // FirestoreDb.deleteTodo(
                                              //     _todoModel.documentId!);

                                              _launchMapsUrl(
                                                  double.parse(
                                                      _todoModel!
                                                          .meetingLat),
                                                  double.parse(
                                                      _todoModel
                                                          .meetingLng));
                                            },
                                            icon: const Icon(
                                              Icons.location_pin,
                                              color:
                                              Colors.redAccent,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  void _launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}