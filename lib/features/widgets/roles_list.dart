import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realtime_task/features/provider/provider.dart';

class RolesList extends ConsumerStatefulWidget {
  const RolesList({super.key});

  @override
  ConsumerState<RolesList> createState() => _RolesListState();
}

class _RolesListState extends ConsumerState<RolesList> {
  List roles = [
    'Flutter Developer',
    'Python Developer',
    'Angular Developer',
    'Node Developer',
    'Quality Assuarance',
    'Human Resource',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        roles.length,
        (index) => InkWell(
          onTap: () {
            ref.read(designationProv.notifier).update((state) => roles[index]);
            Navigator.pop(context);
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Text(
                roles[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
