import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../components/visual/custom_shape.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  final int itemsPorPagina = 25;
  final int numPaginas = 25;
  int paginaActual = 0;
  @override
  Widget build(BuildContext context) {
    double defaultHeight = MediaQuery.of(context).size.height;
    double defaultWidth = MediaQuery.of(context).size.width;

    var paginas = List.generate(numPaginas, (index) {
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
                                          "Grace Hopper",
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
                                          "2556",
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
                                          "Grace Hopper",
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
                                          "2556",
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
                                          "Grace Hopper",
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
                                          "2556",
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
                itemCount:
                    paginaActual == 0 ? itemsPorPagina - 4 : itemsPorPagina,
                itemBuilder: ((context, index) => Center(
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
                                  "#${(index) + (paginaActual * itemsPorPagina) + (paginaActual == 0 ? 4 : 0)}",
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
                                "Grace Hopper Prueba Largo",
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
                                "2556",
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
                    )),
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
          numberPages: numPaginas,
          config: NumberPaginatorUIConfig(
            buttonSelectedBackgroundColor:
                Theme.of(context).colorScheme.secondary,
            buttonSelectedForegroundColor:
                Theme.of(context).colorScheme.primary,
            buttonUnselectedBackgroundColor:
                Theme.of(context).colorScheme.primary,
            buttonUnselectedForegroundColor: Colors.white,
          ),
          onPageChange: (index) {
            setState(() {
              paginaActual = index;
            });
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
