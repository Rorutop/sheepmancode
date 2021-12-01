package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;
import flixel.FlxState;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class StoryMenuState extends MusicBeatState
{
	var scoreText:FlxText;

	var weekData:Array<Dynamic> = [
		['Tutorial'],
		['Dark-Sheep']
	];
	var curDifficulty:Int = 1;

	public static var weekUnlocked:Array<Bool> = [true, true, true, true, true, true, true, true];

	var weekCharacters:Array<Dynamic> = [
		['', 'bf', 'gf'],
		['dark-sheep', 'bf' ,'gf']
	];

	var weekNames:Array<String> = [
		"",
		"Sheepman",
	];

	var txtWeekTitle:FlxText;

	var curWeek:Int = 0;
	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItem>;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;

	var grpLocks:FlxTypedGroup<FlxSprite>;

	var modchartText:FlxText;
	var cloudText:FlxText;
	var copyrightMessage:FlxText;
	var copyrightText:FlxText;
	var lowqualityText:FlxText;
	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	var checklist1:FlxSprite;
	var checklist2:FlxSprite;
	var checklist3:FlxSprite;
	var checklist4:FlxSprite;
	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Story Mode Menu", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (FlxG.sound.music != null)
		{
			if (!FlxG.sound.music.playing)
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		modchartText = new FlxText(FlxG.width * 0.7 - 120, 610, 0, "", 32);
		modchartText.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, RIGHT);

		cloudText = new FlxText(FlxG.width * 0.7 - 120, 630, 0, "", 32);
		cloudText.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, RIGHT);

		copyrightText = new FlxText(FlxG.width * 0.7 - 120, 590, 0, "", 32);
		copyrightText.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, RIGHT);

		lowqualityText = new FlxText(FlxG.width * 0.7 - 120, 650, 0, "", 32);
		lowqualityText.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, RIGHT);

		copyrightMessage = new FlxText(FlxG.width * 0.3 - 200, 590, 0, "", 32);
		copyrightMessage.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, CENTER);

		scoreText = new FlxText(10, 10, 0, "SCORE: 49324858", 36);
		scoreText.setFormat("VCR OSD Mono", 32);

		txtWeekTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtWeekTitle.alpha = 0.7;

		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat(Paths.font("vcr.ttf"), 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		var yellowBG:FlxSprite = new FlxSprite(0, 56).makeGraphic(FlxG.width, 400, 0xFFF9CF51);

		grpWeekText = new FlxTypedGroup<MenuItem>();
		add(grpWeekText);

		var blackBarThingie:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 56, FlxColor.BLACK);
		add(blackBarThingie);

		grpWeekCharacters = new FlxTypedGroup<MenuCharacter>();

		grpLocks = new FlxTypedGroup<FlxSprite>();
		add(grpLocks);

		trace("Line 70");

		for (i in 0...weekData.length)
		{
			var weekThing:MenuItem = new MenuItem(0, yellowBG.y + yellowBG.height + 10, i);
			weekThing.y += ((weekThing.height + 20) * i);
			weekThing.targetY = i;
			grpWeekText.add(weekThing);

			weekThing.screenCenter(X);
			weekThing.antialiasing = true;
			// weekThing.updateHitbox();

			// Needs an offset thingie
			if (!weekUnlocked[i])
			{
				var lock:FlxSprite = new FlxSprite(weekThing.width + 10 + weekThing.x);
				lock.frames = ui_tex;
				lock.animation.addByPrefix('lock', 'lock');
				lock.animation.play('lock');
				lock.ID = i;
				lock.antialiasing = true;
				grpLocks.add(lock);
			}
		}

		trace("Line 96");

		grpWeekCharacters.add(new MenuCharacter(0, 100, 0.5, false));
		grpWeekCharacters.add(new MenuCharacter(450, 25, 0.9, true));
		grpWeekCharacters.add(new MenuCharacter(850, 100, 0.5, true));

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		trace("Line 124");

		leftArrow = new FlxSprite(grpWeekText.members[0].x + grpWeekText.members[0].width + 10, grpWeekText.members[0].y + 10);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		difficultySelectors.add(leftArrow);

		sprDifficulty = new FlxSprite(leftArrow.x + 130, leftArrow.y);
		sprDifficulty.frames = ui_tex;
		sprDifficulty.animation.addByPrefix('normal', 'NORMAL');
		sprDifficulty.animation.addByPrefix('hard', 'HARD');
		sprDifficulty.animation.addByPrefix('insane', 'INSANE');
		changeDifficulty();

		checklist1 = new FlxSprite(890 - 150, 610);
		checklist1.frames = Paths.getSparrowAtlas('checklist');
		checklist1.animation.addByPrefix('list', 'list');
		checklist1.animation.addByPrefix('checklist', 'checklist');

		checklist2 = new FlxSprite(890 - 150, 630);
		checklist2.frames = Paths.getSparrowAtlas('checklist');
		checklist2.animation.addByPrefix('list', 'list');
		checklist2.animation.addByPrefix('checklist', 'checklist');

		checklist3 = new FlxSprite(890 - 150, 590);
		checklist3.frames = Paths.getSparrowAtlas('checklist');
		checklist3.animation.addByPrefix('list', 'list');
		checklist3.animation.addByPrefix('checklist', 'checklist');

		checklist4 = new FlxSprite(890 - 150, 650);
		checklist4.frames = Paths.getSparrowAtlas('checklist');
		checklist4.animation.addByPrefix('list', 'list');
		checklist4.animation.addByPrefix('checklist', 'checklist');
		difficultySelectors.add(sprDifficulty);

		rightArrow = new FlxSprite(sprDifficulty.x + sprDifficulty.width + 50, leftArrow.y);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		difficultySelectors.add(rightArrow);

		trace("Line 150");

		add(yellowBG);
		add(grpWeekCharacters);

		txtTracklist = new FlxText(FlxG.width * 0.05, yellowBG.x + yellowBG.height + 100, 0, "Tracks", 32);
		txtTracklist.alignment = CENTER;
		txtTracklist.font = rankText.font;
		txtTracklist.color = 0xFFe55777;
		add(txtTracklist);
		// add(rankText);
		add(scoreText);
		add(txtWeekTitle);
		add(checklist1);
		add(checklist2);
		add(checklist3);
		add(checklist4);
		add(modchartText);
		add(cloudText);
		add(copyrightText);
		add(copyrightMessage);
		add(lowqualityText);
		

		updateText();

		trace("Line 165");

		super.create();
	}

	override function update(elapsed:Float)
	{
		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.5));

		scoreText.text = "WEEK SCORE:" + lerpScore;

		txtWeekTitle.text = weekNames[curWeek].toUpperCase();
		txtWeekTitle.x = FlxG.width - (txtWeekTitle.width + 10);
		checklist1.alpha = 0;
		checklist2.alpha = 0;
		checklist3.alpha = 0;
		// FlxG.watch.addQuick('font', scoreText.font);
		modchartText.text = "";
		cloudText.text = "";
		copyrightText.text = "";
		copyrightMessage.text = "";
		if (FlxG.save.data.distractions)
			{
				lowqualityText.text = "Press Y to enable Low Detail Mode";
				checklist4.animation.play('list');
			}
			else
			{
				lowqualityText.text = "Press Y to disable Low Detail Mode";
				checklist4.animation.play('checklist');
			}
			if (FlxG.keys.justPressed.Y)
			{
				FlxG.save.data.distractions = !FlxG.save.data.distractions;
				if (FlxG.save.data.distractions) FlxG.sound.play(Paths.sound('cancelMenu'));
				else FlxG.sound.play(Paths.sound('scrollMenu'));
			}
		if (curWeek == 1)
		{
			checklist1.alpha = 1;
			checklist2.alpha = 1;
			checklist3.alpha = 1;
			copyrightMessage.text = "Tried to make the song \n uncopyrighted but failed.. \n u can try the remix! \n anyways!";

			if (!Main.modchartEnable)
			{
				modchartText.text = "Press I to enable Modchart";
				checklist1.animation.play('list');
			}
			else
			{
				modchartText.text = "Press I to disable Modchart";
				checklist1.animation.play('checklist');
			}
			if (!Main.cloudsEnable)
			{
				cloudText.text = "Press O to enable Clouds";
				checklist2.animation.play('list');
			}
			else
			{
				cloudText.text = "Press O to disable Clouds";
				checklist2.animation.play('checklist');
			}
			if (!Main.copyright)
			{
				copyrightText.text = "Press U to get rid of Copyright";
				checklist3.animation.play('list');
			}
			else
			{
				copyrightText.text = "Press U to change the song back";
				checklist3.animation.play('checklist');
			}
			if (FlxG.keys.justPressed.I)
			{
				Main.modchartEnable = !Main.modchartEnable;
				if (Main.modchartEnable) FlxG.sound.play(Paths.sound('cancelMenu'));
				else FlxG.sound.play(Paths.sound('scrollMenu'));
			}
			if (FlxG.keys.justPressed.O)
			{
				Main.cloudsEnable = !Main.cloudsEnable;
				if (Main.cloudsEnable) FlxG.sound.play(Paths.sound('cancelMenu'));
				else FlxG.sound.play(Paths.sound('scrollMenu'));
			}
			if (FlxG.keys.justPressed.U)
			{
				Main.copyright = !Main.copyright;
				if (Main.copyright) FlxG.sound.play(Paths.sound('cancelMenu'));
				else FlxG.sound.play(Paths.sound('scrollMenu'));
			}
		}
		difficultySelectors.visible = weekUnlocked[curWeek];

		grpLocks.forEach(function(lock:FlxSprite)
		{
			lock.y = grpWeekText.members[lock.ID].y;
		});

		if (!movedBack)
		{
			if (!selectedWeek)
			{
				if (controls.UP_P)
				{
					changeWeek(-1);
				}

				if (controls.DOWN_P)
				{
					changeWeek(1);
				}

				if (controls.RIGHT)
					rightArrow.animation.play('press')
				else
					rightArrow.animation.play('idle');

				if (controls.LEFT)
					leftArrow.animation.play('press');
				else
					leftArrow.animation.play('idle');

				if (controls.RIGHT_P)
					changeDifficulty(1);
				if (controls.LEFT_P)
					changeDifficulty(-1);
			}

			if (controls.ACCEPT)
			{
				selectWeek();
			}
		}

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			FlxG.switchState(new MainMenuState());
		}

		super.update(elapsed);
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function selectWeek()
	{
		if (weekUnlocked[curWeek])
		{
			if (stopspamming == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));

				grpWeekText.members[curWeek].startFlashing();
				grpWeekCharacters.members[1].animation.play('bfConfirm');
				stopspamming = true;
			}

			PlayState.storyPlaylist = weekData[curWeek];
			PlayState.isStoryMode = true;
			selectedWeek = true;


			PlayState.storyDifficulty = curDifficulty;

			// adjusting the song name to be compatible
			var songFormat = StringTools.replace(PlayState.storyPlaylist[0], " ", "-");
			switch (songFormat) {
				case 'Dad-Battle': songFormat = 'Dadbattle';
				case 'Philly-Nice': songFormat = 'Philly';
			}

			var poop:String = Highscore.formatSong(songFormat, curDifficulty);
			PlayState.sicks = 0;
			PlayState.bads = 0;
			PlayState.shits = 0;
			PlayState.goods = 0;
			PlayState.campaignMisses = 0;
			PlayState.SONG = Song.loadFromJson(poop, PlayState.storyPlaylist[0]);
			PlayState.storyWeek = curWeek;
			PlayState.campaignScore = 0;
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState(), true);
			});
		}
	}

	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = 2;
		if (curDifficulty > 2)
			curDifficulty = 0;

		sprDifficulty.offset.x = 0;

		switch (curDifficulty)
		{
			case 0:
				sprDifficulty.animation.play('normal');
				sprDifficulty.offset.x = 70;
			case 1:
				sprDifficulty.animation.play('hard');
				sprDifficulty.offset.x = 20;
			case 2:
				sprDifficulty.animation.play('insane');
				sprDifficulty.offset.x = 75;
		}

		sprDifficulty.alpha = 0;

		// USING THESE WEIRD VALUES SO THAT IT DOESNT FLOAT UP
		sprDifficulty.y = leftArrow.y - 15;
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end

		FlxTween.tween(sprDifficulty, {y: leftArrow.y + 15, alpha: 1}, 0.07);
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= weekData.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = weekData.length - 1;

		var bullShit:Int = 0;

		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0) && weekUnlocked[curWeek])
				item.alpha = 1;
			else
				item.alpha = 0.6;
			bullShit++;
		}

		FlxG.sound.play(Paths.sound('scrollMenu'));

		updateText();
	}

	function updateText()
	{
		grpWeekCharacters.members[0].setCharacter(weekCharacters[curWeek][0]);
		grpWeekCharacters.members[1].setCharacter(weekCharacters[curWeek][1]);
		grpWeekCharacters.members[2].setCharacter(weekCharacters[curWeek][2]);

		txtTracklist.text = "Tracks\n";
		var stringThing:Array<String> = weekData[curWeek];

		for (i in stringThing)
			txtTracklist.text += "\n" + i;

		txtTracklist.text = txtTracklist.text.toUpperCase();

		txtTracklist.screenCenter(X);
		txtTracklist.x -= FlxG.width * 0.35;

		txtTracklist.text += "\n";

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end
	}
}
