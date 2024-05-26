extends Node3D

# Определите переменные
var rubbing = false
var rub_progress = 00
var rub_threshold = 100.0  # Задайте значение, при котором будет вызван джин
var last_rub_position = Vector2()

# Получите ссылки на нужные узлы
@onready var progress_bar = $CanvasLayer/ProgressBar
@onready var rub_area = $Cube/Area3D

func _ready():
	rub_area.connect("input_event", Callable(self, "_on_rub_area_input_event"))

# Обновите функцию так, чтобы она принимала все пять параметров
func _on_rub_area_input_event(_camera, event, _click_position, _click_normal, _shape_idx):
	if event is InputEventScreenDrag:
		if rubbing:
			var drag_vector = event.position - last_rub_position
			rub_progress += drag_vector.length()

			# Исправлена ошибка деления
			progress_bar.value = rub_progress / rub_threshold * 100.0  

			if rub_progress >= rub_threshold:
				invoke_genie()
				rub_progress = 0.0  # Сброс прогресса

		last_rub_position = event.position
		rubbing = true

	elif event is InputEventScreenTouch and not event.pressed:
		rubbing = false

	# Добавлены комментарии
	print("rub_progress:", rub_progress)  # Вывод значений для диагностики
	print("rub_threshold:", rub_threshold)
	print("progress_bar.value:", progress_bar.value)

func invoke_genie():
	print("Джин вызван!")
	# Здесь вы можете добавить логику появления джина
