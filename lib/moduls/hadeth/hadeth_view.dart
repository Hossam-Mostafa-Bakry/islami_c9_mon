import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_mon/moduls/hadeth/hadeth_details.dart';

class HadethView extends StatefulWidget {
  const HadethView({super.key});

  @override
  State<HadethView> createState() => _HadethViewState();
}

class _HadethViewState extends State<HadethView> {
  List<HadethData> allHadeth = [];

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    if (allHadeth.isEmpty) readFile();
    return Center(
      child: Column(
        children: [
          Image.asset("assets/images/hadeth_title.png"),
          Divider(
            color: theme.primaryColor,
            thickness: 1.4,
            endIndent: 20,
            indent: 20,
          ),
          Text(
            "الاحاديث",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          Divider(
            color: theme.primaryColor,
            thickness: 1.4,
            endIndent: 20,
            indent: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.pushNamed(context, HadethDetailsView.routeName,
                      arguments: allHadeth[index]);
                },
                child: Text(allHadeth[index].title,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center),
              ),
              itemCount: allHadeth.length,
            ),
          )
        ],
      ),
    );
  }

  readFile() async {
    List<HadethData> list = [];
    String content = await rootBundle.loadString("assets/files/ahadeth.txt");
    List<String> contentList = content.split("#");

    for (int i = 0; i < contentList.length; i++) {
      String singleHadeth = contentList[i].trim();
      int indexOfFirstLine = singleHadeth.indexOf("\n");
      String title = singleHadeth.substring(0, indexOfFirstLine);
      String content = singleHadeth.substring(indexOfFirstLine + 1);

      HadethData data = HadethData(title, content);
      list.add(data);
      print(content);
      print({"-----------------"});
    }
    allHadeth = list;
    setState(() {});
  }
}

class HadethData {
  String title;
  String content;

  HadethData(this.title, this.content);
}
