.data
	# Mensajes para el menu para pedirle al usuario que ingrese la debida operacion
	titulo: .asciiz "1.- Para sumar \n2.- Para Restar \n3.- Para multiplicar \n4.- Para dividir \nEliga: "
	punto: .asciiz "."
	
.text
	main:
		jal entrada
		jal cargarEnMemoriaOperandoUno
		jal limpiarRegistrosTemporales
		jal cargarEnMemoriaOperandoDos
		jal limpiarRegistrosTemporales
		
		# Se mueve registros $s4 y $s5 a $t1 y $t2
		move $t1, $s4
		move $t2, $s5
		
		# Se realiza alguna de las operaciones
		jal sumaOperacion
		jal restaOperacion
		jal multiplicacionOperacion
		jal divisionOperacion
		
		# Cambia el signo en la multiplicacion
		jal cambiarSignoMultiplicacion
		
		# Ahora se imprime el resultado si no es division
		jal imprimirResultado
		
		# Guarda el resultado entero en memoria
		jal guardarResultadoEnMemoria
		
		# Guarda los decimales en memoria
		jal guardarDecimalesEnMemoria
		
		jal exit
			
			
	guardarResultadoEnMemoria:
		# Luego, se comienza a guardar en memoria el número
		# Guarda en memoria la dirección para volver a la función principal
		addi $sp, $sp, -4
		sw $ra, 0($sp)
	
		# Se obtiene el resultado en valor absoluto
		move $t1, $t5
		jal absoluto
		move $t5, $t1
		
		# Comienza a obtener los números en memoria
		# -------------- Posicion 0 -------------
		# Se carga en memoria un cero para comenzar a recorrer la memoria 
		la $t0, 0x100100e0
		addi $t0, $t0, 24
		
		# Luego va a buscar en la posición cero de la dirección de memoria 0x100100a0
		li $t2, 1000000
		jal division
		
		# Luego de esto de guarda el resultado en la dirección de memoria
		sw $t5, 0($t0)
		
		# Avanza en la posición de memoria
		subi $t0, $t0, 4
		
		# -------------- Posicion 1 -------------
		# Luego va a buscar en la posición cero de la dirección de memoria 0x100100a0
		li $t2, 100000
		jal division
		
		# Luego de esto de guarda el resultado en la dirección de memoria
		sw $t5, 0($t0)
		
		# Avanza en la posición de memoria
		subi $t0, $t0, 4
		
		# -------------- Posicion 2 -------------
		# Luego va a buscar en la posición cero de la dirección de memoria 0x100100a0
		li $t2, 10000
		jal division
		
		# Luego de esto de guarda el resultado en la dirección de memoria
		sw $t5, 0($t0)
		
		# Avanza en la posición de memoria
		subi $t0, $t0, 4
		
		# -------------- Posicion 3 -------------
		# Luego va a buscar en la posición cero de la dirección de memoria 0x100100a0
		li $t2, 1000
		jal division
		
		# Luego de esto de guarda el resultado en la dirección de memoria
		sw $t5, 0($t0)
		
		# Avanza en la posición de memoria
		subi $t0, $t0, 4
		
		# -------------- Posicion 4 -------------
		# Luego va a buscar en la posición cero de la dirección de memoria 0x100100a0
		li $t2, 100
		jal division
		
		# Luego de esto de guarda el resultado en la dirección de memoria
		sw $t5, 0($t0)
		
		# Avanza en la posición de memoria
		subi $t0, $t0, 4
		
		# -------------- Posicion 5 -------------
		# Luego va a buscar en la posición cero de la dirección de memoria 0x100100a0
		li $t2, 10
		jal division
		
		# Luego de esto de guarda el resultado en la dirección de memoria
		sw $t5, 0($t0)
		
		# Avanza en la posición de memoria
		subi $t0, $t0, 4
		
		# -------------- Posicion 6 -------------
		# Luego va a buscar en la posición cero de la dirección de memoria 0x100100a0
		li $t2, 1
		jal division
		
		# Luego de esto de guarda el resultado en la dirección de memoria
		sw $t5, 0($t0)
		
		# Avanza en la posición de memoria
		subi $t0, $t0, 4
		
		# Luego de esto se retorna a la función principal
		lw $ra, 0($sp)
		addi $sp, $sp, 4
   		jr $ra
				
	guardarDecimalesEnMemoria:
		beq $s7, 4, guardarDecimales
		jr $ra
	
		guardarDecimales:
		# Luego, se comienza a guardar en memoria el número
		# Guarda en memoria la dirección para volver a la función principal
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		# Comienza a obtener los números en memoria
		# -------------- Posicion 0 -------------
		# Se carga en memoria un cero para comenzar a recorrer la memoria 
		la $t0, 0x10010100
		addi $t0, $t0, 16
		
		# Luego va a buscar en la posición cero de la dirección de memoria 0x100100a0
		move $t1, $t9
		li $t2, 1000
		jal division
		
		# Luego de esto de guarda el resultado en la dirección de memoria
		sw $t5, 0($t0)
		
		# Avanza en la posición de memoria
		subi $t0, $t0, 4
		
		# -------------- Posicion 1 -------------
		# Luego va a buscar en la posición cero de la dirección de memoria 0x100100a0
		li $t2, 100
		jal division
		
		# Luego de esto de guarda el resultado en la dirección de memoria
		sw $t5, 0($t0)
		
		# Avanza en la posición de memoria
		subi $t0, $t0, 4
		
		# -------------- Posicion 2 -------------
		# Luego va a buscar en la posición cero de la dirección de memoria 0x100100a0
		li $t2, 10
		jal division
		
		# Luego de esto de guarda el resultado en la dirección de memoria
		sw $t5, 0($t0)
		
		# Avanza en la posición de memoria
		subi $t0, $t0, 4
		
		# -------------- Posicion 3 -------------
		# Luego va a buscar en la posición cero de la dirección de memoria 0x100100a0
		li $t2, 1
		jal division
		
		# Luego de esto de guarda el resultado en la dirección de memoria
		sw $t5, 0($t0)
		
		# Avanza en la posición de memoria
		subi $t0, $t0, 4
		
		# Luego de esto se retorna a la función principal
		lw $ra, 0($sp)
		addi $sp, $sp, 4
   		jr $ra
   			
					
	imprimirResultado:
		bne $s7, 4, imprimirResultadoFinal
		jr $ra
		imprimirResultadoFinal:
			# Guarda en memoria la dirección para volver a la función de donde se invocó esta subrutina
			addi $sp, $sp, -4
			sw $ra, 0($sp)
				
			li $v0, 1
			move $a0, $t5
			syscall
			# Vuelve a la función de donde se invocó esta función
			lw $ra, 0($sp)
			addi $sp, $sp, 4
			jr $ra
			
   	entrada:
		# Guarda en memoria la dirección para volver a la función de donde se invocó esta subrutina
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		# Muestra el menú, primero muestra el título
		li $v0, 4
		la $a0, titulo
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
		
	cambiarSignoMultiplicacion:
		beq $s7, 3, cambiarSigno
		jr $ra
		
		cambiarSigno:
			# Guarda en memoria la dirección para volver a la función de donde se invocó esta subrutina
			addi $sp, $sp, -4
			sw $ra, 0($sp)
			# Se inserta el signo del resultado
			xor $s3, $s1, $s2
			# Se cambia el signo en caso de ser necesario
			beqz $s3, finMultiplicacionEntera
			sub $t5, $zero, $t5
			finMultiplicacionEntera:
				# Se retorna a la subrutina principal
				lw $ra, 0($sp)
				addi $sp, $sp, 4
   				jr $ra
			
			
		
	absoluto:
  	 	# Compara el número con cero
    		bgez $t1, absoluto_fin   # Si es mayor o igual a cero, termina y devuelve el número sin cambios

    		# Si el número es negativo, realiza la operación de negación
    		subu $t1, $zero, $t1

	absoluto_fin:
    		jr $ra   # Retorna al llamador


	divisionOperacion:
		# Verifica si es una division
		beq $s7, 4, divisionOp
		jr $ra
		
		divisionOp:
			addi $sp, $sp, -4
			sw $ra, 0($sp)
			# Se utiliza valor absoluto
			jal absoluto
			move $a0, $t1
			move $t1, $t2
			jal absoluto
			move $t2, $t1
			move $t1, $a0
			li $a0, 0
			
			# Se comienza la division
			jal division
			beqz $t7, finDecimalesDivision
			# Se quiere obtener la parte decimal. Se tiene que
			# $t7 = resto, $t5 = cociente, $t2 = divisor, $t1 = dividendo
			# Todos estso registros se obtuvieron de jal division
			# Se quiere un maximo de 4 decimales
			# Se multiplica el resto por 10
			# Ahora se le pasa el resto y se multiplica por 10, en jal multiplicacion
			# se usa $t1 y $t2, no se debe perder el divisor
			# Se guarda el resultado en $t9
			# Se rescata el valor de $t2, y $t5
			move $t6, $t2 # Se guarda el divisor
			move $s6, $t5 # El resultado original

			# Luego se multiplica el resto por 10 el resto
			move $t1, $t7
			li $t2, 10
			jal multiplicacion

			# Luego se reemplaza el valor de $t5 siendo ahora el resultado de la multiplicacion
			# en $t1.
			move $t1, $t5
			move $t2, $t6 # Se reemplaza $t2 de la multiplicación por el divisor
			jal division

			# Se guarda el resultado de la división en $t9 multiplicado por 1000
			move $t1, $t5
			li $t2, 1000
			jal multiplicacion
			move $t9, $t5

			# Se multiplica el resto por 10
			move $t1, $t7
			li $t2, 10
			jal multiplicacion

			# Se reemplaza el valor de $t5 siendo ahora el resultado de la multiplicacion
			# en $t1.
			move $t1, $t5
			move $t2, $t6 # Se reemplaza $t2 de la multiplicación por el divisor
			jal division

			# Se guarda el resultado de la división en $t9 multiplicado por 100
			move $t1, $t5
			li $t2, 100
			jal multiplicacion
			add $t9, $t9, $t5

			# Se multiplica el resto por 10
			move $t1, $t7
			li $t2, 10
			jal multiplicacion

			# Se reemplaza el valor de $t5 siendo ahora el resultado de la multiplicacion
			# en $t1.
			move $t1, $t5
			move $t2, $t6 # Se reemplaza $t2 de la multiplicación por el divisor
			jal division

			# Se guarda el resultado de la división en $t9 multiplicado por 10
			move $t1, $t5
			li $t2, 10
			jal multiplicacion
			add $t9, $t9, $t5

			# Se multiplica el resto por 10
			move $t1, $t7
			li $t2, 10
			jal multiplicacion

			# Se reemplaza el valor de $t5 siendo ahora el resultado de la multiplicacion
			# en $t1.
			move $t1, $t5
			move $t2, $t6 # Se reemplaza $t2 de la multiplicación por el divisor
			jal division

			# Se guarda el resultado de la division en $t9 multiplicado por 1
			add $t9, $t9, $t5

			finDecimalesDivision:

			# Finalmente se obtiene el resultado de la division original
			move $t5, $s6
			move $t7, $t9 # El número con la parte decimal
			
			# Se inserta el signo del resultado
			xor $s3, $s1, $s2
			# Se cambia el signo en caso de ser necesario
			beqz $s3, finDivisionEntera
			sub $t5, $zero, $t5
			
			finDivisionEntera:
				# Imprime resultado
			
				li $v0, 1
				move $a0, $t5
				syscall
			
				li $v0, 4
				la $a0, punto
				syscall
			
				li $v0, 1
				move $a0, $t7
				syscall
				# Se retorna a la subrutina principal
				lw $ra, 0($sp)
				addi $sp, $sp, 4
   				jr $ra
			
		finDivisorOperacion:
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
		# Se utiliza valor absoluto
		jal absoluto
		move $a0, $t1
		move $t1, $t2
		jal absoluto
		move $t2, $t1
		move $t1, $a0
		li $a0, 0
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
