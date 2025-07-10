extends Node2D

#Массив с выбраными кубами
var pressed_buttons := []
#Количество очков
var points := 0
# Тест коммита

#Бросок любого кубика
func roll():
	if pressed_buttons.size() == 0:
		print("Нет выбранных кубиков!")
		return

	for id in pressed_buttons:
		var roll := randi() % 6 + 1 
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


func _on_devoloper_tools_pressed() -> void:
	points =+ 600
