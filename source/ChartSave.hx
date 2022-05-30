package;

#if android
import android.AndroidTools;
import android.stuff.Permissions;
#end
import lime.app.Application;
import openfl.events.UncaughtErrorEvent;
import openfl.utils.Assets as OpenFlAssets;
import openfl.Lib;
import haxe.CallStack.StackItem;
import haxe.CallStack;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;
import flash.system.System;

/**
 * author: Saw (M.A. Jigsaw)
 * edited for KE 1.5.4 Leer, by Poyo
 */

using StringTools;

class ChartSave {
	#if android
	private static var grantedPermsList:Array<Permissions> = AndroidTools.getGrantedPermissions(); 
	private static var aDir:String = null; // android dir 
	public static var sPath:String = AndroidTools.getExternalStorageDirectory(); // storage dir
	#end

  public function getPath():String {
		#if android
		if (aDir != null && aDir.length > 0) {
			return aDir;
		} else {
			aDir = sPath + "/" + "FNFCharts" + "/";
		}
		return aDir;
		#else
		return "";
		#end
	}
	#if android
  public function doTheCheck() {

		#if android

		if (!grantedPermsList.contains(Permissions.READ_EXTERNAL_STORAGE) || !grantedPermsList.contains(Permissions.WRITE_EXTERNAL_STORAGE)) {
			if (AndroidTools.sdkVersion > 23 || AndroidTools.sdkVersion == 23) {
				AndroidTools.requestPermissions([Permissions.READ_EXTERNAL_STORAGE, Permissions.WRITE_EXTERNAL_STORAGE]);
			}
		}

		if (!grantedPermsList.contains(Permissions.READ_EXTERNAL_STORAGE) || !grantedPermsList.contains(Permissions.WRITE_EXTERNAL_STORAGE)) {
			if (AndroidTools.sdkVersion > 23 || AndroidTools.sdkVersion == 23) {
				SUtil.applicationAlert("Chart Saving Enabled", "Thanks for granting the permissions, you can now save charts." 
					+ "\n" + "Press OK to continue");
			} else {
				SUtil.applicationAlert("Chart Saving Disabled", "It seems you didnt grant the permissions. Any chart you make cannot be saved" 
					+ "\n" + "Press OK to continue");
			}
		}
		}
		#end
  public function saveContent(fileName:String = "file", fileExtension:String = ".json", fileData:String = "you forgot something to add in your code"){
		if (!FileSystem.exists(SUtil.getPath())){
			FileSystem.createDirectory(SUtil.getPath());
		}

		File.saveContent(SUtil.getPath() + fileName + fileExtension, fileData);
		SUtil.applicationAlert("Done!", "Find your chart in FNFCharts on storage/emulated/0");
	}
	#end
}
