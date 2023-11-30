import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';

import '../controllers/zone_controller.dart';

class ZoneView extends GetView<ZoneController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
           // height: 800.kh,
            color: Colors.blue,
            child: Obx(()=>
               GoogleMap(
                onMapCreated: (mapController) {
                  controller.mapCompleter.complete(mapController);
                },

                // on below line we have given map type
                mapType: MapType.normal,
                // on below line we have enabled location
                myLocationEnabled: true,

                 markers: Set.of(controller.listOfMarker.value),
                myLocationButtonEnabled: true,
                // on below line we have enabled compass location
                compassEnabled: true,
                // on below line we have added polygon
                polygons: controller.polygon.value,
                //  markers: controller.listOfMarker,
                initialCameraPosition: CameraPosition(
                  target: controller.center,
                  zoom: 11.0,
                ),
              ),
            ),
          ),

          InkWell(onTap: (){
            Get.back();
          },
            child: Container( decoration: BoxDecoration(
                color:Colors.black12 ,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),margin: EdgeInsets.fromLTRB(16,50,0,0),height: 54,width: 54,child: Icon(Icons.arrow_back_ios_new),),
          ),
        ],
      ),
    );
  }
}
