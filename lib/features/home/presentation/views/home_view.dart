import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_arch/core/app/depndency_injection.dart';
import 'package:new_arch/features/home/presentation/blocs/posts_bloc/posts_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late PostsBloc postsBloc;

  @override
  void initState() {
    postsBloc = instance<PostsBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: BlocBuilder(
              bloc: postsBloc,
              builder: (context, PostsState state) {
                return state.maybeMap(
                  loading: (value) {
                    return const CircularProgressIndicator();
                  },
                  loaded: (value) {
                    return Text(value.posts.first.title);
                  },
                  orElse: () {
                    return ElevatedButton(
                        onPressed: () {
                          postsBloc.add(const PostsEvent.getPosts());
                        },
                        child: const Text("Get Data"));
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
