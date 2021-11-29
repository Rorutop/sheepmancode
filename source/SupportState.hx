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
    var supportShit:Array<String> = ['Chroma (Who created those characters and dark sheep music)', 'Rorutop (Coder, Charter, Artist)'];
	var camFollow:FlxObject;
    var currentSelectedCat:String;
    private var grpSupport:FlxTypedGroup<Alphabet>;
    public static var firstStart:Bool = true;
    public static var finishedFunnyMove:Bool = false;

    public var acceptInput:Bool = true;

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

		for (i in 0...supportShit.length)
		{
            var supportText:Alphabet = new Alphabet(0, (70 * i) + 30, supportShit[i], true, false, true);
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
		}
        FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));

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
                        FlxG.sound.play(Paths.sound('confirmMenu'));
                        if (supportShit[curSelected] == 'Chroma')
                        {
                            fancyOpenURL("https://www.c-h-r-o-m-a.jp/");
                        }
                        if (supportShit[curSelected] == 'Rorutop')
                        {
                            fancyOpenURL("https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game");
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
        }
}