extends Node2D

@export var slime_scene : PackedScene
@export var spawn_timer : Timer
@export var score : int = 0
@export var score_label : Label
@export var game_over_label : Label

func show_game_over():
	game_over_label.visible = true #显示游戏结束
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn_timer.wait_time -= 0.2 * delta
	spawn_timer.wait_time = clamp(spawn_timer.wait_time,1,3)
	
	#将变量score_label文字换成score + 变量score（str()把变量score更改为字符串类型）
	score_label.text = "score：" + str(score) 

func _spawn_sliime() -> void:
	var slime_node = slime_scene.instantiate()
	slime_node.position = Vector2(260,randf_range(50,115)) #将变量slime_node保存坐标：Y260、X：50~115中随机一个数
	get_tree().current_scene.add_child(slime_node) #将敌人添加进场景
