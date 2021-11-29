package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;


	//15 portraits lol
	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var gfportrait:FlxSprite;
	var bfportrait:FlxSprite;
	var sheepportrait:FlxSprite;
	var sheepehportrait:FlxSprite;
	var sheepblackportrait:FlxSprite;
	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'dark-sheep':
				FlxG.sound.playMusic(Paths.music('wind'), 0);
				FlxG.sound.music.fadeIn(1, 0, 1);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel', 'week6');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad', 'week6');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil', 'week6');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

			default:
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 100;
				box.x = -100;	 
				box.y = 375;
				box.flipX = true;				
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait', 'week6');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait', 'week6');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		gfportrait = new FlxSprite(-20, 40);
		gfportrait.frames = Paths.getSparrowAtlas('portrait/gfPortrait', 'shared');
		gfportrait.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		//gfportrait.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		gfportrait.updateHitbox();
		gfportrait.scrollFactor.set();
		add(gfportrait);
		gfportrait.visible = false;	

		bfportrait = new FlxSprite(-20, 40);
		bfportrait.frames = Paths.getSparrowAtlas('portrait/boyfriendPortrait', 'shared');
		bfportrait.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		//bfportrait.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		bfportrait.updateHitbox();
		bfportrait.scrollFactor.set();
		add(bfportrait);
		bfportrait.visible = false;																								
		
		sheepportrait = new FlxSprite(100, 150);
		sheepportrait.frames = Paths.getSparrowAtlas('portrait/sheepPortrait', 'shared');
		sheepportrait.animation.addByPrefix('sheep', 'sheep', 24, false);
		sheepportrait.updateHitbox();
		sheepportrait.scrollFactor.set();
		add(sheepportrait);
		sheepportrait.visible = false;		
		sheepehportrait = new FlxSprite(100, 150);
		sheepehportrait.frames = Paths.getSparrowAtlas('portrait/sheepehportrait', 'shared');
		sheepehportrait.animation.addByPrefix('eh', 'sheepeh', 24, false);
		sheepehportrait.updateHitbox();
		sheepehportrait.scrollFactor.set();
		add(sheepehportrait);
		sheepehportrait.visible = false;
		sheepblackportrait = new FlxSprite(100, 150);
		sheepblackportrait.frames = Paths.getSparrowAtlas('portrait/sheepblackportrait', 'shared');
		sheepblackportrait.animation.addByPrefix('black', 'niggasheep', 24, false);
		sheepblackportrait.updateHitbox();
		sheepblackportrait.scrollFactor.set();
		add(sheepblackportrait);
		sheepblackportrait.visible = false;

		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox', 'week6'));
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}
		#if mobile
		var justTouched:Bool = false;

		for (touch in FlxG.touches.list)
		{
			justTouched = false;
			
			if (touch.justReleased){
				justTouched = true;
			}
		}
		#end

		if (FlxG.keys.justPressed.ANY #if mobile || justTouched #end && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns' || PlayState.SONG.song.toLowerCase() == 'dark-sheep' )
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'bf':
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				sheepportrait.visible = false;
				sheepehportrait.visible = false;
				sheepblackportrait.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'gf':
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				sheepportrait.visible = false;
				sheepehportrait.visible = false;
				sheepblackportrait.visible = false;
				if (!gfportrait.visible)
				{
					box.flipX = true;		
					gfportrait.visible = true;
					gfportrait.animation.play('enter');
				}
			case 'boyfriend':
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				sheepportrait.visible = false;
				sheepehportrait.visible = false;
				sheepblackportrait.visible = false;
				if (!bfportrait.visible)
				{
					box.flipX = false;		
					bfportrait.visible = true;
					bfportrait.animation.play('enter');
				}		
			case 'sheep':										
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				sheepportrait.visible = false;
				sheepehportrait.visible = false;
				sheepblackportrait.visible = false;
				if (!sheepportrait.visible)
				{
					box.flipX = true;		
					sheepportrait.visible = true;
				}
			case 'sheepblack':
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				sheepportrait.visible = false;
				sheepehportrait.visible = false;
				sheepblackportrait.visible = false;
				if (!sheepblackportrait.visible)
				{
					box.flipX = true;
					sheepblackportrait.animation.play('black');	
					sheepblackportrait.visible = true;
				}
			case 'sheepeh':
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				sheepportrait.visible = false;
				sheepehportrait.visible = false;
				sheepblackportrait.visible = false;
				if (!sheepehportrait.visible)
				{
					box.flipX = true;
					sheepehportrait.animation.play('eh');
					sheepehportrait.visible = true;
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}