package loi.helpscout.flutter_help_scout

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

import com.helpscout.beacon.Beacon;
import com.helpscout.beacon.model.BeaconScreens;
import com.helpscout.beacon.ui.BeaconActivity;
import com.helpscout.beacon.ui.BeaconEventLifecycleHandler;
import com.helpscout.beacon.ui.BeaconOnClosedListener;
import com.helpscout.beacon.ui.BeaconOnOpenedListener;

import java.util.Map;

class FlutterHelpScoutPlugin(private var registrar: Registrar): MethodCallHandler {
  private 
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_help_scout")
      channel.setMethodCallHandler(FlutterHelpScoutPlugin(registrar))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "init") {
      var id = call.argument<String>("id")
      if(id == null) {
        result.error("4220","Beacon id is required",null)
      }
      

      Beacon.Builder()
                .withBeaconId(id!!)
                .withLogsEnabled(true)
                .build()  

      result.success("Beacon init successfully: " + id!!)
    } else if(call.method == "open") {
      BeaconActivity.open(this.registrar.activity())
      print("Open settings susccess")
      result.success("Open settings susccess");
    } else if(call.method == "identify") {
      var email = call.argument<String>("email")
      if(email == null) {
        result.error("4220","Email is required",null)
      }

      var name = call.argument<String>("name")
      if(name == null) {
        result.error("4220","Name is required",null)
      }

      var attributes = call.argument<HashMap<String,String>>("attributes")
      
      if(attributes != null) {
        for(key in attributes!!.keys) {
          if(key == "name" || key == "value") continue;
          var value = attributes!!.get(key)
          Beacon.addAttributeWithKey(key,value!!);
        }
      }

      Beacon.login(email!!, name!!);
      result.success("Login susccess: email = ${email}, name =${name}")
    } else if(call.method == "logout"){
      Beacon.clear();
      Beacon.logout();
      result.success("Logout susccess")
    } else {
      result.notImplemented()
    }
  }
}
