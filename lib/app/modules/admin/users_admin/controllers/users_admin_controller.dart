import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ges2024/app/modules/admin/users_admin/views/user_detail_admin_view.dart';
import 'package:http/http.dart' as http;
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/controllers/auth_controller.dart';
import 'package:ges2024/app/data/models/downline_model.dart';
import 'package:ges2024/app/data/models/kabupaten_model.dart';
import 'package:ges2024/app/data/models/kecamatan_model.dart';
import 'package:ges2024/app/data/models/kelurahan_model.dart';
import 'package:ges2024/app/data/models/user_model.dart';
import 'package:ges2024/app/data/services/api_services.dart';
import 'package:ges2024/app/data/services/notification_services.dart';
import 'package:ges2024/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UsersAdminController extends GetxController {
  final authC = Get.find<AuthController>();
  var users = RxList<UserModel>([]);
  var listSearch = RxList<UserModel>([]);

  String imagePath = '';
  String ktpPath = '';
  final picker = ImagePicker();

  RxBool isLoading = false.obs;

  var sortNameAsc = true;
  var sortAgeAsc = true;
  var sortHightAsc = true;
  var sortAsc = true;
  int? sortColumnIndex;

  Kabupaten? selectedKabupaten;
  Kecamatan? selectedKecamatan;
  Kelurahan? selectedKelurahan;
  String? selectedStatus;
  String statusMessage = '';

  List<Kabupaten> dataKabupaten = [];
  List<Kecamatan> dataKecamatan = [];
  List<Kelurahan> dataKelurahan = [];

  var keyword = ''.obs;
  final TextEditingController searchC = TextEditingController();
  void changeKeyword() {
    keyword.value = searchC.text;
  }

  searchUsers(String value) {
    listSearch.value = users
        .where((user) =>
            user.toString().toLowerCase().contains(value.toLowerCase()) ||
            user.toString().toLowerCase().startsWith(value.toLowerCase()))
        .toList();
    update();
  }

  @override
  void onInit() {
    debounce(
      time: const Duration(seconds: 1),
      keyword,
      (callback) {
        listSearch.clear();
        searchUsers(searchC.text);
      },
    );
    search();
    selectedStatus = 'Semua';
    super.onInit();
  }

  void sortName(int columnIndex, bool ascending) {
    if (columnIndex == sortColumnIndex) {
      sortAsc = sortNameAsc = ascending;
    } else {
      sortColumnIndex = columnIndex;
      sortAsc = sortNameAsc;
    }
    users.sort((a, b) => a.namaLengkap!.compareTo(b.namaLengkap!));
    if (!sortAsc) {
      users.value = users.reversed.toList();
    }
    update();
  }

  void sortStatus(int columnIndex, bool ascending) {
    if (columnIndex == sortColumnIndex) {
      sortAsc = sortNameAsc = ascending;
    } else {
      sortColumnIndex = columnIndex;
      sortAsc = sortNameAsc;
    }
    users.sort((a, b) => a.status!.compareTo(b.status!));
    if (!sortAsc) {
      users.value = users.reversed.toList();
    }
    update();
  }

  void sortKabupaten(int columnIndex, bool ascending) {
    if (columnIndex == sortColumnIndex) {
      sortAsc = sortNameAsc = ascending;
    } else {
      sortColumnIndex = columnIndex;
      sortAsc = sortNameAsc;
    }
    users.sort((a, b) => a.kabupaten!.compareTo(b.kabupaten!));
    if (!sortAsc) {
      users.value = users.reversed.toList();
    }
    update();
  }

  void sortKecamatan(int columnIndex, bool ascending) {
    if (columnIndex == sortColumnIndex) {
      sortAsc = sortNameAsc = ascending;
    } else {
      sortColumnIndex = columnIndex;
      sortAsc = sortNameAsc;
    }
    users.sort((a, b) => a.kecamatan!.compareTo(b.kecamatan!));
    if (!sortAsc) {
      users.value = users.reversed.toList();
    }
    update();
  }

  void sortKelurahan(int columnIndex, bool ascending) {
    if (columnIndex == sortColumnIndex) {
      sortAsc = sortNameAsc = ascending;
    } else {
      sortColumnIndex = columnIndex;
      sortAsc = sortNameAsc;
    }
    users.sort((a, b) => a.kelurahan!.compareTo(b.kelurahan!));
    if (!sortAsc) {
      users.value = users.reversed.toList();
    }
    update();
  }

  void sortRt(int columnIndex, bool ascending) {
    if (columnIndex == sortColumnIndex) {
      sortAsc = sortNameAsc = ascending;
    } else {
      sortColumnIndex = columnIndex;
      sortAsc = sortNameAsc;
    }
    users.sort((a, b) => a.rt!.compareTo(b.rt!));
    if (!sortAsc) {
      users.value = users.reversed.toList();
    }
    update();
  }

  void sortRw(int columnIndex, bool ascending) {
    if (columnIndex == sortColumnIndex) {
      sortAsc = sortNameAsc = ascending;
    } else {
      sortColumnIndex = columnIndex;
      sortAsc = sortNameAsc;
    }
    users.sort((a, b) => a.rw!.compareTo(b.rw!));
    if (!sortAsc) {
      users.value = users.reversed.toList();
    }
    update();
  }

  Future importUsers() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      allowMultiple: false,
    );

    if (pickedFile != null) {
      try {
        File file = File(pickedFile.files.single.path!);

        var bytes = file.readAsBytesSync();
        var excel = Excel.decodeBytes(bytes);
        List<UserModel> listUser = [];

        for (var table in excel.tables.keys) {
          for (var row in excel.tables[table]!.rows) {
            String originalNumber = row[2]!.value.toString();
            String newNumber;
            if (originalNumber.startsWith("62")) {
              newNumber = "0${originalNumber.substring(2)}";
            } else {
              newNumber =
                  originalNumber; // biarkan tetap sama jika tidak dimulai dengan "62"
            }
            listUser.add(UserModel(
              namaLengkap: row[0]?.value.toString(),
              namaPanggilan: row[1]?.value.toString(),
              noHp: newNumber,
              email: row[3]?.value.toString(),
              nik: row[4]?.value.toString(),
              kabupaten: row[5]?.value.toString(),
              kecamatan: row[6]?.value.toString(),
              kelurahan: row[7]?.value.toString(),
              rt: row[8]?.value.toString(),
              rw: row[9]?.value.toString(),
              lrg: row[10]?.value.toString(),
              status: row[11]?.value.toString(),
              referalDari: row[12]?.value.toString(),
              // foto: ,
              // fotoKtp: ,
              // id: ,
              // kodeReferal: ,
              // provinsi: ,
            ));
          }
        }
        listUser.removeAt(0);
        log(listUser.toString());

        Get.toNamed(Routes.IMPORTED_ADMIN, arguments: listUser);
        EasyLoading.dismiss();
      } catch (e) {
        EasyLoading.dismiss();
        EasyLoading.showError("Format Tidak Sesuai!");
      }
    } else {
      EasyLoading.dismiss();
    }
  }

  Future<void> createExcel() async {
    String kabupaten =
        selectedKabupaten?.name == null ? "Semua" : selectedKabupaten!.name;
    String kecamatan =
        selectedKecamatan?.name == null ? "Semua" : selectedKecamatan!.name;
    String kelurahan =
        selectedKelurahan?.name == null ? "Semua" : selectedKelurahan!.name;
    String status = selectedStatus == null ? "Semua" : selectedStatus!;
    try {
      EasyLoading.show(
        status: 'Mengekspor Data ...',
        maskType: EasyLoadingMaskType.black,
      );
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Data Anggota'];
      excel.setDefaultSheet("Data Anggota");
      sheetObject.appendRow([
        'Kabupaten / Kota',
        ':',
        kabupaten,
      ]);
      sheetObject.appendRow([
        'Kecamatan',
        ':',
        kecamatan,
      ]);
      sheetObject.appendRow([
        'Kelurahan / Desa',
        ':',
        kelurahan,
      ]);
      sheetObject.appendRow([
        'Status',
        ':',
        status,
      ]);
      sheetObject.appendRow([
        "",
      ]);
      sheetObject.appendRow([
        'No',
        'Nama',
        'No HP',
        'Email',
        'NIK',
        'Kabupaten',
        'Kecamatan',
        'Kelurahan',
        'RT',
        'RW',
        'Lorong / Jalan',
        'Referal',
        'Jml Rekrut'
      ]);
      for (var i = 0; i < users.length; i++) {
        var item = users[i];
        await getDownlines(item.id!).then(
          (downlines) => sheetObject.appendRow(
            [
              i + 1,
              item.namaLengkap,
              item.noHp,
              item.email,
              item.nik,
              item.kabupaten,
              item.kecamatan,
              item.kelurahan,
              item.rt,
              item.rw,
              item.lrg,
              item.kodeReferal,
              downlines.length,
            ],
          ),
        );
      }
      var fileBytes = excel.save();

      File(
          'storage/emulated/0/Download/data_anggota_${DateTime.now().day}_${DateTime.now().month}_${DateTime.now().year}_${DateTime.now().hour}_${DateTime.now().minute}.xlsx')
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);
      EasyLoading.dismiss();
      NotificationService().showNotification(
          'storage/emulated/0/Download/data_anggota_${DateTime.now().day}_${DateTime.now().month}_${DateTime.now().year}_${DateTime.now().hour}_${DateTime.now().minute}.xlsx');
      EasyLoading.showToast(
          'File Tersimpan!\nstorage/emulated/0/Download/data_anggota_${DateTime.now().day}_${DateTime.now().month}_${DateTime.now().year}_${DateTime.now().hour}_${DateTime.now().minute}.xlsx',
          toastPosition: EasyLoadingToastPosition.bottom);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }

  Future<void> search() async {
    try {
      String kabupaten = selectedKabupaten?.name == null
          ? ""
          : selectedKabupaten?.name == "Semua"
              ? ""
              : selectedKabupaten!.name;
      String kecamatan = selectedKecamatan?.name == null
          ? ""
          : selectedKecamatan?.name == "Semua"
              ? ""
              : selectedKecamatan!.name;
      String kelurahan = selectedKelurahan?.name == null
          ? ""
          : selectedKelurahan?.name == "Semua"
              ? ""
              : selectedKelurahan!.name;
      String status = selectedStatus == null
          ? ""
          : selectedStatus == "Semua"
              ? ""
              : selectedStatus!;
      isLoading.value = true;
      await ApiService.get(
              endpoint: AppString.filterUsers,
              token: authC.userToken.value,
              parameter:
                  'kabupaten=$kabupaten&kecamatan=$kecamatan&kelurahan=$kelurahan&status=$status')
          .then((response) async {
        users.clear();
        var data = json.decode(response.body);
        if (response.statusCode == 200) {
          if (kDebugMode) {
            print(data['users'].length);
          }
          for (var element in data['users']) {
            Map<String, dynamic> userData = element;
            await getDownlines(userData['id']).then((downline) {
              userData.addAll({
                'jumlahRekrut': downline.length,
                'downline': downline,
              });
            });
            users.add(UserModel.fromJson(userData));
          }
        } else {
          if (kDebugMode) {
            print(data['message']);
          }
          if (data['message'].toString().contains("Attempts")) {
            statusMessage =
                'Terlalu banyak percobaan!\nSilahkan coba dalam beberapa saat lagi!';
          } else {
            statusMessage = data['message'];
          }
        }
        isLoading.value = false;
      });
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<List<Downline>> getDownlines(int id) async {
    List<Downline> finalDownlines = [];
    List<Downline> subDownlines = [];
    return await ApiService.get(
      endpoint: AppString.userDowlines,
      token: authC.userToken.value,
      parameter: "id=$id",
    ).then((response) {
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<dynamic> downlines = data['downlines'];
        if (downlines.isNotEmpty) {
          for (var singleUser in downlines) {
            finalDownlines.add(Downline.fromJson(singleUser));
            if (singleUser['total_downlines'] > 0) {
              for (var downline in singleUser['downlines']) {
                subDownlines.add(Downline.fromJson(downline));
              }
            }
          }
        }
        for (var downline in subDownlines) {
          finalDownlines.add(downline);
        }
      } else {}
    }).then((value) => finalDownlines);
  }

  void pickImage() async {
    imagePath = '';
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath = image.path;
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePath,
        maxWidth: 500,
        maxHeight: 500,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Sesuaikan Foto',
            toolbarColor: AppColor.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            hideBottomControls: false,
            dimmedLayerColor: Colors.black.withOpacity(0.8),
            showCropGrid: false,
          ),
        ],
        compressQuality: 60,
      );
      if (croppedFile != null) {
        imagePath = croppedFile.path;
        authC.fotoController.text = imagePath;
      }
    }
    update();
  }

  void pickKTP() async {
    ktpPath = '';
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      ktpPath = image.path;
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: ktpPath,
        maxWidth: 1000,
        maxHeight: 500,
        aspectRatioPresets: [
          CropAspectRatioPreset.ratio16x9,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Sesuaikan Foto',
            toolbarColor: AppColor.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio16x9,
            lockAspectRatio: true,
            hideBottomControls: false,
            dimmedLayerColor: Colors.black.withOpacity(0.8),
            showCropGrid: false,
          ),
        ],
        compressQuality: 60,
      );
      if (croppedFile != null) {
        ktpPath = croppedFile.path;
        authC.ktpController.text = ktpPath;
      }
    }
    update();
  }

  Future<void> getKabupaten() async {
    dataKabupaten.clear();
    await ApiService.get(
            endpoint: AppString.kabupaten, parameter: 'provinsi_id=8')
        .then((response) {
      var data = json.decode(response.body);
      dataKabupaten.add(Kabupaten(
        id: 0,
        name: "Semua",
        type: "",
        provinsiId: 8,
      ));
      for (var element in data) {
        dataKabupaten.add(Kabupaten.fromJson(element));
      }
    });
    selectedKabupaten = dataKabupaten[0];
    update();
  }

  Future<void> getKecamatan(int idKabupaten) async {
    dataKecamatan.clear();
    await ApiService.get(
            endpoint: AppString.kecamatan,
            parameter: 'kabupaten_id=$idKabupaten')
        .then((response) {
      dataKecamatan.add(Kecamatan(id: 0, name: 'Semua', kabupatenId: 0));
      var data = json.decode(response.body);
      for (var element in data) {
        dataKecamatan.add(Kecamatan.fromJson(element));
      }
    });
    selectedKecamatan = dataKecamatan[0];
    update();
  }

  Future<void> getKelurahan(int idKecamatan) async {
    dataKelurahan.clear();
    await ApiService.get(
            endpoint: AppString.kelurahan,
            parameter: 'kecamatan_id=$idKecamatan')
        .then((response) {
      dataKelurahan
          .add(Kelurahan(id: 0, name: 'Semua', kecamatanId: 0, posCode: ""));
      var data = json.decode(response.body);
      for (var element in data) {
        dataKelurahan.add(Kelurahan.fromJson(element));
      }
    });
    selectedKelurahan = dataKelurahan[0];
    update();
  }

  void all() {
    selectedKabupaten = dataKabupaten[0];
    dataKecamatan.clear();
    dataKecamatan.add(Kecamatan(id: 0, name: 'Semua', kabupatenId: 0));
    selectedKecamatan = dataKecamatan[0];
    dataKelurahan.clear();
    dataKelurahan
        .add(Kelurahan(id: 0, name: 'Semua', kecamatanId: 0, posCode: ""));
    selectedKelurahan = dataKelurahan[0];

    update();
  }

  Future<void> editUser(UserModel user) async {
    try {
      EasyLoading.show(
        status: 'Loading ...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var headers = {'Accept': 'application/json'};
      var request = http.MultipartRequest(
          'POST', Uri.parse("${AppString.baseUrl}${AppString.updateUser}"));
      request.fields.addAll({
        'id': user.id.toString(),
        'nama_lengkap': authC.nameController.text,
        'nama_panggilan': authC.namaPanggilanController.text,
        'email': authC.emailController.text,
        'no_hp': authC.phoneController.text,
        'nik': authC.nikController.text,
        'provinsi': authC.provinsiController.text,
        'kabupaten': authC.kabupatenController.text,
        'kecamatan': authC.kecamatanController.text,
        'kelurahan': authC.kelurahanController.text,
        'rt': authC.rtController.text,
        'rw': authC.rwController.text,
        'lrg': authC.lrgController.text,
        'kode_referal': user.kodeReferal!,
        'status': authC.statusController.text,
      });

      request.headers.addAll(headers);
      if (authC.fotoController.text.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'foto', authC.fotoController.text));
      }
      if (authC.ktpController.text.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'foto_ktp', authC.ktpController.text));
      }
      request.headers
          .addAll({'Authorization': 'Bearer ${authC.userToken.value}'});

      http.StreamedResponse response =
          await request.send().timeout(const Duration(milliseconds: 200000));
      print(response.statusCode);
      if (response.statusCode == 200) {
        selectedKabupaten = null;
        selectedKecamatan = null;
        selectedKelurahan = null;
        selectedStatus = null;
        await search().then((_) {
          EasyLoading.dismiss();
          Get.off(() => UserDetailAdminView(
              user: users.where((userData) => userData.id == user.id).first));
          EasyLoading.showSuccess('User Berhasil Diperbarui');
          authC.clear();
        });
      } else {
        EasyLoading.dismiss();
        var res = await response.stream.bytesToString();
        print(res);
        throw "Update Gagal!\nPeriksa kembali inputan anda atau antara email dan nomor hp sudah digunakan pengguna lain!";
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(
        e.toString(),
        duration: const Duration(seconds: 5),
      );
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      await ApiService.delete(
              endpoint: "${AppString.users}/$id", token: authC.userToken.value)
          .then((response) async {
        var data = json.decode(response.body);

        if (response.statusCode == 200) {
          await search().then((_) {
            EasyLoading.dismiss();
            Get.back();
            Get.back();
            EasyLoading.showSuccess('User Berhasil Dihapus');
            authC.clear();
          });
        } else {
          throw data;
        }
        print(response.statusCode);
      });
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }
}
