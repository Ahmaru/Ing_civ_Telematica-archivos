ancho=int(input("Ingrese el ancho del terreno(m):"))
largo=int(input("Ingrese el largo del terreno(m):"))
lado_sembradio=int(input("Ingrese el lado de cada sembradío (m):"))
num_sembradios_ancho=ancho//lado_sembradio
num_sembradios_largo=largo//lado_sembradio
n=num_sembradios_largo*num_sembradios_ancho
area_sembradio=lado_sembradio**2
area_total=area_sembradio*n
if lado_sembradio<=0 or lado_sembradio>ancho or lado_sembradio>largo:
    print("Error, no hay solución posible")
else:
    print("Se plantarán",(n),"sembradios de",(lado_sembradio),"x",(lado_sembradio))
    print("El total sembrado será de",(area_total),"m2")
    sobrante=ancho*largo-area_total
    print("El sobrante no sembrado en el terreno será de",(sobrante),"m2")
    if n<=200:
        humedad=350
        temperatura=450
        ph=1400
        monto=(4*humedad+1*temperatura+3*ph)*area_total
        monto_millones=round(monto/1000000, 2)
        subsidio=round((area_total//10000)*15, 2)
        costo_total=round(monto_millones-subsidio, 2)
        print("El costo de sensores será:M$",(monto_millones))
        print("El subsidio del gobierno será:M$",(subsidio))
        print("Costo total de la plantación:M$",(costo_total))
    elif 200<n<=400:
        humedad=300
        temperatura=350
        ph=1200
        monto=(4*humedad+1*temperatura+3*ph)*area_total
        monto_millones=round(monto/1000000, 2)
        subsidio=round((area_total//10000)*15, 2)
        costo_total=round(monto_millones-subsidio, 2)
        print("El costo de sensores será:M$",(monto_millones))
        print("El subsidio del gobierno será:M$",(subsidio))
        print("Costo total de la plantación:M$",(costo_total))
    elif 400<n<=1000:
        humedad=250
        temperatura=250
        ph=1000
        monto=(4*humedad+1*temperatura+3*ph)*area_total
        monto_millones=round(monto/1000000, 2)
        subsidio=round((area_total//10000)*15, 2)
        costo_total=round(monto_millones-subsidio, 2)
        print("El costo de sensores será:M$",(monto_millones))
        print("El subsidio del gobierno será:M$",(subsidio))
        print("Costo total de la plantación:M$",(costo_total))
    else:
        humedad=200
        temperatura=200
        ph=800
        monto=(4*humedad+1*temperatura+3*ph)*area_total
        monto_millones=round(monto/1000000, 2)
        subsidio=round((area_total//10000)*15, 2)
        costo_total=round(monto_millones-subsidio, 2)
        print("El costo de sensores será:M$",(monto_millones))
        print("El subsidio del gobierno será:M$",(subsidio))
        print("Costo total de la plantación:M$",(costo_total))