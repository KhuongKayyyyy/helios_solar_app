import 'package:get/get.dart';
import 'package:helios/core/constants/color_constants.dart';

import 'package:helios/data/app_data/app_exports.dart';

import 'app_button.dart';
import 'app_text.dart';

// ignore: must_be_immutable
class DeleteBottomSheet extends StatefulWidget {
  DeleteBottomSheet({super.key, required this.onTapDelete});
  Function() onTapDelete;

  @override
  State<DeleteBottomSheet> createState() => _DeleteBottomSheet();
}

class _DeleteBottomSheet extends State<DeleteBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                AppText(
                  text: "삭제할까요?",
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 8),
                AppText(
                  text: "삭제하면 되돌릴 수 없어요",
                  fontSize: 16,
                  color: ColorConstants.color9d,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 24),
              Expanded(
                child: AppButton(
                  text: "취소",
                  color: ColorConstants.colorf2f2f2,
                  margin: 0,
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton(
                  text: "삭제",
                  color: const Color(0xfff05858),
                  margin: 0,
                  textColor: Colors.white,
                  onTap: () {
                    Get.back();
                    widget.onTapDelete();
                  },
                ),
              ),
              const SizedBox(width: 24),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 24),
        ],
      ),
    );
  }
}
