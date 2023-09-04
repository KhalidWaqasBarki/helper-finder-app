import 'package:flutter/material.dart';
import 'package:helper_finder/core/utils/constants.dart';
import 'package:provider/provider.dart';
import '../../core/models/worker_model.dart';
import '../screens/hire_page/hire_page_view_model.dart';
import '../screens/show_worker_page/show_worker_page.dart';

class AnimatedListHire extends StatelessWidget {
  List<WorkerModel> timimg;
  AnimatedListHire({Key? key, required this.timimg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

    return AnimatedList(
      key: listKey,
      initialItemCount: timimg.length,
      itemBuilder: (context, index, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: const Offset(0, 0),
          ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.bounceIn,
              reverseCurve: Curves.bounceOut)),
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WorkerProfilePage(
                              model: timimg[index],
                            )));
              },
              child: timimg[index].type == "worker"
                  ? buildCardWorker(index, timimg)
                  : buildCardClient(index, timimg),
            ),
          ),
        ); // Refer step 3
      },
    );
  }

  Padding buildCardWorker(int index, List<WorkerModel> timimg) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/worker.png",
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
            flex: 1,
          ),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        timimg[index].name.toString(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 15,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        timimg[index].skill.toString(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Other Skills: ${timimg[index].otherSkills.toString()}",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black45,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.phone_android_outlined),
                      Text(
                        timimg[index].phone.toString(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      Text(
                        timimg[index].address.toString(),
                        textAlign: TextAlign.start,
                        maxLines: 4,
                        textDirection: TextDirection.ltr,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.currency_pound),
                          Text(
                            timimg[index].wage.toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.arrow_upward),
                          Text(
                            "${timimg[index].kms.toString()}  Kms",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              )),
          Container()
        ],
      ),
    );
  }

  Padding buildCardClient(int index, List<WorkerModel> timimg) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/worker.png",
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
            flex: 1,
          ),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        timimg[index].name.toString(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 15,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.phone_android_outlined),
                      Text(
                        timimg[index].phone.toString(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      Text(
                        timimg[index].address.toString(),
                        textAlign: TextAlign.start,
                        maxLines: 4,
                        textDirection: TextDirection.ltr,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.arrow_upward),
                          Text(
                            "${timimg[index].kms.toString()}  Kms",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              )),
          Container()
        ],
      ),
    );
  }
}
