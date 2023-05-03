import 'package:ajedrez/components/communications/api.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import '../../components/visual/custom_shape.dart';
import '../../components/ranking_data.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  int paginaActual = 0;
  RankingData rankingData = RankingData();

  @override
  Widget build(BuildContext context) {
    double defaultHeight = MediaQuery.of(context).size.height;
    double defaultWidth = MediaQuery.of(context).size.width;

    var paginas = List.generate(RankingData.numPaginas, (index) {
      return Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: <Widget>[
            if (paginaActual == 0) ...[
              SizedBox(
                height: defaultHeight * 0.37,
                child: Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: CustomShape(),
                      child: Container(
                        height: defaultHeight * 0.37,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: defaultHeight * 0.025,
                                top: defaultHeight * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: defaultWidth * 0.02),
                                    width: defaultWidth / 3,
                                    child: Column(
                                      children: [
                                        Text(
                                          "#2",
                                          style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(
                                              defaultHeight * 0.01),
                                          child: imageItem(defaultHeight * 0.09,
                                              2.5, "Grace_Hopper"),
                                        ),
                                        Text(
                                          RankingData.username[1],
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                        Text(
                                          RankingData.elo[1].toString(),
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w900,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: SizedBox(
                                    width: defaultWidth / 3,
                                    child: Column(
                                      children: [
                                        Text(
                                          "#1",
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(
                                              defaultHeight * 0.01),
                                          child: imageItem(defaultHeight * 0.11,
                                              3, "Grace_Hopper"),
                                        ),
                                        Text(
                                          RankingData.username[0],
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                        Text(
                                          RankingData.elo[0].toString(),
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w900,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        right: defaultWidth * 0.01),
                                    width: defaultWidth / 3,
                                    child: Column(
                                      children: [
                                        Text(
                                          "#3",
                                          style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(
                                              defaultHeight * 0.01),
                                          child: imageItem(defaultHeight * 0.09,
                                              2.5, "Grace_Hopper"),
                                        ),
                                        Text(
                                          RankingData.username[2],
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                        Text(
                                          RankingData.elo[2].toString(),
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w900,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              SizedBox(
                height: defaultHeight * 0.05,
              )
            ],
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: paginaActual == 0
                    ? RankingData.itemsPorPagina - 3
                    : RankingData.itemsPorPagina,
                itemBuilder: ((context, index) {
                  if (index < RankingData.username.length) {
                    return Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: defaultHeight * 0.02),
                        height: defaultHeight * 0.1,
                        width: defaultWidth * 0.85,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultWidth * 0.03),
                              width: (defaultWidth * 0.85) * 0.175,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "#${(index) + (paginaActual * RankingData.itemsPorPagina) + (paginaActual == 0 ? 4 : 1)}",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                width: (defaultWidth * 0.85) * 0.175,
                                child: imageItem(
                                    defaultHeight * 0.07, 2, "Grace_Hopper"),
                              ),
                            ),
                            Container(
                              width: (defaultWidth * 0.85) * 0.45,
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultWidth * 0.03),
                              child: Text(
                                RankingData.username[
                                    paginaActual == 0 ? index + 3 : index],
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: (defaultWidth * 0.85) * 0.15,
                              child: Text(
                                RankingData
                                    .elo[paginaActual == 0 ? index + 3 : index]
                                    .toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w900,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return null;
                  }
                }),
              ),
            ),
          ],
        ),
      );
    });

    return Scaffold(
      body: paginas[paginaActual],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          border: const Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 1.25,
            ),
          ),
        ),
        margin: EdgeInsets.zero,
        child: NumberPaginator(
          numberPages: RankingData.numPaginas,
          config: NumberPaginatorUIConfig(
            buttonSelectedBackgroundColor:
                Theme.of(context).colorScheme.secondary,
            buttonSelectedForegroundColor:
                Theme.of(context).colorScheme.primary,
            buttonUnselectedBackgroundColor:
                Theme.of(context).colorScheme.primary,
            buttonUnselectedForegroundColor: Colors.white,
          ),
          onPageChange: (index) async {
            RankingData.restart();
            await apiRanking(index + 1, RankingData.itemsPorPagina);
            if (context.mounted) {
              setState(() {
                paginaActual = index;
              });
            }
          },
        ),
      ),
    );
  }

  imageItem(double tamanyo, double circle, String imagen) {
    return SizedBox(
      height: tamanyo,
      width: tamanyo,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: circle,
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/$imagen.jpg'),
            )),
      ),
    );
  }
}
