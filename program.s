.data
    header: .asciiz "\nIF-47-03 Kelompok 6\nSanubari Nuraulia Legawa\t103012300347\nMuhammad Daffa Fariza\t\t103012300004\nMuhammad Rifaldi Usman\t\t103012300017\nFairuztsani Kemal Setiawan\t103012300048\n\nUntuk keluar dari program, masukkan angka 1502 pada saat input panjang persegi panjang\n\n"
    newline: .asciiz "\n"
    
    exit_code: .word 1502
    exiting_program_msg: .asciiz "Exiting program..."

    HARUS_POSITIF_msg: .asciiz "Input ukuran harus lebih dari 0\n"
    HARUS_BEDA_msg: .asciiz "Panjang dan lebar tidak boleh sama\n"

    prompt_panjang: .asciiz "Masukkan panjang: "
    prompt_lebar: .asciiz "Masukkan lebar: "

    _100: .word 100
    _500: .word 500

    SMALL_msg: .asciiz "PERSEGI PANJANG KECIL"
    MEDIUM_msg: .asciiz "PERSEGI PANJANG SEDANG"
    LARGE_msg: .asciiz "PERSEGI PANJANG BESAR"
.text
.globl main
main:
    # Load exit code to $s0
    la $t3, exit_code
    lw $t4, 0($t3)

    # Print header
    li $v0, 4
    la $a0, header
    syscall


    jal MASUKAN
    jal HITUNG
    jal KELUARAN

    j exit

MASUKAN:
INPUT_PANJANG:
    # Print prompt
    li $v0, 4
    la $a0, prompt_panjang
    syscall

    # Input integer
    li $v0, 5
    syscall
    move $t0, $v0
  
    # If input == exit code then go to exit procedure(?)
    beq $t0, $t4, exit
    # If t0 <= 0 then go to HARUS_POSITIF procedure(?)
    blez $t0, HARUS_POSITIF_PANJANG

    j INPUT_LEBAR

INPUT_LEBAR:
    # Print prompt lebar
    li $v0, 4
    la $a0, prompt_lebar
    syscall    

    li $v0, 5
    syscall
    move $t1, $v0

    # If t1 <= 0 then go to HARUS_POSITIF procedure(?)
    blez $t1, HARUS_POSITIF_LEBAR

    # If panjang == lebar then go to HARUS_BEDA procedure(?)
    beq $t0, $t1, HARUS_BEDA

    jr $ra

HARUS_POSITIF_PANJANG:
    # Jika panjang tidak valid (<= 0), beri peringatan dan minta input lagi
    li $v0, 4
    la $a0, HARUS_POSITIF_msg
    syscall

    j INPUT_PANJANG   # Kembali ke MASUKAN untuk pengecekan lagi

HARUS_POSITIF_LEBAR:
    # Jika lebar tidak valid (<= 0), beri peringatan dan minta input lagi
    li $v0, 4
    la $a0, HARUS_POSITIF_msg
    syscall

    j INPUT_LEBAR   # Kembali ke INPUT_LEBAR untuk pengecekan lagi

HARUS_BEDA:
    # Jika lebar == panjang, beri peringatan dan minta input lebar yang berbeda
    li $v0, 4
    la $a0, HARUS_BEDA_msg
    syscall
    
    j INPUT_LEBAR   # Kembali ke INPUT_LEBAR untuk pengecekan lagi

HITUNG:
    # Calculate luas persegi panjang, t0 (luas) = t0 (panjang) * t1 (lebar)
    li $t7, 0

LOOP_HITUNG:
    beqz $t1, END_HITUNG
    add $t7, $t7, $t0
    sub $t1, $t1, 1
    j LOOP_HITUNG

END_HITUNG:
    move $t0, $t7
    jr $ra

KELUARAN:
    # Print luas persegi panjang
    li $v0, 1
    move $a0, $t0
    syscall

    # endl
    jal endl

    # Load 100 and check if luas< 100, if so then go to SMALL
    la $t5, _100
    lw $t6, 0($t5)
    blt $t0, $t6, SMALL

    # Load 500 and check if luas < 500, if so then go to MEDIUM else go to LARGE
    la $t5, _500
    lw $t6, 0($t5)
    blt $t0, $t6, MEDIUM
    bge $t0, $t6, LARGE

    jr $ra

SMALL:
    li $v0, 4
    la $a0, SMALL_msg
    syscall

    jal endl

    j exit

MEDIUM:
    li $v0, 4
    la $a0, MEDIUM_msg
    syscall

    jal endl

    j exit

LARGE:
    li $v0, 4
    la $a0, LARGE_msg
    syscall

    jal endl

    j exit

endl:
    li $v0, 4
    la $a0, newline
    syscall
    jr $ra

exit:
    li $v0, 4
    la $a0,  exiting_program_msg 
    syscall

    jal endl

    li $v0, 10 
    syscall