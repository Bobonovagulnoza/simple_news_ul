import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/constants/app_colors.dart';
import 'package:news_app/core/widgets/app_image.dart';
import 'package:news_app/core/widgets/app_text.dart';
import 'package:news_app/features/home/presentation/riverpod/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsData = ref.watch(newsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "News 24",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: newsData.when(
        data: (data) => data.fold(
          (failure) => Center(
            child: Text(
              failure.message,
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          (articles) => ListView.builder(
            padding: EdgeInsets.only(right: 16, left: 16, top: 30),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final articlesItem = articles[index];
              return Padding(
                padding: const EdgeInsets.only(top: 27),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    AppImage(
                      image: articles[index].urlToImage,
                      width: 137,
                      height: 140,
                      borderRadius: BorderRadius.zero,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          AppText(
                            articlesItem.title,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          AppText(
                            "By ${articlesItem.author}",
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                "News 24",
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF69BDFD),
                              ),
                              AppText(
                                "•",
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: AppColors.grey,
                              ),
                              AppText(
                                formatTimeAgo(articlesItem.publishedAt),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppColors.grey,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.more_horiz),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        error: (error, stackTrace) => Center(
          child: Text(
            "Xato: $error",
            style: TextStyle(
              color: Colors.red,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

String formatTimeAgo(DateTime publishedAt) {
  final now = DateTime.now();
  final diff = now.difference(publishedAt);

  if (diff.inMinutes < 1) {
    return '${diff.inSeconds} seconds ago';
  } else if (diff.inMinutes < 60) {
    return '${diff.inMinutes} minute ago';
  } else if (diff.inHours < 24) {
    return '${diff.inHours} hour ago';
  } else {
    return '${publishedAt.day.toString().padLeft(2, '0')}/'
        '${publishedAt.month.toString().padLeft(2, '0')}/'
        '${publishedAt.year}';
  }
}
