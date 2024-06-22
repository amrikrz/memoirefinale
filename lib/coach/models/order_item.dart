import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportapplication/coach/models/plan_model.dart';

import 'plan_object.dart';


class OrderItem extends StatefulWidget {
  PlanObject plan;
   OrderItem({Key? key,required this.plan}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {

  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      color: Colors.grey.shade100,
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade100,
                  image: DecorationImage(image: NetworkImage(widget.plan.image),fit: BoxFit.cover)
              ),
            ),
            title:  Text(widget.plan.name,style: GoogleFonts.acme(letterSpacing: 1,color: Colors.black),),
            subtitle: Text(''),

          ),
          ExpansionTile(
              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.transparent,width: 0)),
              title: Text(
                'Order Details',
                style: GoogleFonts.acme(
                  color: Colors.yellow,
                  fontSize: 15,
                ),
              ),
              subtitle: Text('View Order Details'),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
                  child:  PlanModel(plan:widget.plan),
                ),

              ]

              ),
        
        ],
      ),
    );
  }
}
