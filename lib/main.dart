import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_users/data/repositories/user_repository.dart';

import 'data/blocs/user/user_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final UserRepository userRepository = UserRepository();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(create: (context) => UserBloc(userRepository)),
        ],
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 1;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(UserGetList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number page: $currentPage'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (currentPage == 1) return;
                  currentPage -= 1;
                });
                BlocProvider.of<UserBloc>(context)
                    .add(UserGetList(page: currentPage));
              },
              icon: const Icon(Icons.arrow_left)),
          IconButton(
              onPressed: () {
                setState(() {
                  currentPage += 1;
                });
                BlocProvider.of<UserBloc>(context)
                    .add(UserGetList(page: currentPage));
              },
              icon: const Icon(Icons.arrow_right)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.update)),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: Text('..LOADING!!!'));
          }
          if (state is UserListLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: state.list
                    .map((user) => Card(
                        child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage('${user.avatar}'),
                            ),
                            onTap: () {},
                            title: Text('${user.firstName}'))))
                    .toList(),
              ),
            );
          }
          if (state is UserError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Some error'));
        },
      ),
    );
  }
}
