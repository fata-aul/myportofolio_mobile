

## Tugas 7

1. **Widget tree dan hubungan parent-child**  
   Widget tree adalah susunan widget bertingkat yang membentuk antarmuka Flutter. Widget parent menyusun atau memberi aturan kepada widget child. Contohnya, `Scaffold` menjadi parent bagi `AppBar` dan `body`, sedangkan `Padding` membungkus `Column` untuk memberi jarak. Perubahan pada parent dapat memengaruhi tata letak atau cara child ditampilkan.

2. **Widget yang digunakan dan fungsinya**  
   `MyApp` adalah widget root aplikasi, sedangkan `MyHomePage`, `InfoCard`, dan `ItemCard` adalah widget khusus proyek. `MaterialApp` menyediakan kerangka aplikasi Material, tema, dan halaman awal. `Scaffold` menyediakan struktur halaman. `AppBar` menampilkan bilah judul. `Padding` memberi jarak. `Column` menyusun widget secara vertikal, `Row` menyusun kartu identitas secara horizontal, dan `Expanded` membagi lebar baris. `Card` membingkai informasi, `Text` menampilkan tulisan, `SizedBox` memberi jarak, dan `GridView.count` menyusun kartu aksi dalam kisi. `Material` menyediakan latar dan bentuk kartu aksi, `InkWell` menangani sentuhan, `Icon` menampilkan ikon, dan `SnackBar` memberi umpan balik setelah tombol ditekan. `ThemeData` dan `ColorScheme` mengatur tampilan tema.

3. **Fungsi `MaterialApp`**  
   `MaterialApp` menjadi pembungkus utama aplikasi bergaya Material. Widget ini mengatur tema dan rute serta menyediakan konteks aplikasi yang diperlukan widget seperti `Scaffold` dan `Navigator`. Karena itu, `MaterialApp` lazim dipakai sebagai root widget.

4. **Perbedaan `StatelessWidget` dan `StatefulWidget`**  
   `StatelessWidget` cocok untuk tampilan yang tidak menyimpan keadaan yang berubah di dalam widget. `StatefulWidget` digunakan ketika antarmuka perlu diperbarui berdasarkan keadaan, misalnya nilai penghitung atau pilihan yang berubah setelah interaksi. Halaman dan kartu pada proyek ini cukup memakai `StatelessWidget`; `SnackBar` ditampilkan melalui `ScaffoldMessenger` tanpa menyimpan state halaman.

5. **`BuildContext`**  
   `BuildContext` adalah rujukan ke posisi sebuah widget di dalam widget tree. Melalui context, widget dapat menemukan informasi dari ancestor, misalnya mengambil `Theme` atau mengakses `ScaffoldMessenger`. Parameter ini digunakan di dalam `build` agar widget dapat membaca tema aktif dan menampilkan `SnackBar` pada scaffold yang sesuai.

6. **Hot reload, hot restart, dan full restart**  
   Hot reload menerapkan perubahan kode ke aplikasi yang sedang berjalan sambil mempertahankan state saat ini. Hot restart memulai ulang aplikasi Flutter dan menghapus state aplikasi, tetapi proses build native tidak selalu diulang. Full restart membangun serta menjalankan ulang aplikasi secara menyeluruh. Hot reload tidak cukup setelah perubahan yang memerlukan inisialisasi ulang, seperti perubahan tertentu pada `main()` atau state statis/global, dan untuk perubahan kode native seperti konfigurasi Android/iOS atau plugin. Dalam kondisi itu gunakan hot restart atau full restart sesuai jenis perubahannya.

## Penggunaan AI


ChatGPT digunakan untuk membantu meninjau kecocokan kode dengan instruksi dan merapikan implementasi Flutter.



## Tugas 8

1. **Perbedaan navigasi**  
   `Navigator.push()` menambahkan halaman ke atas navigation stack sehingga tombol kembali atau `Navigator.pop()` dapat kembali ke halaman sebelumnya. `Navigator.pushReplacement()` mengganti halaman paling atas, sehingga halaman lama tidak lagi menjadi tujuan tombol kembali. `Navigator.pop()` menutup halaman paling atas dan kembali ke halaman sebelumnya. Kartu **Tambah Edukasi** memakai `Navigator.push()` agar pengguna dapat kembali dari formulir ke beranda. Opsi **Home** pada drawer memakai `pushAndRemoveUntil()` untuk membuka beranda sekaligus membersihkan halaman di atasnya, jadi tombol kembali tidak membawa pengguna kembali ke formulir.

2. **Struktur halaman dan tema**  
   `Scaffold` menyediakan kerangka halaman, `AppBar` menampilkan judul dan tindakan, dan `Drawer` menjaga pilihan navigasi tetap tersedia di halaman utama maupun formulir. Keduanya memakai `Theme.of(context).colorScheme`; misalnya warna `primary` dipakai pada AppBar dan warna `onPrimary` untuk teksnya. Dengan begitu, warna utama tetap konsisten di kedua halaman.

3. **Tata letak responsif**  
   Form memakai `SingleChildScrollView` dan `Padding`. Scroll memungkinkan seluruh field dan tombol Simpan dijangkau pada layar pendek atau saat keyboard tampil, sedangkan padding menjaga isi tidak menempel ke tepi layar. `Column` menyusun input secara vertikal agar nyaman dibaca pada layar ponsel.

4. **Validasi form**  
   `GlobalKey<FormState>` memberi akses ke keadaan form, setiap `validator` memeriksa nilai sesuai aturannya, dan `validate()` menjalankan semua validator saat Simpan ditekan. Contohnya, nama institusi yang hanya berisi spasi ditolak setelah `trim()`, dan tanggal selesai sebelum tanggal mulai juga ditolak. Memilih jenis keyboard saja tidak cukup karena pengguna masih dapat mengirim nilai kosong, spasi, atau tanggal yang urutannya tidak masuk akal; validasi memeriksa makna dan aturan datanya.

### Penggunaan AI

ChatGPT membantu menyusun halaman formulir edukasi, navigasi, validasi. Implementasi dan hasil analisis tetap ditinjau di proyek Flutter.
