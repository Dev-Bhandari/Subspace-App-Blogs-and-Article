import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:subspace/api/api_request.dart';
import 'package:subspace/models/blog.dart';
import 'package:subspace/providers/theme_provider.dart';
import 'package:subspace/screens/blog_screen.dart';
import 'package:subspace/screens/settings_screen.dart';
import 'package:subspace/utils/user_pref.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String>? isFavorite = UserPrefs.getFavorite();
  Future<List<Blog>> getData() async {
    late String json;
    if (UserPrefs.getBlogs() == null) {
      json = await Api().fetchBlogs();
      await UserPrefs.setBlogs(json);
      List<Blog> blogList = Api().parseBlog(json);

      isFavorite = List.generate(blogList.length, (index) => "false");
      await UserPrefs.setFavorite(isFavorite!);
      return blogList;
    }
    json = UserPrefs.getBlogs()!;
    return Api().parseBlog(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          shadowColor: Colors.grey,
          leading: IconButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
          ),
          title: const Text(
            "Blogs and Article",
            style: TextStyle(fontSize: 26),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingScreen(),
                        ));
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.settings,
                    size: 32,
                  ),
                ))
          ],
        ),
        body: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  const SnackBar(content: Text("Something went wrong"));
                } else if (snapshot.hasData) {
                  List<Blog> blogList = snapshot.data!;
                  return ListView.builder(
                    itemCount: blogList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BlogScreen(blog: blogList[index])),
                            );
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: themeProvider.getDarkTheme
                                      ? Colors.black
                                      : Colors.black12,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: 300,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: CachedNetworkImage(
                                          imageUrl: blogList[index].imageUrl,
                                        )
                                        //   Image.network(
                                        // blogList[index].imageUrl,
                                        // cacheHeight: 450,
                                        // cacheWidth: 750,
                                        // ),
                                        ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            blogList[index].title,
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            isFavorite![index] =
                                                isFavorite![index] == "true"
                                                    ? "false"
                                                    : "true";
                                            await UserPrefs.setFavorite(
                                                isFavorite!);
                                            setState(() {});
                                          },
                                          icon: Icon(
                                            isFavorite![index] == "true"
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: isFavorite![index] == "true"
                                                ? Colors.red
                                                : themeProvider.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black,
                                            size: 30,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                      color: themeProvider.getDarkTheme
                          ? Colors.white
                          : Colors.black),
                );
              },
            );
          },
        ));
  }
}
