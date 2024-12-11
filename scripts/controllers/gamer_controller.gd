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
