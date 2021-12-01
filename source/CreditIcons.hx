package;

import flixel.FlxSprite;

class CreditIcons extends FlxSprite
{
	public var sprTracker:FlxSprite;
	public var xAdd:Float = 0;
	public function new(char:String = 'bf')
	{ // copied from healthicon.hx lmfao
		super();
		
		loadGraphic(Paths.image('crediticons'), true, 150, 150);

		antialiasing = true;
		animation.add('rorutop', [0], 0, false);
		animation.add('suho', [1], 0, false);
		animation.add('fuel', [2], 0, false);
		animation.add('73', [3], 0, false);
		animation.add('chroma', [4], 0, false);
		animation.add('deo', [5], 0, false);
		animation.add('eda', [6], 0, false);
		animation.add('discord', [7], 0, false);
		animation.add('kris', [8], 0, false);
		animation.add('', [9], 0, false);
		animation.play(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + xAdd, sprTracker.y - 30);
	}
}