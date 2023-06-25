.data
	# Mensajes para el menu para pedirle al usuario que ingrese la debida operacion
	titulo: .asciiz "Hola, bienvenide a la calculadora arcaica\n"
	operacion1: .asciiz "Escriba 1 para sumar\n"
	operacion2: .asciiz "Escriba 2 para restar\n"
	operacion3: .asciiz "Escriba 3 para multiplicar\n"
	operacion4: .asciiz "Escriba 4 para dividir\n"
	mensaje1: .asciiz "Ingrese la operacion que desea realizar: "
	
.text
	main:
		#jal entrada
		#jal cargarEnMemoriaOperandoUno
		#jal limpiarRegistrosTemporales
		#jal cargarEnMemoriaOperandoDos
		#jal limpiarRegistrosTemporales
		li $s4, 1
		li $s5, 4
		li $s7, 4
		
		# Se mueve registros $s4 y $s5 a $t1 y $t2
		move $t1, $s4
		move $t2, $s5
		li $t9, 0 # Para la división
		
		# Se realiza alguna de las operaciones
		jal sumaOperacion
		jal restaOperacion
		jal multiplicacionOperacion
		jal divisionOperacion
		
		jal exit
				
   	entrada:
		# Guarda en memoria la dirección para volver a la función de donde se invocó esta subrutina
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		# Muestra el menú, primero muestra el título
		li $v0, 4
		la $a0, titulo
		syscall
		# Muestra las operaciones
		li $v0, 4
		la $a0, operacion1
		syscall
		li $v0, 4
		la $a0, operacion2
		syscall
		li $v0, 4
		la $a0, operacion3
		syscall
		li $v0, 4
		la $a0, operacion4
		syscall
		# Muestra el mensaje
		li $v0, 4
		la $a0, mensaje1
		syscall
		# Captura la operacion ingresada por el usuario
		li $v0, 5
		syscall
		
		move $s7, $v0
		
		# Vuelve a la función de donde se invocó esta función
		lw $ra, 0($sp)
		addi $sp, $sp, 4
   		jr $ra
			
	limpiarRegistrosTemporales:
		# Guarda en memoria la dirección para volver a la función de donde se invocó esta subrutina
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		# Limpiar registros
    		add $t0, $zero, $zero   # Limpiar registro $t0
    		add $t1, $zero, $zero   # Limpiar registro $t1
    		add $t2, $zero, $zero   # Limpiar registro $t2
    		add $t3, $zero, $zero   # Limpiar registro $t3
    		add $t4, $zero, $zero   # Limpiar registro $t4
    		add $t5, $zero, $zero   # Limpiar registro $t5
    		add $t6, $zero, $zero   # Limpiar registro $t6
    		add $t7, $zero, $zero   # Limpiar registro $t7
    		add $t8, $zero, $zero   # Limpiar registro $t8
    		add $t9, $zero, $zero   # Limpiar registro $t9
    		# Vuelve a la función de donde se invocó esta función
		lw $ra, 0($sp)
		addi $sp, $sp, 4
   		jr $ra
	
	restaOperacion:
    		beq $s7, 2, restar
    		jr $ra
    		restar:
   			sub $t5, $t1, $t2    # Add the contents of $t1 and $t2 and store the result in $t5
   			jr $ra
   		
   	sumaOperacion:
   		beq $s7, 1, sumar
   		jr $ra
   		sumar:
   			add $t5, $t1, $t2    # Add the contents of $t1 and $t2 and store the result in $t5
   			jr $ra
   		
   	multiplicacionOperacion:
		beq $s7, 3, multiplicacion
		jr $ra

	divisionOperacion:
		beq $s7, 4, division
		beqz $t7, finDivisorOperacion
		# Se rescata el divisor original y lo guarda en $t8
		move $t8, $t2
		# Rescata el resultado original en $t5 y lo guarda en $t6
		move $t6, $t5
		# Se pasa el resto $t7 a $t1 multiplicado por 10
		move $t1, $t7
		li $t2, 10
		jal multiplicacion
		
		# Reemplaza el dividendo por $t5 el resultado de la multiplicacion
		move $t1, $t5
		
		
		# Si el resultado supera los 4 decimales
		add $t9, $t9, 1
		bne $t9, 4, finDivisonOperacion
		
		finDivisionOperacion:
			jr $ra
		# Si $t1 > $t2, ingresa a la subrutina divisionUno
		division:
			bgt $t1, $t2, divisionUno
			# Si $t1 < $t2, ingresa a la subrutina divisionDos
			blt $t1, $t2, divisionDos
			beq $t1, $t2, divisionTres
			jr $ra
   		
	multiplicacion:
		# Guarda en memoria la dirección para volver a la función de donde se invocó esta subrutina
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		add $t5, $zero, $zero        # Initialize the result to 0
  		add $t3, $zero, $t2          # Store the multiplier in $t3
  		add $t4, $zero, $t1          # Store the multiplicand in $t4

  		Loop:
    			beqz $t3, EndLoop          # If the multiplier is 0, exit the loop

    			add $t5, $t5, $t4          # Add the multiplicand to the result

    			addi $t3, $t3, -1          # Decrement the multiplier by 1

    			j Loop                     # Jump back to the beginning of the loop

  		EndLoop:
  			# The final result is stored in $t5
  			lw $ra, 0($sp)
			addi $sp, $sp, 4
   			jr $ra

	divisionUno:
		add $t5, $zero, $zero   # Inicializa el cociente en $t5 a 0
		add $t7, $zero, $zero   # Inicializa el resto en $t7 a 0

		beq $t2, $zero, EndDiv   # Si el divisor es 0, salta al final de la división

		bgez $t1, CheckPositive # Comprueba si el dividendo es positivo

		sub $t1, $zero, $t1     # Si el dividendo es negativo, cambia su signo

		CheckPositive:
			bgez $t2, BeginDiv      # Comprueba si el divisor es positivo

			sub $t2, $zero, $t2     # Si el divisor es negativo, cambia su signo
			sub $t5, $t5, 1         # Resta 1 al cociente (ajuste para redondear hacia cero)

		BeginDiv:
			ble $t1, $t2, EndDiv    # Si el dividendo es menor o igual al divisor, salta al final de la división

			LoopDiv:
				sub $t1, $t1, $t2   # Resta el divisor del dividendo
				addi $t5, $t5, 1    # Incrementa el cociente en 1

				slt $t8, $t1, $t2   # Compara el dividendo con el divisor
				beq $t8, $zero, LoopDiv   # Si el dividendo es mayor o igual que el divisor, salta al principio del bucle

			EndLoopDiv:
				move $t7, $t1        # El valor actual de $t1 es el resto

		EndDiv:
				jr $ra              # Retorna desde la subrutina
				
	divisionDos:
		add $t7, $zero, $t1  # Guardar el dividendo en $t7
    
    		loopdiv2:
        		sub $t7, $t7, $t2  # Restar el divisor de $t7
        
        		bgez $t7, loopdiv2     # Saltar a "loopdiv2" si $t7 >= 0
        
        		add $t7, $t7, $t2  # Sumar el divisor a $t7 para restaurar el valor 
		li $t5, 0
		jr $ra

	divisionTres:
		# Si son iguales se carga en $t5 1 y en el el resto $t7 0
		li $t5, 1
		li $t7, 0
		jr $ra
   		
	cargarEnMemoriaOperandoUno:
		# Guarda en memoria la dirección para volver a la función principal
		addi $sp, $sp, -4
		sw $ra, 0($sp)
	
		# Comienza a obtener los números en memoria
		# -------------- Posicion 0 -------------
		# Se carga en memoria un cero para comenzar a recorrer la memoria 
		la $t0, 0x100100a0
		
		# Luego va a buscar en la posición cero de la dirección de memoria 0x100100a0
		lw $t1, 0($t0)
		li $t2, 1
		jal multiplicacion
		
		# Luego de esto se suma el resultado de la multiplicación siendo $t5 lo suma a $t6
		add $t6, $t6, $t5
		
		# Avanza en la posición de memoria
		addi $t0, $t0, 4
		
		# -------------- Posicion 1 -------------
		# Luego va a buscar en la posición uno de la dirección de memoria 0x100100a0
		lw $t1, 0($t0)
		li $t2, 10
		jal multiplicacion
		
		# Luego de esto se suma el resultado de la multiplicación siendo $t5 lo suma a $t6
		add $t6, $t5, $t6
		
		# Avanza en la posición de memoria
		addi $t0, $t0, 4
		# -------------- Posicion 2 -------------
		# Luego va a buscar en la posición dos de la dirección de memoria 0x100100a0
		lw $t1, 0($t0)
		li $t2, 100
		jal multiplicacion
		
		# Luego de esto se suma el resultado de la multiplicación siendo $t5 lo suma a $t6
		add $t6, $t5, $t6
		
		# Avanza en la posición de memoria
		addi $t0, $t0, 4
		
		# -------------- Posicion 3 -------------
		# Luego va a buscar en la posición dos de la dirección de memoria 0x100100a0
		lw $t1, 0($t0)
		li $t2, 1000
		jal multiplicacion
		
		# Luego de esto se suma el resultado de la multiplicación siendo $t5 lo suma a $t6
		add $t6, $t5, $t6
		
		# Avanza en la posición de memoria
		addi $t0, $t0, 4
		
		# -------------- Posicion 4 -------------
		# Luego va a buscar en la posición dos de la dirección de memoria 0x100100a0
		lw $t1, 0($t0)
		li $t2, 10000
		jal multiplicacion
		
		# Luego de esto se suma el resultado de la multiplicación siendo $t5 lo suma a $t6
		add $t6, $t5, $t6
		
		# Avanza en la posición de memoria
		addi $t0, $t0, 4
		
		# -------------- Posicion 5 -------------
		# Luego va a buscar en la posición dos de la dirección de memoria 0x100100a0
		lw $t1, 0($t0)
		li $t2, 100000
		jal multiplicacion
		
		# Luego de esto se suma el resultado de la multiplicación siendo $t5 lo suma a $t6
		add $t6, $t5, $t6
		
		# Avanza en la posición de memoria
		addi $t0, $t0, 4
		
		# -------------- Posicion 6 -------------
		# Luego va a buscar en la posición dos de la dirección de memoria 0x100100a0
		lw $t1, 0($t0)
                li $t2, 1000000
		jal multiplicacion
		
		# Luego de esto se suma el resultado de la multiplicación siendo $t5 lo suma a $t6
		add $t6, $t5, $t6
		
		# Avanza en la posición de memoria
		addi $t0, $t0, 4
		
		# ------------ Fin posiciones --------
		# Se obtiene finalmente el número sin el signo
		move $s4, $t6
		
		# Se cambia el signo en caso de ser necesario
		beqz $s1, finCargarEnMemoriaUno
		sub $s4, $zero, $s4
		
		# Se retorna a la función main
		finCargarEnMemoriaUno:
   			lw $ra, 0($sp)
			addi $sp, $sp, 4
   			jr $ra
   		
   	cargarEnMemoriaOperandoDos:
		# Guarda en memoria la dirección para volver a la función principal
		addi $sp, $sp, -4
		sw $ra, 0($sp)
	
		# Comienza a obtener los números en memoria
		# -------------- Posicion 0 -------------
		# Se carga en memoria un cero para comenzar a recorrer la memoria 
		la $t0, 0x100100c0
		
		# Luego va a buscar en la posición cero de la dirección de memoria 0x100100a0
		lw $t1, 0($t0)
		li $t2, 1
		jal multiplicacion
		
		# Luego de esto se suma el resultado de la multiplicación siendo $t5 lo suma a $t6
		add $t6, $t6, $t5
		
		# Avanza en la posición de memoria
		addi $t0, $t0, 4
		
		# -------------- Posicion 1 -------------
		# Luego va a buscar en la posición uno de la dirección de memoria 0x100100a0
		lw $t1, 0($t0)
		li $t2, 10
		jal multiplicacion
		
		# Luego de esto se suma el resultado de la multiplicación siendo $t5 lo suma a $t6
		add $t6, $t5, $t6
		
		# Avanza en la posición de memoria
		addi $t0, $t0, 4
		# -------------- Posicion 2 -------------
		# Luego va a buscar en la posición dos de la dirección de memoria 0x100100a0
		lw $t1, 0($t0)
		li $t2, 100
		jal multiplicacion
		
		# Luego de esto se suma el resultado de la multiplicación siendo $t5 lo suma a $t6
		add $t6, $t5, $t6
		
		# Avanza en la posición de memoria
		addi $t0, $t0, 4
		
		# -------------- Posicion 3 -------------
		# Luego va a buscar en la posición dos de la dirección de memoria 0x100100a0
		lw $t1, 0($t0)
		li $t2, 1000
		jal multiplicacion
		
		# Luego de esto se suma el resultado de la multiplicación siendo $t5 lo suma a $t6
		add $t6, $t5, $t6
		
		# Avanza en la posición de memoria
		addi $t0, $t0, 4
		
		# -------------- Posicion 4 -------------
		# Luego va a buscar en la posición dos de la dirección de memoria 0x100100a0
		lw $t1, 0($t0)
		li $t2, 10000
		jal multiplicacion
		
		# Luego de esto se suma el resultado de la multiplicación siendo $t5 lo suma a $t6
		add $t6, $t5, $t6
		
		# Avanza en la posición de memoria
		addi $t0, $t0, 4
		
		# -------------- Posicion 5 -------------
		# Luego va a buscar en la posición dos de la dirección de memoria 0x100100a0
		lw $t1, 0($t0)
		li $t2, 100000
		jal multiplicacion
		
		# Luego de esto se suma el resultado de la multiplicación siendo $t5 lo suma a $t6
		add $t6, $t5, $t6
		
		# Avanza en la posición de memoria
		addi $t0, $t0, 4
		
		# -------------- Posicion 6 -------------
		# Luego va a buscar en la posición dos de la dirección de memoria 0x100100a0
		lw $t1, 0($t0)
		li $t2, 1000000
		jal multiplicacion
		
		# Luego de esto se suma el resultado de la multiplicación siendo $t5 lo suma a $t6
		add $t6, $t5, $t6
		
		# Avanza en la posición de memoria
		addi $t0, $t0, 4
			
		# ------------ Fin posiciones --------
		# Se obtiene finalmente el número sin el signo
		move $s5, $t6
		
		# Se cambia el signo en caso de ser necesario
		beqz $s2, finCargarEnMemoriaDos
		sub $s5, $zero, $s5
		
		# Se retorna a la función main
		finCargarEnMemoriaDos:
   			lw $ra, 0($sp)
			addi $sp, $sp, 4
   			jr $ra
    		
    	
   			
	exit:
		# Carga en V0 la operación de terminar el programa
		li $v0, 10
		syscall # Ejecuta la función cargada en v0
