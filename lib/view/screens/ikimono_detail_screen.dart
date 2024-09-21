import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IkimonoDetailScreen extends StatelessWidget {
  const IkimonoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isAndroid = Theme.of(context).platform == TargetPlatform.android;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 275,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
            ),
            elevation: 0,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://images.unsplash.com/photo-1486365227551-f3f90034a57c?q=80&w=3540&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                fit: BoxFit.cover,
              ),
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
            ),
            leadingWidth: 80,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 16,
              padding: const EdgeInsets.all(12),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Colors.white.withOpacity(0.2),
                ),
              ),
              icon: isAndroid
                  ? const Icon(Icons.arrow_back)
                  : const Icon(
                      Icons.arrow_back_ios_new,
                    ),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'some bird',
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
                        const Text('bird'),
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
                        const Text('park'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        height: 32,
                        width: 32,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1486365227551-f3f90034a57c?q=80&w=3540&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
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
                      const Text('some user'),
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
                    'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum',
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
                        '2022.10.10',
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
          ),
        ],
      ),
    );
  }
}
