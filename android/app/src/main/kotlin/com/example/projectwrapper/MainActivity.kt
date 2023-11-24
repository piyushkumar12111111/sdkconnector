package com.example.projectwrapper

import io.flutter.embedding.android.FlutterActivity
import com.mollatech.sonicsdkv2.SDKConnector;
import com.mollatech.sonicsdkv2.SdkResponse;
import android.app.Activity
import io.flutter.embedding.engine.FlutterEngine
import org.json.JSONObject
import io.flutter.plugin.common.JSONMethodCodec
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {

    private val SDKChannel = "SDKChannel"
    private lateinit var activity: Activity

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        activity = this
        createChannelForJson(flutterEngine)
       // val connector = SDKConnector(activity)

    }

     private fun createChannelForJson(flutterEngine: FlutterEngine) {
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            SDKChannel,
            JSONMethodCodec.INSTANCE
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "init" -> {
                    try {
                        val data = call.arguments as JSONObject
                        val serverBaseUrl = data.getString("serverBaseUrl")
                        val accountId = data.getString("accountId")
                        val appId = data.getString("appId")
                        val userId = data.getString("userId")
                        val userName = data.getString("userName")
                        val emailId = data.getString("emailId")
                        val phoneNumber = data.getString("phoneNumber")
                        val applicationNumber = data.getString("applicationNumber")
                        val branchId = data.getString("branchId")
                        

                        if (serverBaseUrl == null || accountId == null || appId == null || userId == null || userName == null || emailId == null || phoneNumber == null || applicationNumber == null || branchId == null ) {
                            result.error("ERROR", "arguments can not be null", null)
                            return@setMethodCallHandler
                        }

                        val connector = SDKConnector(activity)
                       connector.init(serverBaseUrl,accountId,appId,userId,userName,emailId,phoneNumber,applicationNumber,branchId) { i, s, jsonObject ->
                           val je = JSONObject().apply {
                               put("resultCode", i)
                               put("resultMessage", s)
                               put("resultData", jsonObject)
                           }
                           result.success(je)
                       }
                    } catch (e: Exception) {
                        result.error("ERROR", e.message, null)
                    }

                    return@setMethodCallHandler
                }

                "getBranchs" -> {
                    try {
                        val data = call.arguments as JSONObject
                        val serverBaseUrl = data.getString("serverBaseUrl")
                        val accountId = data.getString("accountId")

                        if (accountId == null || serverBaseUrl == null) {
                            result.error("ERROR", "arguments can not be null", null)
                            return@setMethodCallHandler
                        }
                        

                        val connector = SDKConnector(activity)
                        connector.getBranch(serverBaseUrl,accountId) { i, s, jsonObject ->
                            val je = JSONObject().apply {
                                put("resultCode", i)
                                put("resultMessage", s)
                                put("resultData", jsonObject)
                            }
                            result.success(je)
                        }
                    } catch (e: Exception) {
                        result.error("ERROR", e.message, null)
                    }

                    return@setMethodCallHandler
                }

                "setLanguage" -> {
                    try {
                        val data = call.arguments as JSONObject
                        val languageCode = data.getString("languageCode")
                        

                        if (languageCode == null ) {
                            result.error("ERROR", "arguments can not be null", null)
                            return@setMethodCallHandler
                        }
                        

                        val connector = SDKConnector(activity)
                        connector.setLanguage(languageCode) { i, s, jsonObject ->
                            val je = JSONObject().apply {
                                put("resultCode", i)
                                put("resultMessage", s)
                                put("resultData", jsonObject)
                            }
                            result.success(je)
                        }
                    } catch (e: Exception) {
                        result.error("ERROR", e.message, null)
                    }

                    return@setMethodCallHandler
                }

                // "initDeepLink" -> {
                //     try {
                //         val data = call.arguments as JSONObject
                //         val ip = data.getString("ip")
                //         val port = data.getString("port")
                //         val isSecure = data.getString("isSecure")
                //         val applicationNumber = data.getString("applicationNumber")

                //         if (ip == null || port == null || isSecure == null || applicationNumber == null  ) {
                //             result.error("ERROR", "arguments can not be null", null)
                //             return@setMethodCallHandler
                //         }
                        

                //         val connector = SDKConnector(activity)
                //         connector.initDeepLink(ip,port,isSecure,applicationNumber) { i, s, jsonObject ->
                //             val je = JSONObject().apply {
                //                 put("resultCode", i)
                //                 put("resultMessage", s)
                //                 put("resultData", jsonObject)
                //             }
                //             result.success(je)
                //         }
                //     } catch (e: Exception) {
                //         result.error("ERROR", e.message, null)
                //     }

                //     return@setMethodCallHandler
                // }

                "start" -> {
                    try {
                        val data = call.arguments as JSONObject
                       
                        val connector = SDKConnector(activity)
                        connector.start() { i, s, jsonObject ->
                            val je = JSONObject().apply {
                                put("resultCode", i)
                                put("resultMessage", s)
                                put("resultData", jsonObject)
                            }
                            result.success(je)
                        }
                    } catch (e: Exception) {
                        result.error("ERROR", e.message, null)
                    }

                    return@setMethodCallHandler
                }

                //! more cases can be added here 
                // Add more cases for other method calls as needed
                else -> result.notImplemented()
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
    }

}

