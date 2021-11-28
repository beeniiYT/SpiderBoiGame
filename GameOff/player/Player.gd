extends KinematicBody2D


const up = Vector2(0, -1)
const gravity = 15
const maxfall = 500
const maxspeed = 300
const accel = 100
const jump = 400
var motion = Vector2()
var portal_id = 0

func _physics_process(delta):
	motion.y += gravity
	if motion.y > maxfall:
		motion.y = maxfall
		
	motion.x = clamp(motion.x, -maxspeed, maxspeed)
	
	if Input.is_action_pressed("ui_right"):
		motion.x += accel
		$AnimationPlayer.play("run")
	elif Input.is_action_pressed("reload"):
		get_tree().reload_current_scene()
	else:
		motion.x = lerp(motion.x, 0, 0.2)
		$AnimationPlayer.play("Idle")
		
	if is_on_floor():
		if Input.is_action_pressed("ui_accept"):
			motion.y = -jump
			$jump.play()
	
	if !is_on_floor():
		if motion.y < 0:
			$AnimationPlayer.play("jump")
		if motion.y > 0:
			$AnimationPlayer.play("fall")
	move_and_slide(motion, up)


func _on_Area2D_area_entered(area):
	if(area.is_in_group("portal")):
		if(!area.lock_portal):
			do_teleport(area)
			$portal.play()
			
func do_teleport(area):
	for portal in get_tree().get_nodes_in_group("portal"):
		if(portal != area):
			if(portal_id == area.id):
				#area.lock_portal = true
				area.do_lock()
				global_position = portal.global_position
