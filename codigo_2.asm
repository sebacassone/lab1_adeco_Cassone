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
	
	resta:
    		# Guarda en memoria la dirección para volver a la función de donde se invocó esta subrutina
		addi $sp, $sp, -4
		sw $ra, 0($sp)
   		sub $t5, $t1, $t2    # Add the contents of $t1 and $t2 and store the result in $t5
    		# Vuelve a la función de donde se invocó esta función
		lw $ra, 0($sp)
		addi $sp, $sp, 4
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