extends Node


var score = 0
@onready var score_label: Label = $ScoreLabel
const maxScore = 14


func add_point():
	score += 1
	print(score)
	score_label.text = "You collected "+ str(score) +" coins!"
	
	if score == maxScore:
		score_label.text = "You collected EVERY SINGLE COIN!"
