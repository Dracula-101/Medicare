import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:medicare/data/models/user/user.dart';
import 'package:medicare/services/auth_service/auth_service.dart';

class DoctorMainPage extends StatefulWidget {
  const DoctorMainPage({super.key});

  @override
  State<DoctorMainPage> createState() => _DoctorMainPageState();
}

class _DoctorMainPageState extends State<DoctorMainPage> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = GetIt.I.get<AuthService>().currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 2,
                  ),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: user?.avatar.isEmpty ?? false
                    ? const Icon(Icons.person)
                    : Image.network(
                        user!.avatar,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Welcome to Medicare',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'You are logged in as ${GetIt.I.get<AuthService>().currentUser?.email}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        GetIt.I.get<AuthService>().signOut();
                      },
                      child: const Text('Sign Out'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
