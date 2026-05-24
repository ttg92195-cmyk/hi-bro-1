extends Area2D
class_name BossProjectile

var projectile_velocity: Vector2 = Vector2(200.0, 0.0)
var damage: int = 10
var source_id: String = ""
var color: Color = Color.ORANGE_RED
var _lifetime: float = 4.0
var _hit: bool = false

func _ready() -> void:
        body_entered.connect(_on_body_entered)
        # Check pre-existing overlaps in case the projectile spawned inside a body
        for body in get_overlapping_bodies():
                _try_damage(body)
        queue_redraw()

func _physics_process(delta: float) -> void:
        global_position += projectile_velocity * delta
        _lifetime -= delta
        if _lifetime <= 0.0:
                queue_free()

func _draw() -> void:
        draw_circle(Vector2.ZERO, 8.0, color)

func _on_body_entered(body: Node) -> void:
        _try_damage(body)

func _try_damage(body: Node) -> void:
        if _hit:
                return
        _hit = true
        if body is CharacterBase:
                body.take_damage(damage, source_id)
        queue_free()
