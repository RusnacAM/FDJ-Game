extends Panel

var correct_code = "1938"
var numbers_array: Array
var code = ""
var pressed_cnt = 0


func _ready():
	randomize()

	initialize()
	reset()

	for button in $GridContainer.get_children():
		button.connect("pressed", self, "_button_pressed", [button])

	escoria.main.current_scene.game.hide_ui()
	escoria.main.current_scene.hide()


func initialize():
	numbers_array = range(1, 11)
	numbers_array.shuffle()
	print(numbers_array)

func reset():
	$win_label.hide()
	code = ""
	pressed_cnt = 0
	var i = 0
	for button in $GridContainer.get_children():
		var number = numbers_array[i]
		button.text = str(number)
		button.pressed = false
		button.disabled = false
		i += 1


func _button_pressed(button: Button):
	var number: String= button.text
	if pressed_cnt > 3:
		reset()
	else:
		button.disabled = true
		pressed_cnt +=1
		code += number

	if code == correct_code:
		win()

func win():
	$win_label.show()
	yield(get_tree().create_timer(2), "timeout")
	hide()

	escoria.main.current_scene.game.show_ui()
	escoria.main.current_scene.show()
	escoria.globals_manager.set_global("safe_solved", true)
	escoria.object_manager.get_object("safe").active = false
	escoria.object_manager.get_object("hole").active = true
	


func _on_quit_pressed():
	escoria.main.current_scene.game.show_ui()
	escoria.main.current_scene.show()
	queue_free()
