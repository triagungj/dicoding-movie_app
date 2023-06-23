# Dicoding Submission Akhir

---

[![Codemagic build status](https://api.codemagic.io/apps/6495e63bd062fbd108096fb1/6495e63bd062fbd108096fb0/status_badge.svg)](https://codemagic.io/apps/<app-id>/<workflow-id>/latest_build)

## How To

Project ini mengimplementasikan modularisasi, dimana didalamnya terdapat beberapa package yang dikembangkan secara terpisah. Pada project ini disarankan menggunakan dev_depencies:melos supaya lebih mudah untuk melakukan Get Packages di setiap package nya.

### 1. Aktifkan Melos Global

Aktifkan terlebih dahulu package dev_dependencies:melos secara global. Jika sebelumnya sudah mengaktifkannya maka dapat melanjutkan langkah ke-2.

```sh
dart pub global activate melos
```

### 2. Jalankan melos bootstrap

Untuk melakukan Get Packages di setiap packages nya, jalankan command dibawah ini:

```sh
melos bootstrap
```

## Tips Submission Akhir

Jika kamu menerapkan modular pada project, Anda dapat memanfaatkan berkas `test.sh` pada repository ini. Berkas tersebut dapat mempermudah proses testing melalui *terminal* atau *command prompt*. Sebelumnya menjalankan berkas tersebut, ikuti beberapa langkah berikut:

1. Install terlebih dahulu aplikasi sesuai dengan Operating System (OS) yang Anda gunakan.

- Bagi pengguna **Linux**, jalankan perintah berikut pada terminal.

```sh
sudo apt-get update -qq -y
sudo apt-get install lcov -y
```

- Bagi pengguna **Mac**, jalankan perintah berikut pada terminal.

```sh
brew install lcov
```

- Bagi pengguna **Windows**, ikuti langkah berikut.
- Install [Chocolatey](https://chocolatey.org/install) pada komputermu.
- Setelah berhasil, install [lcov](https://community.chocolatey.org/packages/lcov) dengan menjalankan perintah berikut.

```sh
choco install lcov
```

- Kemudian cek __Environtment Variabel__ pada kolom __System variabels__ terdapat variabel GENTHTML dan LCOV_HOME. Jika tidak tersedia, Anda bisa menambahkan variabel baru dengan nilai seperti berikut.
   | Variable | Value|
   | ----------- | ----------- |
   | GENTHTML | C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml |
   | LCOV_HOME | C:\ProgramData\chocolatey\lib\lcov\tools |

2. Untuk mempermudah proses verifikasi testing, jalankan perintah berikut.

```text
git init
```

3. Kemudian jalankan berkas `test.sh` dengan perintah berikut pada *terminal* atau *powershell*.

```text
test.sh
```

atau

```text
./test.sh
```

Proses ini akan men-*generate* berkas `lcov.info` dan folder `coverage` terkait dengan laporan coverage.

4. Tunggu proses testing selesai hingga muncul web terkait laporan coverage.

