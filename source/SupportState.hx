package;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;

using StringTools;
class SupportState extends MusicBeatState
{
	public static var instance:SupportState;

    var curSelected:Int = 0;
    var isCat:Bool = false;
    var supportShit:Array<Dynamic> = [];
	var camFollow:FlxObject;
    var currentSelectedCat:String;
    private var grpSupport:FlxTypedGroup<Alphabet>;
    public static var firstStart:Bool = true;
    public static var finishedFunnyMove:Bool = false;
    private var iconArray:Array<CreditIcons> = [];
    public var acceptInput:Bool = true;
    var descText:FlxText;
	private var currentDescription:String = "";


    override function create()
	{
		instance = this;
        var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image("menuDesat"));
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpSupport = new FlxTypedGroup<Alphabet>();
		add(grpSupport);
        var textcredit = [
            ['Mod Team',                    '',                         '', ''],
            ['Rorutop',                     'rorutop',                  'Mod Leader with 4 skillz', 'https://gamebanana.com/members/1831109'],
            ['SuhoTUE',                      'suho',                     'BG Artist', 'https://gamebanana.com/members/1857006'],
            ['BOWZERR O',                     '73',                        'Musician', 'https://gamebanana.com/members/1856730'],
            ['Fire Fuel',                    'fuel',                      'Beta tester', ''],
            ['Created Dark Sheep',            '',                          '', ''],
            ['Chroma',                       'chroma',                     'nice funny sheep bro', 'https://www.c-h-r-o-m-a.jp/profile/index.html'],
            ['Special Thanks',                  '',                         '', ''],
            ['Deogracio',                     'deo',                        '', 'https://www.youtube.com/channel/UCF4abs-8CE6Ybxj3KTXaHsw'],
            ['Edakirah',                      'eda',                        '', ''],
            ['Some Discord Guys',             'discord',                    '', 'https://discord.gg/vCpEewF3Ve'],
            ['Kris',                          'kris',                      'kris', 'https://gamebanana.com/members/1841533']
                        ];
        for(i in textcredit){
			supportShit.push(i);
		}
		for (i in 0...supportShit.length)
		{
            var supportText:Alphabet = new Alphabet(0, (70 * i), supportShit[i][0], true, false, true);
			supportText.isMenuItem = true;
			supportText.targetY = i;
			grpSupport.add(supportText);
			// using a FlxGroup is too much fuss!
            if (firstStart)
				FlxTween.tween(supportText,{y: 60 + (i * 160)},1 + (i * 0.25) ,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{ 
						finishedFunnyMove = true; 
						changeSelection();
					}});
			else
				supportText.y = 60 + (i * 160);

            var icon:CreditIcons = new CreditIcons(supportShit[i][1]);
				icon.xAdd = supportText.width + 10;
				icon.sprTracker = supportText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
		}
        FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));
        descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 34, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);
		currentDescription = "none";

		super.create();
	}
    var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
        if (acceptInput)
            {
                if (controls.BACK && !isCat)
                    FlxG.switchState(new MainMenuState());
                else if (controls.BACK)
                {
                    isCat = false;
                    grpSupport.clear();
                    for (i in 0...supportShit.length)
                    {
                        var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, supportShit[i], true, false);
                        controlLabel.isMenuItem = true;
                        controlLabel.targetY = i;
                        grpSupport.add(controlLabel);
                        // DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
                    }
                    
                    curSelected = 0;
                    
                    changeSelection(curSelected);
                }
                if (controls.UP_P)
                    changeSelection(-1);
                if (controls.DOWN_P)
                    changeSelection(1);
                if (controls.ACCEPT)
                    {
                        if (supportShit[curSelected][3] != '')
                      {  FlxG.sound.play(Paths.sound('confirmMenu'));
                        CoolUtil.browserLoad(supportShit[curSelected][3]);
                        }
                    }
            }

		super.update(elapsed);

	}
    function changeSelection(change:Int = 0)
        {
            #if !switch
            // NGio.logEvent("Fresh");
            #end
            
            FlxG.sound.play(Paths.sound("scrollMenu"), 0.4);
    
            curSelected += change;
    
            if (curSelected < 0)
                curSelected = grpSupport.length - 1;
            if (curSelected >= grpSupport.length)
                curSelected = 0;
    
            if (isCat)
                currentDescription = "Please select a category";
            // selector.y = (70 * curSelected) + 30;
    
            var bullShit:Int = 0;
    
            for (item in grpSupport.members)
            {
                item.targetY = bullShit - curSelected;
                bullShit++;
    
                item.alpha = 0.6;
                // item.setGraphicSize(Std.int(item.width * 0.8));
    
                if (item.targetY == 0)
                {
                    item.alpha = 1;
                    // item.setGraphicSize(Std.int(item.width));
                }
            }
            descText.text = supportShit[curSelected][2];
        }
}