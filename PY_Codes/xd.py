def eliminarespacio(texto):
    text_seguido = ""
    for a in texto: 
        if a != ' ':
            text_seguido += a
    return text_seguido

def darvuelta(texto):
    texto_vuelta = ""
    x = len(texto)
    for i in range(x):
        texto_vuelta += texto[x-i-1]
    return texto_vuelta

sexto = input("Ingresa palabra: ")
#print(eliminarespacio(sexto))
print(darvuelta(sexto))
