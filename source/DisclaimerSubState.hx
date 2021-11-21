package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import flixel.graphics.FlxGraphic;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;

class DisclaimerSubState extends MusicBeatState
{
	override function create()
	{
		var randomImage:Int = FlxG.random.int(1, 3);
		var bg:FlxSprite = new FlxSprite();
		switch(randomImage)
		{
			case 1:
			bg.loadGraphic(Paths.image('sheepImages/troll', 'preload'));
			case 2:
			bg.loadGraphic(Paths.image('sheepImages/heart', 'preload'));
			case 3:
			bg.loadGraphic(Paths.image('sheepImages/attic', 'preload'));
		}
		bg.screenCenter();
		add(bg);
		
		var txt:FlxText = new FlxText(0, 0, FlxG.width,
			"Disclaimer!"
			+ "\n\n Music and Original Character belongs to CHROMA."
			+ "\n I made the remix, art, and shit with our team lol"
			+ "\n\n There are some flashing"
			+ "'\n lights in the game if ur sentisive to light"
			+ "\n\n Also there is an INSANE mode. this difficulty was made for fun"
			+ "\n and not recommend if ur decent and shit at the game"
			+ "\n\npress ENTER to go to the intro!",
			32);
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;
		txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
		txt.borderColor = FlxColor.BLACK;
		txt.borderSize = 3;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt.screenCenter();
		add(txt);
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ENTER)
		{
			FlxG.switchState(new TitleState());
		}
		super.update(elapsed);
	}
}
