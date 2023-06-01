.data
	# Mensajes para el menu para pedirle al usuario que ingrese la debida operacion
	titulo: .asciiz "Hola, bienvenide a la calculadora arcaica\n"
	operacion1: .asciiz "Escriba + para sumar\n"
	operacion2: .asciiz "Escriba - para restar\n"
	operacion3: .asciiz "Escriba * para multiplicar\n"
	operacion4: .asciiz "Escriba / para dividir\n"
	mensaje1: .asciiz "Ingrese la operacion que desea realizar: "
	
	# Se utiliza para guardar el operador
	operador: .space 3
	
	# Se utiliza para los acarreos en la suma
	direccionAcarreos: .word 0x10010180
	signos: .asciiz "++"
	
	# Se guardan los signos que se ocupan los operando
	
	# Se utiliza para almacenar el numero invertido en la memoria
	direccion1: .word 0x100100a0
	operando1: .word 0x00000001, 0x00000002, 0x00000003, 0x00000000, 0x00000000, 0x00000000, 0x00000000
	direccion2: .word 0x100100c0
	operando2: .word 0x00000005, 0x00000009, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000
	direccion3: .word 0x100100e0
	
	# operaciones
	sumaOp: .asciiz "+"
	restaOp: .asciiz "-"
	multiplicacionOp: .asciiz "*"
	divisionOp: .asciiz "/"
	
.text
	main:
		jal cargarEnMemoriaOperandos
		jal entrada
		jal operar
#		jal mostrarResultado
		jal exit
		
	cargarEnMemoriaOperandos:
		# Se carga en memoria el primer número, para efectos prácticos se tienen que modificar mediante código
		# Se tomará el número 4321, aunque puede ser un número con n cantidad de cifras.
		# Cargar los operandos desde el segmento de datos
    		la $t0, operando1         # Cargar la dirección base de los operandos en $t0
    		lw $t1, 0($t0)            # Cargar el primer operando en $t1
    		lw $t2, 4($t0)            # Cargar el segundo operando en $t2
   		lw $t3, 8($t0)            # Cargar el tercer operando en $t3
   		lw $t4, 12($t0)           # Cargar el cuarto operando en $t4
   		lw $t6, 16($t0)           # Cargar el cuarto operando en $t6
   		lw $t7, 20($t0)           # Cargar el cuarto operando en $t7
   		lw $t8, 24($t0)           # Cargar el cuarto operando en $t8
   		
   		# Se obtiene la dirección de memoria
   		lw $t5, direccion1
   		# Guardar los operandos en memoria con su respectiva dirección
   		sw $t1, 0($t5)
   		sw $t2, 4($t5)
   		sw $t3, 8($t5)
   		sw $t4, 12($t5)
   		sw $t6, 16($t5)
   		sw $t7, 20($t5)
   		sw $t8, 24($t5)
   		
   		# Ahora se hace lo mismo con el segundo operando
   		# Cargar los operandos desde el segmento de datos
    		la $t0, operando2         # Cargar la dirección base de los operandos en $t0
    		lw $t1, 0($t0)            # Cargar el primer operando en $t1
    		lw $t2, 4($t0)            # Cargar el segundo operando en $t2
   		lw $t3, 8($t0)            # Cargar el tercer operando en $t3
   		lw $t4, 12($t0)           # Cargar el cuarto operando en $t4
   		lw $t6, 16($t0)           # Cargar el cuarto operando en $t6
   		lw $t7, 20($t0)           # Cargar el cuarto operando en $t7
   		lw $t8, 24($t0)           # Cargar el cuarto operando en $t8
   		
   		# Se obtiene la dirección de memoria
   		lw $t5, direccion2
   		# Guardar los operandos en memoria con su respectiva dirección
   		sw $t1, 0($t5)
   		sw $t2, 4($t5)
   		sw $t3, 8($t5)
   		sw $t4, 12($t5)
   		sw $t6, 16($t5)
   		sw $t7, 20($t5)
   		sw $t8, 24($t5)
   		  		
   		# Se guarda los signos del operando 1 y 2
   		la $t9, signos
   		lw $s1, 0($t9)
   		lw $s2, 4($t9)
   		  
   		
   		# Se retorna a la función main
   		jr $ra
   		
   		
	entrada:
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
		li $v0, 8 # Para capturar un string
		la $a0, operador
		li $a1, 3
		syscall
		
		# Retorna a la función principal
		jr $ra
		
	
	operar:
		# Limpia registros
		jal limpiarRegistros
		
		# Cargar nombres de operadores
		la $t8, sumaOp
		lb $t8, 0($t8)
		
		# Se hace la distinción de casos, para la suma, resta, multiplicación y división.
		# Se obtiene el operador
		la $t9, operador
		lb $t9, 0($t9)
    		beq $t9, $t8, suma  # Comparar con el valor ASCII '+' (43), Si el usuario seleccionó una suma, lleva al usuario a hacer la suma
    		
    		la $t8, restaOp
		lb $t8, 0($t8)
    		beq $t8, $t9, resta  # Si el usuario seleccionó una resta, lleva al usuario a hacer la resta
    		
    		li $t1, '*'   # Cargar el símbolo "*" en el registro $t1
    		#beq operador, $t1, multiplicacion  # Si el usuario seleccionó una multiplicacion, lleva al usuario a hacer la multiplicacion
    		
    		li $t1, '/'   # Cargar el símbolo "/" en el registro $t1
    		#beq operador, $t1, division  # Si el usuario seleccionó una division, lleva al usuario a hacer la division
    		
		jr $ra
		
	limpiarRegistros:
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
    		jr $ra
	
	suma:
		# Se limpian nuevamente los registros
		jal limpiarRegistros
		
		# Se obtiene la dirección de memoria
   		la $t0, 0x100100a0          # Cargar la dirección de memoria de lista1 en $t0
		la $t1, 0x100100c0         # Cargar la dirección de memoria de lista2 en $t1
		la $t2, signos          # Cargar la dirección de memoria de signos en $t2
		la $t3, 0x10010180        # Cargar la dirección de memoria de acarreos en $t3
		li $t4, 0               # Inicializar el índice del bucle en 0
		li $t5, 10              # Valor constante 10
		la $t6, 0x100100e0      # Dirección de memoria para guardar el resultado

		 # Bucle "for" para recorrer las listas
		loop:
			# Comparar el índice con la longitud de la lista1
			lw $t7, 0($t0)              # Cargar lista1[i] en $t7
			lw $t8, 0($t1)              # Cargar lista2[i] en $t8
			lb $t9, 0($t2)              # Cargar signos[0] en $t9

			beq $t4, 7, exit            # Salir del bucle si se ha alcanzado el final de las listas

			# Comprobar el valor del signo
			beq $t9, 43, add_operation  # Comparar con el valor ASCII '+' (43)
			beq $t9, 45, sub_operation  # Comparar con el valor ASCII '-' (45)

		add_operation:
			# Suma
			add $t7, $t7, $t8           # lista1[i] + lista2[i]
			lw $t9, 0($t3)              # Cargar acarreos[i] en $t9
			
			add $t7, $t7, $t9           # Sumar el acarreo al resultado

			bge $t7, $t5, carry_check   # Comprobar si la suma es mayor o igual a 10

			# Sin acarreo
			sw $t7, 0($t6)              # Guardar el resultado en la dirección de memoria $t6
			li $t9, 0                   # Establecer el acarreo en 0
			sw $t9, 0($t3)              # Guardar el acarreo en la dirección de memoria acarreos[i]
			j next_iteration            # Saltar a la siguiente iteración del bucle

		carry_check:
			sub $t7, $t7, $t5           # Restar 10 al resultado
			li $t9, 1                   # Establecer el acarreo en 1
			sw $t7, 0($t6)              # Guardar el resultado en la dirección de memoria $t6
			sw $t9, 0($t3)              # Guardar el acarreo en la dirección de memoria acarreos[i]
			j next_iteration            # Saltar a la siguiente iteración del bucle

		sub_operation:
			# Resta
			sub $t7, $t8, $t7           # lista2[i] - lista1[i]
			bltz $t7, negative_check     # Comprobar si la resta es menor que 0

			# Sin acarreo
			sw $t7, 0($t6)              # Guardar el resultado en la dirección de memoria $t6
			li $t9, 0                   # Establecer el acarreo en 0
			sw $t9, 0($t3)              # Guardar el acarreo en la dirección de memoria acarreos[i]
			j next_iteration            # Saltar a la siguiente iteración del bucle

		negative_check:
			addi $t7, $t7, 10           # Sumar 10 al resultado
			sw $t7, 0($t6)              # Guardar el resultado en la dirección de memoria $t6
			li $t9, 1                   # Establecer el acarreo en 1
			sw $t9, 0($t3)              # Guardar el acarreo en la dirección de memoria acarreos[i]

		next_iteration:
			addi $t0, $t0, 4            # Avanzar a la siguiente posición en lista1
			addi $t1, $t1, 4            # Avanzar a la siguiente posición en lista2
			addi $t2, $t2, 1            # Avanzar a la siguiente posición en signos
			addi $t3, $t3, 4            # Avanzar a la siguiente posición en acarreos
			addi $t4, $t4, 1            # Incrementar el índice del bucle en 1
			addi $t6, $t6, 4            # Avanzar a la siguiente dirección de memoria para guardar el resultado
			j loop                      # Volver al inicio del bucle


   	resta:
   		
   		
		
	
#	mostrarResultado:
	
	
	exit:
		# Carga en V0 la operación de terminar el programa
		li $v0, 10
		syscall # Ejecuta la función cargada en v0
