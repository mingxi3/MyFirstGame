extends CharacterBody2D

@export var move_speed : float = 100
@export var animator : AnimatedSprite2D
@export var bullet_scene : PackedScene
var is_game_over : bool = false

func game_over():
	if not is_game_over:
		#设置游戏结束，播放失败动画
		is_game_over = true
		animator.play("game_over")
		
		get_tree().current_scene.show_game_over()
		$"Game over Sound".play() #播放失败音效
		
		#等待三秒后重置游戏
		$RestartTimer.start()

func  _physics_process(delta: float) -> void:
	if velocity == Vector2.ZERO or is_game_over:
		$RunningSound.stop() #停止走路音效
	elif not $RunningSound.playing:
		$RunningSound.play() #播放走路音效

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if not is_game_over:
		velocity = Input.get_vector("left","right","up","down") * move_speed #获取上下左右的值，并乘以变量move_speed
		
		if velocity == Vector2.ZERO:
			animator.play("idle") #如果速度为零，播放动画idle
		else:
			animator.play("run") #如果速度不为零，播放动画run
		
		move_and_slide() #用于让玩家移动，没有的话玩家就移动不了


func _on_fire() -> void:
	#如果玩家在移动，或者游戏结束了，就不发射子弹
	if velocity != Vector2.ZERO or is_game_over:
		return
	
	$FireSound.play() #播放子弹音效
	
	#生成子弹节点，设置正确的子弹位置，并将其添加进场景树
	var bullet_node = bullet_scene.instantiate()
	bullet_node.position = position + Vector2(6,6)
	get_tree().current_scene.add_child(bullet_node)


func _reload_scene() -> void:
	get_tree().reload_current_scene()
