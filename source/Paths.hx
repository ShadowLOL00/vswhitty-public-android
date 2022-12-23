package;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;

class Paths
{
	inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end;

	static var currentLevel:String;

	static public function setCurrentLevel(name:String)
	{
		currentLevel = name.toLowerCase();
	}
	static function getPath(file:String, type:AssetType, library:Null<String>)
	{
		if (library != null)
			return getLibraryPath(file, library);
		if (currentLevel != null)
		{
			var levelPath = SUtil.getPath() + getLibraryPathForce(file, currentLevel);
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;
			levelPath = SUtil.getPath() + getLibraryPathForce(file, "shared");
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;
		}

		return getPreloadPath(file);
	}

	static public function getLibraryPath(file:String, library = "preload")
	{
		return if (library == "preload" || library == "default") getPreloadPath(SUtil.getPath() + file); else getLibraryPathForce(SUtil.getPath() + file, library);
	}

	inline static function getLibraryPathForce(file:String, library:String)
	{
		return SUtil.getPath() + '$library:assets/$library/$file';
	}

	inline static function getPreloadPath(file:String)
	{
		return SUtil.getPath() + 'assets/$file';
	}
	inline static public function file(file:String, type:AssetType = TEXT, ?library:String)
	{
		return getPath(SUtil.getPath() + file, type, library);
	}

	inline static public function lua(key:String,?library:String)
	{
		return getPath(SUtil.getPath() + 'data/$key.lua', TEXT, library);
	}

	inline static public function luaImage(key:String, ?library:String)
	{
		return getPath(SUtil.getPath() + 'data/$key.png', IMAGE, library);
	}

	inline static public function txt(key:String, ?library:String)
	{
		return getPath(SUtil.getPath() + 'data/$key.txt', TEXT, library);
	}
	inline static public function xml(key:String, ?library:String)
	{
		return getPath(SUtil.getPath() + 'data/$key.xml', TEXT, library);
	}
	inline static public function json(key:String, ?library:String)
	{
		return getPath(SUtil.getPath() + 'data/$key.json', TEXT, library);
	}

	static public function sound(key:String, ?library:String)
	{
		return getPath(SUtil.getPath() + 'sounds/$key.$SOUND_EXT', SOUND, library);
	}

	inline static public function soundRandom(key:String, min:Int, max:Int, ?library:String)
	{
		return sound(key + FlxG.random.int(min, max), library);
	}
	inline static public function music(key:String, ?library:String)
	{
		return getPath(SUtil.getPath() + 'music/$key.$SOUND_EXT', MUSIC, library);
	}
	inline static public function voices(song:String)
	{
		return SUtil.getPath() + 'songs:assets/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';
	}
	inline static public function inst(song:String)
	{
		return SUtil.getPath() + 'songs:assets/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
	}
	inline static public function image(key:String, ?library:String)
	{
		return getPath(SUtil.getPath() + 'images/$key.png', IMAGE, library);
	}
	inline static public function font(key:String)
	{
		return SUtil.getPath() + 'assets/fonts/$key';
	}
	inline static public function getSparrowAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSparrow(image(key, library), file(SUtil.getPath() + 'images/$key.xml', library));
	}
	inline static public function getPackerAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key, library), file(SUtil.getPath() + 'images/$key.txt', library));
	}
}
