import 'package:aziz_bookstore/core/extentions/navigator_extentions.dart';
import 'package:aziz_bookstore/core/extentions/theme_extention.dart';
import 'package:aziz_bookstore/core/extentions/widget_extentions.dart';
import 'package:aziz_bookstore/core/theme/colors.dart';
import 'package:aziz_bookstore/data/models/book_model.dart';
import 'package:aziz_bookstore/presentations/pages/web_view/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:shimmer/shimmer.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Book? book;
  final gemini = Gemini.instance;
  var summary = "";
  var _loadSummary = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    book = ModalRoute.of(context)?.settings.arguments as Book?;
    gemini.text("search summary of this book ${book?.title}").then((value) {
      setState(
        () {
          summary = value?.content?.parts?.last.text ?? "";
          _loadSummary = false;
        },
      );
    }).catchError(
      (e) {
        setState(
          () {
            _loadSummary = false;
            summary = "Summary not found";
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border_outlined),
          ),
        ],
        title: Text('Book Info', style: context.titleLargeTextStyle?.copyWith(fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            16.heightBox,
            Container(
              height: 250,
              width: 175,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(book?.formats.imageJpeg ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ).toCenter(),
            16.heightBox,
            Text(
              book?.title ?? '',
              style: context.headline5TextStyle?.copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ).paddingSymmetric(horizontal: 16),
            8.heightBox,
            Builder(
              builder: (context) {
                var authors = "";
                for (var author in book?.authors ?? []) {
                  authors += author.name ?? "" ", ";
                }
                return Text(
                  "By : $authors",
                  style: context.bodyMediumTextStyle?.copyWith(fontWeight: FontWeight.w400, color: Colors.grey[500]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                );
              },
            ),
            8.heightBox,
            const Divider(
              color: cMainBorderColor,
              thickness: 1,
            ),
            8.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: cMainBorderColor),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Language',
                        style: context.bodyMediumTextStyle
                            ?.copyWith(fontWeight: FontWeight.w400, color: const Color(0xff858585)),
                      ),
                      4.heightBox,
                      Text(
                        book?.languages.join(", ") ?? '',
                        style: context.bodyMediumTextStyle?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: cMainBorderColor),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Download',
                        style: context.bodyMediumTextStyle
                            ?.copyWith(fontWeight: FontWeight.w400, color: const Color(0xff858585)),
                      ),
                      4.heightBox,
                      Text(
                        book?.downloadCount.toString() ?? '',
                        style: context.bodyMediumTextStyle?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: cMainBorderColor),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Copyright',
                        style: context.bodyMediumTextStyle
                            ?.copyWith(fontWeight: FontWeight.w400, color: const Color(0xff858585)),
                      ),
                      4.heightBox,
                      Text(
                        book?.copyright.toString() ?? '',
                        style: context.bodyMediumTextStyle?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            16.heightBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: context.titleLargeTextStyle?.copyWith(fontWeight: FontWeight.w500),
                ),
                8.heightBox,
                _loadSummary
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              height: 20.0,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              height: 20.0,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              height: 20.0,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              height: 20.0,
                            ),
                          ),
                        ],
                      )
                    : Markdown(
                        data: summary,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0),
                        physics: const NeverScrollableScrollPhysics(),
                      ),
              ],
            ).paddingSymmetric(horizontal: 16),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: InkWell(
          onTap: () {
            context.push(
              MaterialPageRoute(
                  builder: (context) => CustomWebView(
                        url: book?.formats.textHtml ?? '',
                        title: book?.title,
                      )),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: cMainPurple,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Read Now',
                  style: context.bodyMediumTextStyle?.copyWith(fontWeight: FontWeight.w500, color: cMainWhite),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: cMainWhite,
                ),
              ],
            ),
          ).paddingSymmetric(horizontal: 16, vertical: 8),
        ),
      ),
    );
  }
}
