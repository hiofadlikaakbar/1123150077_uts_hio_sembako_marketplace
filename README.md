<h2>Arsitektur Aplikasi</h2>
<p>
Aplikasi ini menggunakan pendekatan <strong>modular architecture</strong> dengan pemisahan yang jelas antara UI, logic, dan data.
</p>

<p><strong>Struktur utama:</strong></p>

<pre>
features/  → UI berdasarkan fitur (auth, home, cart, dll)
models/    → Representasi data (Product Model)
services/  → Handling API & Firebase
providers/ → State management (Provider + ChangeNotifier)
widgets/   → Komponen UI reusable
</pre>

<p>
Pendekatan ini membuat aplikasi lebih mudah dikembangkan, scalable, dan maintainable.
</p>

<hr/>

<h2>Demo Fitur</h2>

<h3>Register & Verify Email</h3>
<p>
User melakukan registrasi menggunakan email dan password, kemudian wajib melakukan verifikasi email sebelum bisa login.
</p>

<div align="center">
  <img src="https://github.com/user-attachments/assets/6c4b030e-91a7-41ad-af36-e6e4c0e73641" width="250" style="margin:5px;"/>
  <img src="https://github.com/user-attachments/assets/f03a5855-8a04-4096-a30f-7e9607501654" width="250" style="margin:5px;"/>
  <img src="https://github.com/user-attachments/assets/ab922518-175a-4639-a640-da226f2af669" width="250" style="margin:5px;"/>
</div>

<hr/>

<h3>Login</h3>
<p>
User login menggunakan akun yang sudah diverifikasi. Sistem akan mengambil Firebase token dan mengirimkannya ke backend untuk mendapatkan JWT.
</p>

<div align="center">
  <img src="https://github.com/user-attachments/assets/cad31968-4070-4409-9f0c-62508c8f5547" width="250" style="margin:5px;"/>
  <img src="https://github.com/user-attachments/assets/87c7d7c7-f55f-4d0f-9685-d121f8684450" width="250" style="margin:5px;"/>
</div>

<hr/>

<h3>Catalog</h3>
<p>
Menampilkan daftar produk dari Firebase dan ditampilkan di aplikasi.
</p>

<div align="center">
  <img src="https://github.com/user-attachments/assets/7ba29e26-e963-489a-9851-e1704fd22d7e" width="250" style="margin:5px;"/>
  <img src="https://github.com/user-attachments/assets/fb8df770-61ca-4bbf-872c-f38966f8ac54" width="250" style="margin:5px;"/>
</div>

<hr/>

<h3>Cart & Checkout</h3>
<p>
User dapat menambahkan dan menghapus produk dari keranjang. Total harga akan ter-update secara otomatis.
</p>

<div align="center">
  <img src="https://github.com/user-attachments/assets/977dfe4a-dd57-44d2-9d22-eadd1b6e9a4e" width="250" style="margin:5px;"/>
</div>

<hr/>

<h2>Penjelasan Code</h2>

<h3>Provider</h3>
<p>
State management menggunakan <strong>Provider</strong> dengan <strong>ChangeNotifier</strong>.
Setiap perubahan state akan memanggil <code>notifyListeners()</code> untuk memperbarui UI secara realtime.
</p>

<h3>State Flow</h3>

<pre>
User Action → Provider → Update State → notifyListeners() → UI Rebuild
</pre>

<p>
Contoh: saat user menambahkan produk ke cart, data disimpan di <code>cart_provider</code> lalu UI otomatis update.
</p>

<h3>API Integration</h3>

<pre>
Login Firebase → Ambil Token → Kirim ke Backend → Terima JWT → Akses API
</pre>

<p>
JWT digunakan sebagai autentikasi untuk request API berikutnya seperti mengambil data produk.
</p>
