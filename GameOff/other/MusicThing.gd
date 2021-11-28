extends Node2D

var music = load("res://other/BeepBox-Song (1).mp3")

func Play_Music():
	$Music.stream = music
	$Music.play()
