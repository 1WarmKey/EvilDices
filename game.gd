extends Node2D

#Массив с выбраными кубами
var pressed_buttons := []
#Количество очков
var points := 0
# Тест коммита

#Номер раунда
var round := 0
#Номер финального раунда
var final_round := 20
#Количсетво рук
var hand_point := 3
var previous_hand_point := 0
var button_container : Node2D

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
func round_counter():
	if pressed_buttons.size() == 0:
		print("Нет выбранных кубиков, раунд не засчитан!")
		return
	round = round + 1 
	$LabelRound.text = "Раунд: %d из %d" % [round, final_round]
	print("Раунд ", round)
	if round >= 20 and points <= 666:
		print("Ты проиграл свою душу")


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
		var roll = dices(6) # сюда должна передоваться сторна кубика
		points += roll
		print("Кубик ", id, " выдал:", roll, " очков!")
	$PointsLabel.text = "Очки: %d" % points + " из 666"
	print("Итого очков:", points)





#Выборка всех кнопок
func _ready():
	$Button1.pressed.connect(Callable(self, "_on_button_pressed").bind(1))
	$Button2.pressed.connect(Callable(self, "_on_button_pressed").bind(2))
	$Button3.pressed.connect(Callable(self, "_on_button_pressed").bind(3))
	button_container = Node2D.new()
	add_child(button_container)


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
	round_counter()


func _on_devoloper_tools_pressed() -> void:
	points =+ 600

func _on_devoloper_tools_2_pressed() -> void:
	hand_point += 1
	print("Теперь hand_point:", hand_point)


#Плохая практика, процеес выполняется без прерывно проверя увеличилась ли рука нужно будет сделать что бы только если руку увеличило проверялось
func _process(_delta):
	if hand_point > previous_hand_point:
		for i in range(previous_hand_point, hand_point):
			spawn_button(i)
		previous_hand_point = hand_point

func spawn_button(index: int):
	var btn := Button.new()
	btn.text = "Slot %d" % (index + 1)
	btn.position = Vector2(200 + index * 120, 200)
	btn.pressed.connect(func():
		_on_dynamic_button_pressed(index)
		)
	button_container.add_child(btn)

func _on_dynamic_button_pressed(index):
	print("Нажата кнопка №%d" % (index + 1))


func _on_exit_button_pressed() -> void:
	print("Yes")
	var menuScene = load("res://Scens/game_menu.tscn")
	get_tree().change_scene_to_packed(menuScene)
