# OAC17II_PersistenciaAditiva.s
#
#Afiliación:
#	FIEC, ESPOL
#
#Integrantes:
#	Luis Lama
#	Mauricio Leiton
#	Roberto Mena
#
#Qué hace este programa:
#Calcula la persistencia aditiva 
#de un número ingresado por teclado.
#

.data

	#Variables que se usaran en el programa
	diez: .word 10	#Para comparar y saber si ya llegamos a un número de un sólo dígito
	#residuo: .word 0	#Para aumentar el contador para la persistencia aditiva
	persistenciaAditiva: .word 0 #La persistencia aditiva se inicia en 0
	
	#Mensajes para el usuario en etiquetas	
	saludo: .asciiz "\nBienvenido!!\nEn este programa podrás calcular la Persistencia Aditiva del número que ingreses\n"
	pedirNumero: .asciiz "Ingresa el número:\n"
	resultado: .asciiz "La persistencia aditiva es "
	despedida: .asciiz "\nPrograma terminado\n"

.text
.globl main

#Comienza el programa
		#imprime la bienvenida
main:	li $v0, 4
		la $a0, saludo
		syscall

		#imprime en pantalla el mensaje que solicita al usuario el número
		li $v0, 4
		la $a0, pedirNumero
		syscall

		#Se obtiene el número
		li $v0, 5
		syscall

		#Para poder seguir utilizando el registro $v0, guardamos al registro $t0 el número ingresado
		move $s0, $v0

		#Carga en el registro $s1 el valor de la variable "diez"
		lw $s1, diez
		#Carga en el registro $s2 el contador, inicializado en cero
		li $s2, 0
		#Carga en el registro $s3 la sumatoria, inicializada en cero
		li $s3, 0

	#Comienza el lazo que realizaría el conteo
	loop1: 
	    blt $s0, $s1, end		#si es menor que 10, sale del loop
	    addi $s2, $s2, 1		#aumenta el contador de la persistencia aditiva
	    li $s3, 0				#resetea la sumatoria
	    li $s4, 1				#resetea el auxiliar
	    b loop2					#Entra al lazo anidado

	#lazo que realiza la sumatoria
	loop2:
		beq $s0, 0, intermidiate		#si es igual a 0, sale del loop2 y regresa va a intermidiate
		div $s0, $s1					#divide para 10
		mfhi $t0						#obtiene el residuo y lo guarda en $t0
		add $s3, $s3, $t0				#actualiza la sumatoria añadiendole el residuo	
	    mflo $s0						#Actualiza el número, con el cociente de la division para 10
		b loop2							#sigue en el lazo, nueva iteración

	#actualiza el número después de cada iteración del loop1
	intermidiate:
		move $s0, $s3
		j loop1

	end: 
		#Se muestra el mensaje de resultado
		li $v0, 4
		la $a0, resultado
		syscall

		#Se imprime la persistencia aditiva
		li $v0, 1
		sw $s2, persistenciaAditiva
		lw $a0, persistenciaAditiva
		syscall

		#Se muestra el mensaje de despedida
		li $v0, 4
		la $a0, despedida
		syscall

		#Se termina el programa
		li $v0, 10
		syscall