import 'package:flutter/material.dart';
import 'package:wena_partners/vendor/branches/models/branch_model.dart';
import 'package:wena_partners/vendor/branches/repository/branch_status_repository.dart';
import 'package:wena_partners/vendor/branches/repository/deletebranch_repository.dart';
import 'package:wena_partners/vendor/branches/repository/getbranch_repostitory.dart';
import 'package:wena_partners/vendor/branches/screens/add_branches_screen.dart';
import 'package:wena_partners/vendor/config/local_storage.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/utils/status.dart';
import 'package:wena_partners/vendor/widget/background_widget_wb.dart';
import 'package:wena_partners/vendor/widget/loading_dialog.dart';
import 'package:wena_partners/vendor/widget/loading_widget.dart';

class BranchesScreen extends StatefulWidget {
  @override
  _BranchesState createState() => _BranchesState();
}

class _BranchesState extends State<BranchesScreen> {
  final bool _isEnableBrachOne = false;
  final bool _isEnableBrachTow = false;
  final BranchListRepository _branchListRepository = BranchListRepository();
  final UpdateBranchStatusRepository _updateBranchStatusRepository =
      UpdateBranchStatusRepository();
  final DeleteBranchRepository _deleteBranchRepository = DeleteBranchRepository();
  String _userId = "";
  List<BranchModel> branchs = [];
  String deleteId = "";
  @override
  void initState() {
    // TODO: implement initState
    getBranch();
    super.initState();
  }

  getBranch() async {
    _userId = await LocalStorage.getUserId();
    _branchListRepository.getBranch(
        data: {"vendor_id": _userId},
        stateChange: () {
          if (mounted) {
            setState(() {});
            if (_branchListRepository.branchResp.status == Status.LOADING) {
              showLoadingDialog();
            } else if (_branchListRepository.branchResp.status ==
                Status.COMPLETED) {
              hideLoadingDialog();
            }
          }
        }).then((value) {
      if (value["body"]["code"] == 200) {
        branchs = value['body']["data"]
            .map<BranchModel>((json) => BranchModel.fromJson(json))
            .toList();
      }
    });
  }

  updateBranchStatusBranch(BranchModel model) async {
    _userId = await LocalStorage.getUserId();
    _updateBranchStatusRepository.updateBranchStatus(
        data: {"branch_id": model.intGlcode},
        stateChange: () {
          if (mounted) {
            setState(() {});
          }
          if (_updateBranchStatusRepository.branchResp.status ==
              Status.LOADING) {
            showLoadingDialog();
          } else if (_updateBranchStatusRepository.branchResp.status ==
              Status.COMPLETED) {
            hideLoadingDialog();
          }
        }).then((value) {
      if (value["body"]["code"] == 200) {
        if (mounted) {
          getBranch();
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWithBackMaterialWidget(
        Expanded(
            child: SingleChildScrollView(
                child: Container(
                    alignment: FractionalOffset.centerLeft,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left: dimen20,
                                  right: dimen20,
                                  top: dimen10,
                                  bottom: dimen10),
                              child: Row(children: [
                                Icon(
                                  Icons.add,
                                  color: const Color(colorSecondary),
                                  size: dimen16,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddBranchesScreen(
                                                    branchModel: BranchModel(
                                                        addressModel: []),
                                                  )));
                                    },
                                    child: Container(
                                        color: Colors.transparent,
                                        child: Text(
                                          "Add branch",
                                          style:
                                              textSegoeUiColorSecondarySize16Bold,
                                        ))),
                              ])),
                          SizedBox(
                            height: dimen20,
                          ),
                          Container(
                            height: 1,
                            color: const Color(colorContent).withOpacity(0.2),
                          ),
                          SizedBox(
                            height: dimen20,
                          ),
                          (_branchListRepository.branchResp.status !=
                                      Status.LOADING &&
                                  branchs.isEmpty)
                              ? Container(
                                  alignment: FractionalOffset.center,
                                  child: Text(
                                    "data not found",
                                    style: textSegoeUiColor292D32Size18Light,
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: branchs.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: ((context, index) => Container(
                                        child: Column(children: [
                                          Container(
                                            alignment:
                                                FractionalOffset.centerLeft,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                      child: Container(
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${branchs[index]
                                                                    .varName!} ${branchs[index]
                                                                    .varSurname!}",
                                                            style:
                                                                textSegoeUiColor161616Size16,
                                                          ),
                                                          SizedBox(
                                                            height: dimen10,
                                                          ),
                                                          Text('', style:
                                                            textSegoeUiColorContentSize16Light,
                                                          )
                                                          // Text(
                                                          //   "${branchs[index].addressModel[0].varAddress!}, ${branchs[index].addressModel[0].varLandmark!}, ${branchs[index].addressModel[0].varCity!}, ${branchs[index].addressModel[0].varState}, ${branchs[index].addressModel[0].varCountry}, ${branchs[index].addressModel[0].varPincode!}",
                                                          //   style:
                                                          //       textSegoeUiColorContentSize16Light,
                                                          // )
                                                        ]),
                                                  )),
                                                  Column(children: [
                                                    Switch(
                                                      value: branchs[index]
                                                                  .chrPublish ==
                                                              "Y"
                                                          ? true
                                                          : false,
                                                      activeColor:
                                                          const Color(colorSecondary),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          if (value) {
                                                            branchs[index]
                                                                    .chrPublish =
                                                                "Y";
                                                          } else {
                                                            branchs[index]
                                                                    .chrPublish =
                                                                "N";
                                                          }
                                                          updateBranchStatusBranch(
                                                              branchs[index]);
                                                        });
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: dimen10,
                                                    ),
                                                    Row(children: [
                                                      (_deleteBranchRepository
                                                                      .branchResp
                                                                      .status ==
                                                                  Status
                                                                      .LOADING &&
                                                              branchs[index]
                                                                      .intGlcode ==
                                                                  deleteId)
                                                          ? SizedBox(
                                                              height: dimen24,
                                                              width: dimen24,
                                                              child:
                                                                  LoadingWidgetGreen())
                                                          : GestureDetector(
                                                              onTap: () {
                                                                deleteId = branchs[
                                                                        index]
                                                                    .intGlcode!;
                                                                _deleteBranchRepository
                                                                    .deleteBranch(
                                                                        data: {
                                                                      "branch_id":
                                                                          branchs[index]
                                                                              .intGlcode,
                                                                    },
                                                                        stateChange:
                                                                            () {
                                                                          if (mounted) {
                                                                            setState(() {});
                                                                          }
                                                                        }).then((value) {
                                                                  getBranch();
                                                                });
                                                              },
                                                              child: Container(
                                                                  padding:
                                                                      const EdgeInsets.all(
                                                                          2),
                                                                  decoration: BoxDecoration(
                                                                      color: const Color(
                                                                          colorLightRed),
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(
                                                                              dimen20))),
                                                                  margin: EdgeInsets.only(
                                                                      right:
                                                                          dimen10),
                                                                  child:
                                                                      Image.asset(
                                                                    "assets/icons/trash.png",
                                                                    width:
                                                                        dimen26,
                                                                    height:
                                                                        dimen26,
                                                                  ))),
                                                      SizedBox(
                                                        width: dimen10,
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            AddBranchesScreen(
                                                                              forEdit: true,
                                                                              branchId: branchs[index].intGlcode!,
                                                                              branchModel: branchs[index],
                                                                            )));
                                                          },
                                                          child: Image.asset(
                                                            "assets/icons/edit_circle.png",
                                                            width: dimen30,
                                                            height: dimen30,
                                                          ))
                                                    ])
                                                  ]),
                                                ]),
                                          ),
                                          SizedBox(
                                            height: dimen20,
                                          ),
                                          Container(
                                            height: 1,
                                            color: const Color(colorContent)
                                                .withOpacity(0.2),
                                          ),
                                          SizedBox(
                                            height: dimen20,
                                          ),
                                        ]),
                                      )))
                        ])))),
        "Branches");
  }
}
