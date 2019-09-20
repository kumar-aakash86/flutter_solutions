import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ExpandableDemo extends StatefulWidget {
  @override
  _ExpandableDemoState createState() => _ExpandableDemoState();
}

class _ExpandableDemoState extends State<ExpandableDemo> {
  ExpandableController categoryController, subCategoryController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    categoryController = ExpandableController(initialExpanded: false);
    subCategoryController = ExpandableController(initialExpanded: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                _toggleExpandables(0);
              },
              child: ExpandablePanel(
                controller: categoryController,
                iconPlacement: ExpandablePanelIconPlacement.right,
                header: Container(
                    margin: EdgeInsets.only(left: 40.0),
                    child: Text(
                      'Category',
                      style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )),
                expanded: Container(child: Icon(Icons.close)),
                tapHeaderToExpand: false,
                hasIcon: true,
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.deferToChild,
              onTap: (){
                _toggleExpandables(1);
              },
              child: ExpandablePanel(
                controller: subCategoryController,
                iconPlacement: ExpandablePanelIconPlacement.right,
                header: Container(
                    margin: EdgeInsets.only(left: 40.0),
                    child: Text(
                      'SubCategory',
                      style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )),
                expanded: Container(child: Icon(Icons.close)),
                tapHeaderToExpand: false,
                hasIcon: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _toggleExpandables(int index){
    setState(() {
     categoryController.value = false;
    subCategoryController.value = false;

    _getController(index).value = true; 
    });
  }

  ExpandableController _getController(int index){
    switch(index){
      case 0:
        return categoryController;
      case 1:
        return subCategoryController;
    }
  }
}
