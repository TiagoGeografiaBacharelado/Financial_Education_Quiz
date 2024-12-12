extends Node

@export var quiz: QuizTheme
@export var color_right: Color
@export var color_wrong: Color

var buttons: Array[Button]
var index: int 
var correct: int

var current_quiz: QuizQuestion:
	get: return quiz.theme[index]

@onready var question_texts: Label = $Content/Questionifo/QuestionText
@onready var question_image: TextureRect = $Content/Questionifo/ImageHolder/QuestionImage
@onready var question_video: VideoStreamPlayer = $Content/Questionifo/ImageHolder/QuestionVideo
@onready var question_audio: AudioStreamPlayer = $Content/Questionifo/ImageHolder/QuestionAudio


func _ready() -> void:
	correct = 0
	for button in $Content/QuestionHolder.get_children():
		buttons.append(button)

	randomize_array(quiz.theme)
	load_quiz()


func load_quiz() -> void:
	if index >= quiz.theme.size():
		_game_over()
		return
		
	question_texts.text = current_quiz.question_info
	var options = randomize_array(current_quiz.options)
	
	for i in buttons.size():
		buttons[i].text = options[i]
		buttons[i].pressed.connect(_buttons_answer.bind(buttons[i]))
		
	match current_quiz.type:
		Enum.QuestionType.TEXT:
			$Content/Questionifo/ImageHolder.hide()
			
		Enum.QuestionType.IMAGE:
			$Content/Questionifo/ImageHolder.show()
			question_image.texture = current_quiz.question_image
			
		Enum.QuestionType.VIDEO:
			$Content/Questionifo/ImageHolder.show()
			question_video.stream = current_quiz.question_video
			question_video.play()
			
		Enum.QuestionType.AUDIO:
			$Content/Questionifo/ImageHolder.show()
			question_image.texture = current_quiz.question_image
			question_audio.stream = current_quiz.question_audio
			question_audio.play()
			
		
func _buttons_answer(button) -> void: 
	if current_quiz.correct == button.text:
		button.modulate = color_right
		correct += 1
		$AudioCorrect.play()
	else:
		button.modulate = color_wrong
		$AudioIncorrect.play()
		
	_next_question()

func _next_question() -> void:
	for bt in buttons:
		bt.pressed.disconnect(_buttons_answer)
	 
	await get_tree().create_timer(1).timeout
	for bt in buttons:
		bt.modulate = Color.WHITE
		
	question_audio.stop()
	question_video.stop()
	question_audio.stream = null
	question_video.stream = null
	
	
	
	index += 1
	load_quiz() 
	
func randomize_array(array: Array) -> Array:
	var array_temp = array
	array_temp.shuffle()
	return array_temp
	
func _game_over() -> void:
	$Content/GamerOver.show()
	$Content/GamerOver/Score.text = str(correct, "/", quiz.theme.size())
	
func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
