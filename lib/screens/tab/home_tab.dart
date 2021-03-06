import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  Widget _buildBodyBack() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [
              Color.fromARGB(255, 211, 118, 130),
              Color.fromARGB(255, 253, 181, 168)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBodyBack(),
        CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Novidades"),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection("home")
                    .orderBy("pos")
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SliverToBoxAdapter(
                      child: Container(
                        width: 200,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    return SliverStaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      staggeredTiles: snapshot.data!.docs.map((doc) {
                        var value = doc.data() as Map<String, dynamic>;
                        return StaggeredTile.count(
                            value['x'], double.parse(value['y'].toString()));
                      }).toList(),
                      children: snapshot.data!.docs.map((doc) {
                        var value = doc.data() as Map<String, dynamic>;
                        return FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: value['image'],
                          fit: BoxFit.cover,
                        );
                      }).toList(),
                    );
                  }
                }),
          ],
        )
      ],
    );
  }
}
