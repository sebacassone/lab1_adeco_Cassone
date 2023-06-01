def suma(lista1, lista2, signos, acarreos = [0, 0 ,0, 0]):
    resultado = []
    for i in range(len(lista1)):
        if signos[0] == "+":
            # Si da mayor a 10, restar 10 y darse ese sobrante a la siguiente, si no hay siguiente poner el numero sin restar
            if lista1[i] + lista2[i] >= 10:
                if i + 1 == len(lista1):
                    resultado.append(lista1[i] + lista2[i])
                else:
                    resultado.append(lista1[i] + lista2[i] - 10)
                    acarreos[i + 1] += 1
            else:
                resultado.append(lista1[i] + lista2[i] + acarreos[i])
        elif signos[0] == "-" and signos[1] == "+":
            if lista2[i] - lista1[i] >= 10:
                if i + 1 == len(lista1):
                    resultado.append(lista2[i] - lista1[i])
                else:
                    resultado.append(lista2[i] - lista1[i] - 10)
                    acarreos[i + 1] += 1
            elif lista2[i] - lista1[i] < 0:
                resultado.append(lista2[i] - lista1[i] + 10)
            else:
                resultado.append(lista2[i] - lista1[i] + acarreos[i])
        elif signos[1] == "-" and signos[0] == "+":
           # Si da mayor a 10, restar 10 y darse ese sobrante a la siguiente, si no hay siguiente poner el numero sin restar
            if lista1[i] - lista2[i] >= 10:
                if i + 1 == len(lista1):
                    resultado.append(lista1[i] - lista2[i])
                else:
                    resultado.append(lista1[i] - lista2[i] - 10)
                    acarreos[i + 1] += 1
            elif lista1[i] - lista2[i] < 0:
                resultado.append(lista1[i] - lista2[i] + 10)
            else:
                resultado.append(lista1[i] - lista2[i] + acarreos[i])
    return resultado

print(suma([9, 2, 3], [4, 5, 9], ["+", "+"]))
