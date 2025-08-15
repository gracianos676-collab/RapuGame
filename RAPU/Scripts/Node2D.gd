extends Node

func _ready():
 var num1 = "1000"
 print("hola Xóchitl,\nte\t AMO\t",num1)
 print("\t")
#el array
 var array = []
 array = [1, 2, 3, 9]
 print (array)
 print(array[0])
 print("cantidad es ",array.size())
 array[0]="chocokrispis"
 print (array)

 print("\t")
#las constantes
 const mividauwu = 1000#!!!
 print ("mi vida es: ",mividauwu)
 var dañito = 7+3
 var vidita = mividauwu
 print ("el daño es ", dañito)
 vidita=vidita-dañito
 print("mi vida ahora es: ", vidita)
 var turnos = 5
 
#while
 while turnos > 0:
  print(turnos)
  turnos = turnos - 1
 print ("Ya")	
 
#for in
 var nombre = "Santiago"
 game_over(nombre)
 
func game_over(Nombre):
 print ("you loser")
 print (Nombre)
