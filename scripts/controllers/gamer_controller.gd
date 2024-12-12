extends Node

@export var quiz: QuizTheme
@export var color_right: Color
@export var color_wrong: Color

var buttons: Array[Button]
var index: int 
var correct: int

@onready var question_texts: Label = $Content/Questionifo/QuestionText
@onready var question_image: TextureRect = $Content/Questionifo/ImageHolder/QuestionImage
@onready var question_video: VideoStreamPlayer = $Content/Questionifo/ImageHolder/QuestionVideo
@onready var question_audio: AudioStreamPlayer = $Content/Questionifo/ImageHolder/QuestionAudio


func _ready() -> void:
	for button in $Content/QuestionHolder.get_children():
		buttons.append(button)


	load_quiz()


func load_quiz() -> void:
	question_texts.text = quiz.theme[index].question_info
	
	var options = quiz.theme[index].options
	for i in buttons.size():
		buttons[i].text = options[i]
		buttons[i].pressed.connect(_buttons_answer.bind(buttons[i]))
		
	match quiz.theme[index].type:
		Enum.QuestionType.TEXT:
			$Content/Questionifo/ImageHolder.hide()
			
		Enum.QuestionType.IMAGE:
			$Content/Questionifo/ImageHolder.show()
			question_image.texture = quiz.theme[index].question_image
			
		Enum.QuestionType.VIDEO:
			$Content/Questionifo/ImageHolder.show()
			question_video.stream = quiz.theme[index].question_video
			question_video.play()
			
		Enum.QuestionType.AUDIO:
			$Content/Questionifo/ImageHolder.show()
			question_image.texture = quiz.theme[index].question_image
			question_audio.stream = quiz.theme[index].question_audio
			question_audio.play()
			
		
func _buttons_answer(button) -> void: 
	if quiz.theme[index].correct == button.text:
		button.modulate = color_right
	else:
		button.modulate = color_wrong
