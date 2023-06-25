# Haceme una multiplicación de dos números enteros positivos o negativos, pero sin usar el
# operador de multiplicación.
# Ejemplo: 4 * 5 = 20
# Ejemplo: -4 * 5 = -20
# Ejemplo: -4 * -5 = 20
# Ejemplo: 4 * -5 = -20
def multiplicacion(a, b):
    resultado = 0
    for i in range(abs(b)):
        resultado += abs(a)
    if (a < 0 and b > 0) or (a > 0 and b < 0):
        return -resultado
    return resultado


print(multiplicacion(4, -5))
