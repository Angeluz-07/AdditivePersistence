# persistenciaaditiva.s
#
# Muestra la persistencia aditiva de un numero ingresado por teclado
#
# Autores
#   Luis Lama
#   Mauricio Leiton
#   Roberto Mena
#
# Afiliacion
#   FIEC, ESPOL
#

        .data
saludo:    .asciiz "\nBienvenido!";
pedirnum:  .asciiz "\nIngrese un numero: ";
resultado: .asciiz "\nLa persistencia aditiva es: ";
despedida: .asciiz "\nPrograma terminado\n";
flecha:    .asciiz "-->"

        .text
        .globl main
main:   li $v0, 4                 # syscall 4 : print_str
        la $a0, saludo            # carga str en $a0
        syscall                   # print str en $a0
        #lw $t1, foobar
        
        #jr $ra          # retrun to caller		
		
# pide numero y se almacena en $t0		
		li $v0, 4                 # syscall 4 : print_str
		la $a0, pedirnum          # carga str en $a0
		syscall                   # print str de $a0
		
		li $v0, 5                 # syscall 5 : read_int
		syscall                   # read_int y se almacena en $v0
		
		move $t0, $v0             # $t0 = $v0 | para poder seguir utilizando $v0

# se preparan los registros para el calculo de la persistencia aditiva		
		li $t1, 10                # $t1 = 10 | para obtener los digitos y permitir la salida del loop
		li $t2, 0                 # $t2 = 0 | Se inicializa el contador para la persistencia aditiva
		
# lazo para actualizar el valor de la persistencia aditiva
    persistencia:
        li $v0, 1                 # syscall 1 : print_int
        move $a0, $t0             # carga int en $a0
        syscall                   # print int de $a0

        blt $t0, $t1, end         # si es menor a 10, el numero tiene un solo digito y sale del lazo
        
        li $v0, 4                 # syscall 4 : print_str
        la $a0, flecha            # carga str en $a0
        syscall                   # print str en $a0

		addi $t2, $t2, 1          # aumenta el valor de persistencia aditiva
        li $t3, 0                 # resetea el valor de la sumatoria
        b sumatoria               # entra al lazo de la sumatoria

# lazo que realiza la sumatoria de los digitos, obteniendo el residuo de la division para 10
    sumatoria:
        beq $t0, 0, nuevoNum      # si es cero, termino la sumatoria y sale del lazo
        div $t0, $t1              # divide para 10, LO=$t0/10 , HI=$t0%10
        mfhi $t4                  # el residuo se almacena en $t4
        add $t3, $t3, $t4         # sumatoria = sumatoria + residuo
        mflo $t0                  # el numero se reemplaza por el cociente, donde estan los digitos restantes
        b sumatoria               # sigue en el lazo de la sumatoria		

# se actualiza el numero, con la sumatoria
    nuevoNum:
        move $t0, $t3             # se actualiza el valor con la sumatoria de sus digitos, para calcular su persistencia
        j persistencia            # salta al lazo de la persistencia

    end:
# se imprime la persistencia aditiva
        li $v0, 4                 # syscall 4 : print_str
		la $a0, resultado         # carga str en $a0
		syscall                   # print str de $a0

        li $v0, 1                 # syscall 1 : print_int
        move $a0, $t2             # carga int en $a0
        syscall                   # print int de $a0

# se imprime el mensaje de despedida
		li $v0, 4                 # syscall 4 : print_str
		la $a0, despedida         # carga str en $a0
		syscall                   # print str de $a0
		
		li $v0, 10                # syscall 10 : exit
        syscall                   # exit