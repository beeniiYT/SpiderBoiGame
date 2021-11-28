extends Sprite

var speed = 200
var  velocity = Vector2()
var bullet = preload("res://Bullet.tscn")
var can_shoot = true
var is_dead = false
var reload_speed = 0.25
var _default_reload = reload_speed
var power_up_reset = []
var damage = 1
var def_damg = damage
var Arena = "res://Arena.tscn"

func _ready():
	Global.player = self

func _exit_tree():
	Global.player = null

func _process(delta):
	velocity.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	velocity.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	velocity = velocity.normalized()
	
	global_position.x = clamp(global_position.x, 24, 616)
	global_position.y = clamp(global_position.y, 24, 336)
	
	if is_dead == false:
		global_position += speed * velocity * delta
		look_at(get_global_mouse_position())

	if Input.is_action_pressed("LMB") and Global.node_creation_parent != null and can_shoot and is_dead == false:
			var bullet_instance = Global.instance_node(bullet, global_position, Global.node_creation_parent)
			bullet_instance.damage = damage
			$ShootNoise.play()
			$Reload_Speed.start()
			can_shoot = false
		



func _on_Reload_Speed_timeout():
	can_shoot = true
	$Reload_Speed.wait_time = reload_speed


func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy"):
		is_dead = true
		$DeadNoise.play()
		visible = false
		yield(get_tree().create_timer(0.5), "timeout")
		get_tree().change_scene("res://DedMenu.tscn")
		get_tree().get_root().get_node("/root/Arena").queue_free()

func _on_Power_up_cooldown_timeout():
	if power_up_reset.find("Reload") !=null:
		reload_speed = _default_reload
		power_up_reset.erase("Reload")
	if power_up_reset.find("Damage") !=null:
		damage = def_damg
		power_up_reset.erase("Damage")

