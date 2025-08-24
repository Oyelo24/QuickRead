import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel()..loadUser('1'),
      child: Scaffold(
        appBar: AppBar(title: const Text('QuickRead')),
        body: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (viewModel.error != null) {
              return Center(child: Text('Error: ${viewModel.error}'));
            }
            
            if (viewModel.user != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Welcome, ${viewModel.user!.name}!'),
                    Text(viewModel.user!.email),
                  ],
                ),
              );
            }
            
            return const Center(child: Text('No data'));
          },
        ),
      ),
    );
  }
}