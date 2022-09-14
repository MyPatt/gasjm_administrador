import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/pedido_model.dart'; 
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/modules/detail/detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:meta/meta.dart' show required;

class Footer extends StatelessWidget {
  Footer({
    required this.house,
  });
  final PedidoModel house;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        width: double.infinity,
        height: Responsive.getScreenSize(context).height * .1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'price',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: AppTheme.blueDark, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () => _settingModalBottomSheet(context),
              /*  onTap: () {
                _settingModalBottomSheet();
                print("Click  me!");
              }, */
              child: Container(
                width: Responsive.getScreenSize(context).width * .4,
                height: Responsive.getScreenSize(context).height * .06,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppTheme.cyan,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text(
                  "Reserved Now!",
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<DetailController>(
          builder: (_) => Container(
            height: 380.0,
            padding: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 20.0),
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 80.0,
                    height: 10.0,
                    margin: EdgeInsets.only(top: 10.0, bottom: 25.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                Text(
                  "Reserver",
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: AppTheme.blueDark, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                InputText(
                  iconPrefix: Icons.calendar_today_outlined,
                  iconColor: AppTheme.light,
                  border: InputBorder.none,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  validator: null,
                  labelText: "Date",
                  filled: false,
                  enabledBorderColor: Colors.black26,
                  focusedBorderColor: AppTheme.cyan,
                  fontSize: 14.0,
                  fontColor: Colors.black45,
                  onChanged: _.onChangedDate,
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .02),
                InputText(
                  initialValue: "price",
                  iconPrefix: Icons.monetization_on,
                  readOnly: true,
                  iconColor: AppTheme.light,
                  border: InputBorder.none,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  validator: null,
                  labelText: "Price",
                  filled: false,
                  enabledBorderColor: Colors.black26,
                  focusedBorderColor: AppTheme.cyan,
                  fontSize: 14.0,
                  fontColor: Colors.black45,
                  //onChanged: _.onChangedPassword,
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .03),
                PrimaryButton(
                  texto: "Register",
                  onPressed: _.register,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .03),
              ],
            ),
          ),
        );
      },
    );
  }
}
