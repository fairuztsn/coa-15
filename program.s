.data
    header: .asciiz "\nIF-47-03 Kelompok 6\nSanubari Nuraulia Legawa\t103012300347\nMuhammad Daffa Fariza\t\t103012300004\nMuhammad Rifaldi Usman\t\t103012300017\nFairuztsani Kemal Setiawan\t103012300048\n\nUntuk keluar dari program, masukkan angka 1502 pada saat input panjang persegi panjang\n\n"
    newline: .asciiz "\n"
    
    exiting_program_msg: .asciiz "Exiting program..."

    HARUS_POSITIF_msg: .asciiz "Input ukuran harus lebih dari 0\n"
    HARUS_BEDA_msg: .asciiz "Panjang dan lebar tidak boleh sama\n"

    prompt_panjang: .asciiz "Masukkan panjang: "
    prompt_lebar: .asciiz "Masukkan lebar: "

    SMALL_msg: .asciiz "PERSEGI PANJANG KECIL"
    MEDIUM_msg: .asciiz "PERSEGI PANJANG SEDANG"
    LARGE_msg: .asciiz "PERSEGI PANJANG BESAR"
.text
.globl main # Mendeklarasikan label main sebagai global sehingga dapat dipanggil dari luar file jika diperlukan.
main:
    # Memuat nilai 1502 ke $t4
    li $t4, 1502

    # Print header
    li $v0, 4 # Menyiapkan syscall untuk mencetak string.
    la $a0, header # Memuat alamat string header ke register $a0 sebagai argumen untuk syscall.
    syscall # Menjalankan syscall untuk mencetak informasi kelompok, instruksi, dan cara keluar dari program.

    jal MASUKAN # Lompat ke subrutin MASUKAN untuk meminta input panjang dan lebar.
    jal HITUNG # Lompat ke subrutin HITUNG untuk menghitung luas persegi panjang berdasarkan panjang dan lebar yang dimasukkan.
    jal KELUARAN # Lompat ke subrutin KELUARAN untuk menampilkan hasil luas dan kategorinya.

    j exit # Lompat ke label exit untuk mengakhiri program.

MASUKAN:
INPUT_PANJANG:
    # Print prompt
    li $v0, 4 # Memilih syscall 4 untuk print_string.
    la $a0, prompt_panjang # Memuat alamat string "Masukkan panjang: " ke register $a0.
    syscall # Mencetak string di layar.

    # Input integer
    li $v0, 5 # Memilih syscall 5 untuk read_integer dari pengguna.
    syscall # Mengambil input dan menyimpannya di $v0.
    move $t0, $v0 # Memindahkan nilai dari $v0 ke register $t0 untuk menyimpan nilai panjang.
  
    # If input == exit code then go to exit label
    beq $t0, $t4, exit 
    # If t0 <= 0 then go to HARUS_POSITIF label
    blez $t0, HARUS_POSITIF_PANJANG

    j INPUT_LEBAR # Setelah panjang valid, lompat ke bagian berikutnya untuk meminta input lebar.

INPUT_LEBAR:
    # Print prompt lebar
    li $v0, 4 # Memilih syscall 4 untuk mencetak string.
    la $a0, prompt_lebar # Memuat alamat string "Masukkan lebar: " ke register $a0.
    syscall  # Mencetak string di layar.

    li $v0, 5 # Memilih syscall 5 untuk membaca integer dari pengguna.
    syscall # Mengambil input dan menyimpannya di $v0.
    move $t1, $v0  # Memindahkan nilai dari $v0 ke register $t1 untuk menyimpan nilai panjang.

    # If t1 <= 0 then go to HARUS_POSITIF label
    blez $t1, HARUS_POSITIF_LEBAR 

    # If panjang == lebar then go to HARUS_BEDA label
    beq $t0, $t1, HARUS_BEDA 
    
    jr $ra # Setelah panjang dan lebar valid, subrutin selesai dan kembali ke pemanggil dengan menggunakan jr $ra.

HARUS_POSITIF_PANJANG:
    # Jika panjang tidak valid (<= 0), beri peringatan dan minta input lagi
    li $v0, 4 # Memilih syscall untuk mencetak string.
    la $a0, HARUS_POSITIF_msg # Memuat alamat string "Input ukuran harus lebih dari 0\n" ke $a0.
    syscall # Mencetak pesan kesalahan ke layar.

    j INPUT_PANJANG   # Kembali ke MASUKAN untuk pengecekan lagi

HARUS_POSITIF_LEBAR:
    # Jika lebar tidak valid (<= 0), beri peringatan dan minta input lagi
    li $v0, 4 # Memilih syscall untuk mencetak string.
    la $a0, HARUS_POSITIF_msg # Memuat alamat string "Input ukuran harus lebih dari 0\n" ke $a0.
    syscall # Mencetak pesan kesalahan ke layar.

    j INPUT_LEBAR   # Kembali ke INPUT_LEBAR untuk pengecekan lagi

HARUS_BEDA:
    # Jika lebar == panjang, beri peringatan dan minta input lebar yang berbeda
    li $v0, 4 # Memilih syscall untuk mencetak string.
    la $a0, HARUS_BEDA_msg # Memuat alamat string "Panjang dan lebar tidak boleh sama\n" ke $a0.
    syscall # Mencetak pesan kesalahan ke layar.
    
    j INPUT_LEBAR   # Kembali ke INPUT_LEBAR untuk pengecekan lagi

HITUNG:
    # Calculate luas persegi panjang, t0 (luas) = t0 (panjang) * t1 (lebar)
    li $t7, 0  # Inisialisasi register $t7 sebagai akumulator dengan nilai 0.

LOOP_HITUNG:
    beqz $t1, END_HITUNG # Jika $t1 (lebar) = 0, lompat ke END_HITUNG.
    add $t7, $t7, $t0 # Tambahkan $t0 (panjang) ke $t7.
    sub $t1, $t1, 1 # Kurangi $t1 (lebar) sebanyak 1.
    j LOOP_HITUNG # Lompat kembali untuk iterasi berikutnya.

END_HITUNG:
    move $t0, $t7 # Pindahkan hasil akhir dari $t7 ke $t0.
    jr $ra # Kembali ke pemanggil.

KELUARAN:
    # Print luas persegi panjang
    li $v0, 1
    move $a0, $t0
    syscall

    # endl
    jal endl

    # Load 100 ke t6 dan check if luas< 100, if true then go to SMALL
    li $t6, 100
    blt $t0, $t6, SMALL

    # Load 500 ke t6 dan check if luas < 500, if true then go to MEDIUM else go to LARGE
    li $t6, 500
    blt $t0, $t6, MEDIUM
    bge $t0, $t6, LARGE

    jr $ra

SMALL:
    li $v0, 4
    la $a0, SMALL_msg # "PERSEGI PANJANG KECIL".
    syscall

    jal endl

    j exit

MEDIUM:
    li $v0, 4
    la $a0, MEDIUM_msg # "PERSEGI PANJANG SEDANG".
    syscall

    jal endl

    j exit

LARGE:
    li $v0, 4
    la $a0, LARGE_msg # "PERSEGI PANJANG BESAR".
    syscall

    jal endl

    j exit

endl:
    li $v0, 4
    la $a0, newline # Memuat alamat string \n ke $a0.
    syscall # Menampilkan baris baru.
    jr $ra # Kembali ke pemanggil.

exit:
    li $v0, 4
    la $a0,  exiting_program_msg  # Memuat alamat string "Exiting program...".
    syscall # Mencetak pesan.

    jal endl # Memanggil subrutin endl untuk baris baru.

    li $v0, 10 # Syscall untuk keluar dari program.
    syscall # Menghentikan eksekusi program.