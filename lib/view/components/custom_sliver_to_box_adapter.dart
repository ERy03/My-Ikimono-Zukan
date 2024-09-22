import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_ikimono_zukan/data/repositories/profile_repository.dart';

class CustomSliverToBoxAdapter extends ConsumerWidget {
  const CustomSliverToBoxAdapter({
    required this.name,
    required this.location,
    required this.description,
    required this.tag,
    required this.capturedDate,
    super.key,
  });

  final String name;
  final String location;
  final String description;
  final String tag;
  final DateTime capturedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(fetchUserProvider);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              maxLines: 1,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey,
                  ),
              child: Row(
                children: [
                  Text(tag),
                  const SizedBox(width: 8),
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(location),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                profile.when(
                  data: (profile) => Container(
                    height: 32,
                    width: 32,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: profile.avatarUrl.isNotEmpty
                            ? CachedNetworkImageProvider(
                                Uri.encodeFull(profile.avatarUrl),
                              )
                            : const CachedNetworkImageProvider(
                                '''
https://images.unsplash.com/photo-1609743522653-52354461eb27?q=80&w=3387&auto=
format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fH
x8fA%3D%3D''',
                              ),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          offset: const Offset(1, 2),
                        ),
                      ],
                    ),
                  ),
                  error: (_, __) => Container(
                    height: 32,
                    width: 32,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          offset: const Offset(1, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.warning,
                    ),
                  ),
                  loading: CircularProgressIndicator.adaptive,
                ),
                profile.when(
                  data: (profile) {
                    return Text(
                      profile.username,
                    );
                  },
                  error: (e, __) => Text(
                    e.toString(),
                    style: const TextStyle(
                      overflow: TextOverflow.visible,
                      fontSize: 10,
                    ),
                  ),
                  loading: () => const CircularProgressIndicator.adaptive(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(
              height: 1,
              color: Colors.grey.withOpacity(0.2),
            ),
            const SizedBox(height: 16),
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Divider(
              height: 1,
              color: Colors.grey.withOpacity(0.2),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: Colors.grey,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  DateFormat('yyyy-MM-dd').format(capturedDate),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
