import 'package:apsiyonY/core/extensions/context_extensions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/colors.dart';
import '../../../../custom/custom_dialog.dart';
import '../../../../custom/custom_filled_button.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../services/user_service/user_service_provider.dart';
import '../../../../utils/wave_clipper.dart';
import '../providers/status_provider.dart';
import '../states/status_state/status_state.dart';

@RoutePage()
class ApartmentStatusPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(statusProvider);
    return Scaffold(
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                children: [
                  ClipPath(
                    clipper: WaveClipper(),
                    child: Assets.images.statusback.image(
                      height: context.screenHeight / 3,
                      width: context.screenWidth,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (state.demand != null) _DemandPart(),
                  SizedBox(height: 60.h),
                  Text('Sayın Oğuzhan,Özdemir;',
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.sp,
                          )),
                  SizedBox(height: 20.h),
                  Text("Bilgilerinizle eşleşen bir daire bulunmamaktadır."),
                  SizedBox(height: 20.h),
                  SizedBox(height: 30.h),
                  if (state.demand == null) _JoinButton(),
                  SizedBox(height: 80.h),
                  Text(
                      "user id: ${ref.read(userService.notifier).getUserid()}"),
                  SizedBox(height: 20.h),
                  Text(
                      "apartment status: ${ref.watch(userService).userData.apartment_status}"),
                ],
              ),
            ),
    );
  }
}

class _JoinButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(statusProvider);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: CustomFilledButton(
        onPressed: () {
          ref.read(statusProvider.notifier).setInitial();

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SelectionDialog(
                state: state,
                onItemSelected: (value) {
                  ref
                      .read(statusProvider.notifier)
                      .onChangedSelectedItem(value);
                },
                onItemSelected2: (value) {
                  ref
                      .read(statusProvider.notifier)
                      .onChangedSelectedApartmentNumber(value);
                },
              );
            },
          );
        },
        buttonText: "Yeni siteye katıl",
      ),
    );
  }
}

class SelectionDialog extends StatefulHookConsumerWidget {
  final StatusState state;
  final Function(String) onItemSelected;
  final Function(String) onItemSelected2;

  SelectionDialog(
      {required this.state,
      required this.onItemSelected,
      required this.onItemSelected2});

  @override
  _SelectionDialogState createState() => _SelectionDialogState();
}

class _SelectionDialogState extends ConsumerState<SelectionDialog> {
  late String? selectedItem;
  late String? selectedItem2;
  late List<String> apartmentNumbers;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.state.selectedItem;
    selectedItem2 = widget.state.selectedApartmentNumber;
    apartmentNumbers = widget.state.apartmentNumbers;
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(statusProvider);
    return AlertDialog(
      title: Text('Site/Apartman Seçimi'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              textAlign: TextAlign.center,
              "Apsiyona hoşgeldiniz. Lütfen site ve daire seçimi yapınız.",
              style: Theme.of(context).textTheme.displaySmall),
          SizedBox(height: 20.h),
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Apartman Seçiniz',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: ref
                  .read(statusProvider)
                  .apsiyonPoints
                  .map((e) => DropdownMenuItem<String>(
                        value: e.apartment_name,
                        child: Text(e.apartment_name),
                      ))
                  .toList(),
              value: ref.read(statusProvider).selectedItem,
              onChanged: (value) {
                ref.read(statusProvider.notifier).onChangedSelectedItem(value!);
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 200,
              ),
              dropdownStyleData: const DropdownStyleData(
                maxHeight: 200,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
              dropdownSearchData: DropdownSearchData(
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        // Apply the filter to the dropdown items here
                      });
                    },
                    expands: true,
                    maxLines: null,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search for an item...',
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value.toString().contains(searchValue);
                },
              ),
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  setState(() {
                    // Clear the filter here
                  });
                }
              },
            ),
          ),
          SizedBox(height: 20.h),
          Visibility(
            visible: ref.read(statusProvider).selectedItem != null,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Text(
                  'Daire Seçiniz',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: ref
                    .read(statusProvider)
                    .apartmentNumbers
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text("Daire ${e.toString()}"),
                        ))
                    .toList(),
                value: ref.read(statusProvider).selectedApartmentNumber,
                onChanged: (value) {
                  setState(() {
                    selectedItem2 = value;
                  });
                  widget.onItemSelected2(value!);
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 200,
                ),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    setState(() {
                      // Clear the filter here
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200.w,
                child: CustomFilledButton(
                    onPressed: () async {
                      final notofier = ref.read(statusProvider.notifier);
                      final state = ref.read(statusProvider);

                      if (state.selectedItem != null &&
                          state.selectedApartmentNumber != null) {
                        //değerler değişmediyse hata var
                        await notofier.setDemands();

                        state.demandFailure.fold(
                          () {
                            CustomDialog.success(
                              title: "Başarılı",
                              subtitle: "Seçiminiz başarıyla kaydedildi.",
                            ).show(context);
                          },
                          (a) => CustomDialog.failure(
                            title: "Hata",
                            subtitle: a.message,
                          ).show(context),
                        );
                      }
                    },
                    buttonText: "Seçimi Onayla"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DemandPart extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(statusProvider);
    return state.demand == null
        ? const CircularProgressIndicator.adaptive()
        : Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    width: 150.w,
                    child: Assets.images.statusback.image(
                      height: 150.h,
                      width: 150.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                SizedBox(
                  height: 140.h,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Başvuru",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                )),
                        SizedBox(height: 5.h),
                        Text("Appartman adı: ${state.demand!.apartment_name}"),
                        SizedBox(height: 5.h),
                        Text("Daire No: ${state.demand!.apartmentNumber}"),
                        SizedBox(height: 5.h),
                        Text(
                          "Status: ${state.demand!.status}",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                color: state.demand!.status == "Onaylandı"
                                    ? apsiyonPrimaryColor
                                    : apsiyonPrimaryColor,
                              ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 150.w,
                          height: 30.h,
                          child: CustomFilledButton(
                              color: Colors.red,
                              onPressed: () async {
                                final state = ref.watch(statusProvider);
                                final notifier =
                                    ref.read(statusProvider.notifier);

                                await notifier.deleteDemand();
                              },
                              buttonText: "Başvuruyu iptal et"),
                        ),
                      ]),
                )
              ],
            ),
          );
  }
}
