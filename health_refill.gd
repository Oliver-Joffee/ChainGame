extends Powerup

func power(player: Player):
	player.health = clamp(player.health + 25, 0, player.maxHealth)
