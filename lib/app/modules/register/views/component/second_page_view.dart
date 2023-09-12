import 'package:flutter/material.dart';
import 'package:ges2024/app/data/models/kabupaten_model.dart';
import 'package:ges2024/app/data/models/kecamatan_model.dart';
import 'package:ges2024/app/data/models/kelurahan_model.dart';
import 'package:ges2024/app/modules/register/controllers/register_controller.dart';
import 'package:get/get.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (controller) {
      controller.authC.provinsiController.text = "Jambi";
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Provinsi',
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextFormField(
              readOnly: true,
              controller: controller.authC.provinsiController,
              decoration: InputDecoration(
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              'Kabupaten / Kota',
            ),
            const SizedBox(
              height: 8.0,
            ),
            DropdownButtonFormField<Kabupaten>(
              isExpanded: true,
              validator: (value) {
                if (value == null) {
                  return 'Kabupaten tidak boleh kosong!';
                }
                return null;
              },
              hint: const Text("Pilih Kabupaten"),
              value: controller.selectedKabupaten,
              items: controller.dataKabupaten.map((item) {
                return DropdownMenuItem<Kabupaten>(
                  value: item,
                  child: Text("${item.type} ${item.name}"),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectedKabupaten = value;
                controller.authC.kabupatenController.text = value!.name;
                controller.getKecamatan(value.id).then((_) {
                  controller.getKelurahan(controller.dataKecamatan[0].id);
                });
              },
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              'Kecamatan',
            ),
            const SizedBox(
              height: 8.0,
            ),
            DropdownButtonFormField<Kecamatan>(
              isExpanded: true,
              validator: (value) {
                if (value == null) {
                  return 'Kecamatan tidak boleh kosong!';
                }
                return null;
              },
              hint: const Text("Pilih Kecamatan"),
              value: controller.selectedKecamatan,
              items: controller.dataKecamatan.map((item) {
                return DropdownMenuItem<Kecamatan>(
                  value: item,
                  child: Text(item.name),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectedKecamatan = value;
                controller.authC.kecamatanController.text = value!.name;
                controller.selectedKelurahan = null;
                controller.getKelurahan(value.id);
              },
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              'Kelurahan / Desa',
            ),
            const SizedBox(
              height: 8.0,
            ),
            DropdownButtonFormField<Kelurahan>(
              isExpanded: true,
              validator: (value) {
                if (value == null) {
                  return 'Kelurahan / Desa tidak boleh kosong!';
                }
                return null;
              },
              hint: const Text("Pilih Kelurahan / Desa"),
              value: controller.selectedKelurahan,
              items: controller.dataKelurahan.map((item) {
                return DropdownMenuItem<Kelurahan>(
                  value: item,
                  child: Text(item.name),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectedKelurahan = value;
                controller.authC.kelurahanController.text = value!.name;
              },
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'RT',
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: controller.authC.rtController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'RT tidak boleh kosong!';
                          }
                          if (!value.isNumericOnly) {
                            return 'RT tidak valid';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: '001',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'RW',
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: controller.authC.rwController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'RW tidak boleh kosong!';
                          }
                          if (!value.isNumericOnly) {
                            return 'RW tidak valid';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: '010',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              'Jalan / Lorong',
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextFormField(
              controller: controller.authC.lrgController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Lorong tidak boleh kosong!';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Masukan lorong atau jalan',
              ),
            ),
          ],
        ),
      );
    });
  }
}
