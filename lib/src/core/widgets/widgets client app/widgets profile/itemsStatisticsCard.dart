import '../../../export file/exportfiles.dart';

class StatisticsCard extends StatelessWidget {
  final String title;
  final String value;

  const StatisticsCard({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomStyledText(
              text: value,
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
            CustomStyledText(
              text: title,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              textColor: (Theme.of(context).brightness == Brightness.dark
                  ? AppColors.lightGrayColor
                  : AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
