import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../utils/themes/app_color.dart';
import '../bloc/result_cubit.dart';
import '../bloc/states/result_state.dart';

class DevInfos extends StatefulWidget {
  final Size size;
  final String user;
  const DevInfos({super.key, required this.size, required this.user});

  @override
  State<DevInfos> createState() => _DevInfosState();
}

class _DevInfosState extends State<DevInfos> {
  final controller = Modular.get<ResultBloc>();

  @override
  void initState() {
    controller.getUser(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: controller,
      builder: (context, state) {
        if (state is LoadingResultState) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.purple1),
          );
        }

        if (state is SuccessResultUserState) {
          return Container(
            height: widget.size.height * .45,
            width: widget.size.width * .194,
            margin: EdgeInsets.only(
                top: widget.size.height * .085, left: widget.size.width * .078),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(widget.size.width * .00278),
            ),
            child: LayoutBuilder(builder: (context, constraints) {
              return Padding(
                padding: EdgeInsets.only(
                  top: constraints.maxHeight * .052,
                  left: constraints.maxWidth * .057,
                  right: constraints.maxWidth * .057,
                  bottom: constraints.maxHeight * .056,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: constraints.minHeight * .052,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.user.name,
                              style: TextStyle(
                                  color: AppColor.black1,
                                  fontSize: constraints.maxWidth * .071,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "@${state.user.login}",
                              style: TextStyle(
                                fontSize: constraints.maxWidth * .05,
                                color: AppColor.grey1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.user.bio,
                      style: TextStyle(
                        fontSize: constraints.maxWidth * .057,
                        color: AppColor.grey2,
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
