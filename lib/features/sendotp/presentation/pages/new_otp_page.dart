import 'package:bitcope/core/utils/sizeconfig.dart';
import 'package:bitcope/features/authentication/authentication_bloc.dart';
import 'package:bitcope/features/sendotp/data/repository/otp_repository.dart';
import 'package:bitcope/features/sendotp/presentation/bloc/otp_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewOTPPage extends StatelessWidget {
  final String transactionId;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _phoneNoController = TextEditingController();

  NewOTPPage({Key key, this.transactionId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final otpRepository = OTPRepository();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Bitecope'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
            child: Icon(
              FontAwesomeIcons.signOutAlt,
            ),
          ),
          SizedBox(
            width: 6.0 * SizeConfig.widthMultiplier,
          )
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return OTPBloc(otpRepository: otpRepository);
            },
          ),
        ],
        child: BlocBuilder<OTPBloc, OTPState>(
          builder: (context, state) {
            if (state is OTPInitial) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    //stops: [0.3, 0.6, .9],
                    colors: [
                      Color(0xff993164),
                      Color(0xff6E3869),
                      Color(0xff323F6C),
                    ],
                  ),
                ),
              );
            }
            if (state is OTPHasSent) {
              _phoneNoController.clear();
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    //stops: [0.3, 0.6, .9],
                    colors: [
                      Color(0xff993164),
                      Color(0xff6E3869),
                      Color(0xff323F6C),
                    ],
                  ),
                ),
              );
            }
            if (state is OTPHasVerfied) {
              return Container(child: Text("Delivery Completed"));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
