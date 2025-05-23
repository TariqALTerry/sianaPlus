// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customInputDialog.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customSureDialog.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/hand_receip_maintenance_parts/hand_receipt_model.dart';

class TransferredMaintenancePartsDetailsPage extends StatelessWidget {
  const TransferredMaintenancePartsDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarApplicationArrow(
        text: "تفاصيل القطعة ",
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(2),
                  },
                  border: TableBorder.all(
                      color: Colors.grey,
                      width: 1,
                      borderRadius: BorderRadius.circular(15)),
                  children: [
                    buildTableRow('اسم العميل', 'محمد أحمد'),
                    buildTableRow('رقم العميل', '0501234567'),
                    buildTableRow('اسم القطعة', 'ثلاجة'),
                    buildTableRow('الشركة', 'سامسونج'),
                    buildTableRow('اللون', 'أسود'),
                    buildTableRow('الوصف', 'ssssss'),
                    buildTableRow('من', 'الفرع الرئيسي'),
                    buildTableRow('الى', 'الفرع الجديد'),
                    buildTableRow('يتطلب إبلاغ العميل بالتكلفة؟', 'لا'),
                    buildTableRow('مستعجل', 'لا'),
                    buildTableRow('عدد أيام الضمان', '22'),
                  ],
                ),
                AppSizedBox.kVSpace20,
                buildButtonWidget(context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  TableRow buildTableRow(String label, dynamic value) {
    return TableRow(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: CustomStyledText(
              text: label,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: value is Widget
                ? value
                : CustomStyledText(
                    text: value.toString(),
                    fontSize: 16,
                  ),
          ),
        ),
      ],
    );
  }

  Widget buildButtonWidget(BuildContext context) {
    StatusEnum status = StatusEnum.Suspended;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12, left: 10),
                    alignment: Alignment.topRight,
                    child: const CustomStyledText(
                      text: 'اختر العملية:',
                      textColor: AppColors.secondaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ..._getItemsBasedOnStatus(context, status),
                ],
              ),
            );
          },
        );
      },
      child: Center(
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: AppColors.secondaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.gear,
                  size: 20,
                ),
                AppSizedBox.kWSpace10,
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: const CustomStyledText(
                    text: 'العمليات',
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _getItemsBasedOnStatus(BuildContext context, StatusEnum status) {
    if (status case StatusEnum.New) {
      return [
        ListTile(
            title: const CustomStyledText(
              text: 'فحص القطعة',
              fontSize: 20,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(
                    onConfirm: () {},
                  );
                },
              );
            }),
      ];
    } else if (status case StatusEnum.CheckItem) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: 'تحديد العطل',
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomInputDialog(
                  titleDialog: 'تحديد العطل',
                  text: 'الوصف:',
                  hintText: 'ادخل الوصف',
                  // controller: ,
                  validators: (value) {
                    if (value == null || value.isEmpty) {
                      return 'عفوا.الوصف مطلوب';
                    }
                    return null;
                  },
                  onConfirm: () {},
                );
              },
            );
          },
        ),
        ListTile(
          title: const CustomStyledText(
            text: 'لا يمكن تحديد العطل',
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(
                  onConfirm: () {},
                );
              },
            );
          },
        ),
      ];
    } else if (status case StatusEnum.DefineMalfunction) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: 'مكتمل',
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(
                  onConfirm: () {},
                );
              },
            );
          },
        ),
      ];
    } else if (status case StatusEnum.ManagerApprovedReturn) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: 'موافقة المدير على الإرجاع',
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(
                  onConfirm: () {},
                );
              },
            );
          },
        ),
      ];
    } else if (status case StatusEnum.InformCustomerOfTheCost) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: 'إبلاغ العميل بالتكلفة',
            fontSize: 20,
          ),
          onTap: () {
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return ShowDilogInformCustomerOfTheCost();
            //   },
            // );
          },
        ),
      ];
    } else if (status case StatusEnum.ItemCannotBeServiced) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: 'ابلاغ العميل بعدم امكانية صيانة',
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(
                  onConfirm: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomSureDialog(
                          onConfirm: () {},
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ];
    } else if (status case StatusEnum.NoResponseFromTheCustomer) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: 'لا توجد استجابة من العميل',
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(
                  onConfirm: () {},
                );
              },
            );
          },
        ),
      ];
    } else if (status case StatusEnum.CustomerApproved) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: 'موافقة العميل',
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(
                  onConfirm: () {},
                );
              },
            );
          },
        ),
      ];
    } else if (status case StatusEnum.EnterMaintenanceCost) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: 'إدخال تكلفة الصيانة',
            fontSize: 20,
          ),
          onTap: () {},
        ),
      ];
    } else if (status case StatusEnum.Completed) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: 'إبلاغ العميل بانتهاء الصيانة',
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(
                  onConfirm: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomSureDialog(
                          onConfirm: () {},
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ];
    } else {
      return [
        ListTile(
          title: const CustomStyledText(
            text: 'التعليق',
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomInputDialog(
                  titleDialog: 'تعليق الصيانة',
                  text: 'سبب تعليق الصيانة:',
                  hintText: 'ادخل سبب تعليق الصيانة',
                  // controller: ,
                  validators: (value) {
                    if (value == null || value.isEmpty) {
                      return 'عفوا.سبب تعليق الصيانة مطلوب';
                    }
                    return null;
                  },
                  onConfirm: () {},
                );
              },
            );
          },
        ),
      ];
    }
  }
}
