import 'package:flutter/material.dart';
import 'package:helper_finder/core/utils/constants.dart';
import 'package:helper_finder/ui/screens/hire_page/hire_page_view_model.dart';
import 'package:helper_finder/ui/screens/map_page/google_map_page.dart';
import 'package:helper_finder/ui/screens/map_page/map_page.dart';
import 'package:helper_finder/ui/widgets/animated_list_hire.dart';
import 'package:helper_finder/ui/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

import '../../../core/models/worker_model.dart';
import '../show_worker_page/show_worker_page.dart';

class HirePage extends StatelessWidget {
  const HirePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

    Size size = MediaQuery.of(context).size;
    return Consumer<HireProvider>(
      builder: (context,hire,child){




        return  Padding(
          padding:const EdgeInsets.all(10),
          child:  hire.isLoaded?AnimatedListHire(timimg: hire.wListFilter,):Container(),
        );
      },
    );



  }

 }
