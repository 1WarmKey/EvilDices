extends Node2D

#Массив с выбраными кубами
var pressed_buttons := []
#Количество очков
var points := 0
# Тест коммита

#Номер раунда
var raund := 0
#Номер финального раунда
var final_raund := 20

#Словарь с кубиками
var dcie_dict := {
	"d2": 2,
	"d6": 6,
	"d8": 8,
	"d10": 10,
	"d12": 12,
	"d20": 20,
}


#Оброботчик раунда и подсчет
func raund_counter():
	if pressed_buttons.size() == 0:
		print("Нет выбранных кубиков, раунд не засчитан!")
		return
	raund = raund + 1 
	$LabelRaund.text = "Раунд: %d из %d" % [raund, final_raund]
	print("Раунд ", raund)
	if raund >= 20 and points <= 666:
		print("Ты проиграл свою душу")

>>>>>>> f52a1a1 (Add raund and slots.)

#Бросок любого кубика
func dices(d: int):
	var roll_dices := randi() % d + 1
	return roll_dices


#Подсчет всех выбранных кубиков
func roll():
	if pressed_buttons.size() == 0:
		print("Нет выбранных кубиков!")
		return

	for id in pressed_buttons:
		var roll = dices(6)
		points += roll
		print("Кубик ", id, " выдал:", roll, " очков!")
	$PointsLabel.text = "Очки: %d" % points + " из 666"
	print("Итого очков:", points)


#Выборка всех кнопок
func _ready():
	$Button1.pressed.connect(Callable(self, "_on_button_pressed").bind(1))
	$Button2.pressed.connect(Callable(self, "_on_button_pressed").bind(2))
	$Button3.pressed.connect(Callable(self, "_on_button_pressed").bind(3))


#Вжатие кнопок и добавление в массив
func _on_button_pressed(button_id: int):
	if  pressed_buttons.has(button_id):
		pressed_buttons.erase(button_id)
		print("Нажаты кнопки: ", pressed_buttons)
	else:
		pressed_buttons.append(button_id)
		print("Добавлена кнопка:", button_id)
	print("Текущие кнопки:", pressed_buttons)

#Сброс массива с выбранными кубами
func _on_button_drop_pressed():
	pressed_buttons.clear()
	print("Сброшено!")

#Тригер для при наборе 666 очков
func win_game():
	if points >= 666:
		print("Ты выиграл забирай свою жалкую душу!")
		$FinalLabel.text = "Ты выиграл забирай свою жалкую душу!"


#Жмать чтобы кинуть выбранные кубы и проверка выигра ли
func _on_button_play_pressed() -> void:
	win_game()
	roll()
	raund_counter()


func _on_devoloper_tools_pressed() -> void:
	points =+ 600
