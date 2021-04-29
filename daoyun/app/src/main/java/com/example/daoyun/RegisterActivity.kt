package com.example.daoyun

import android.content.DialogInterface
import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import com.example.daoyun.databinding.ActivityRegisterBinding
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.toRequestBody
import org.json.JSONObject
import java.util.regex.Pattern
import kotlin.concurrent.thread

class RegisterActivity : AppCompatActivity() {

    private lateinit var binding: ActivityRegisterBinding
    private lateinit var messageCode:String

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding= ActivityRegisterBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ActivityCollector.addActivity(this)

        //验证码
        binding.btVeriSubmit.setOnClickListener {
            if(!isChinaPhoneLegal(binding.etLoginUsername.text.toString())){
                AlertDialog.Builder(this)
                    .setMessage("请输入正确的手机号码！")
                    .setPositiveButton("确定", null)
                    .show()
            }
            else{
                sendMsg()
                AlertDialog.Builder(this)
                    .setTitle("验证码已发送")
                    .setPositiveButton("确定", null)
                    .show()
                binding.btVeriSubmit.text = "已发送"
                binding.btVeriSubmit.isEnabled=false
            }
        }
        //注册
        binding.btLoginSubmit.setOnClickListener {
//            if (binding.etRegVericode.text.toString() != "$randoms") {
//                val builder = AlertDialog.Builder(this)
//                    .setMessage("验证码错误！")
//                    .setPositiveButton("确定", null)
//                    .show()
//                binding.btVeriSubmit.text = "发送验证码"
//                binding.btVeriSubmit.isEnabled = true
//            }
            if (binding.etLoginPwd.text.toString() != binding.etRegConfPwd.text.toString()) {
                val builder = AlertDialog.Builder(this)
                    .setMessage("两次密码输入不一致！")
                    .setPositiveButton("确定", null)
                    .show()
            } else if (binding.etLoginPwd.text.toString().length < 6) {
                val builder = AlertDialog.Builder(this)
                    .setMessage("密码最低为6位！")
                    .setPositiveButton("确定", null)
                    .show()
            }
            else if(!isChinaPhoneLegal(binding.etLoginUsername.text.toString())){
                val builder = AlertDialog.Builder(this)
                    .setMessage("请输入正确的手机号码！")
                    .setPositiveButton("确定", null)
                    .show()
            }
            else{
                quickLogin(binding.registerUsername.text.toString(),binding.etLoginUsername.text.toString(),binding.etRegVericode.text.toString(),binding.etLoginPwd.text.toString(),messageCode)
                showAlertDialog("注册成功！")
            }
        }
    }

    private fun sendMsg(){
        thread {
            try {
                val json = JSONObject()
                    .put("phone", binding.etLoginUsername.text.toString())
                    .put("type", "signup")
                    .put("captcha", " ")
                val stringBody =json.toString().toRequestBody("application/json;charset=utf-8".toMediaType())
                val client=OkHttpClient()
                val request=Request.Builder()
                    .url("https://gcsj.lidotcircle.ltd/apis/message")
                    .post(stringBody)
                    .build()
                val response=client.newCall(request).execute()
                val responseData=response.body?.string()
                messageCode=JSONObject(responseData).getString("codeToken")
                showResponse(responseData.toString())
            }catch (e: Exception){
                Log.e("TAG", Log.getStackTraceString(e));
            }
        }
    }

    private fun quickLogin(user:String,phone: String, umessage: String,password:String, msgToken: String){
        thread {
            try {
                val json = JSONObject()
                    .put("userName", user)
                    .put("password", password)
                    .put("phone", phone)
                    .put("messageCode",umessage)
                    .put("messageCodeToken",msgToken)
                val stringBody =json.toString().toRequestBody("application/json;charset=utf-8".toMediaType())
                val client=OkHttpClient()
                val request=Request.Builder()
                    .url("https://gcsj.lidotcircle.ltd/apis/auth/user")
                    .post(stringBody)
                    .build()
                val response=client.newCall(request).execute()
                val responseData=response.body?.string()

                showResponse(responseData.toString())
            }catch (e: Exception){
                Log.e("TAG", Log.getStackTraceString(e));
            }
        }
    }

    private fun showResponse(response: String) {
        runOnUiThread {
            // 在这里进行UI操作，将结果显示到界面上
            binding.responseText.text = response
        }
    }

    private fun isChinaPhoneLegal(str: String): Boolean {
        // ^ 匹配输入字符串开始的位置
        // \d 匹配一个或多个数字，其中 \ 要转义，所以是 \\d
        // $ 匹配输入字符串结尾的位置
        val regExp = "^((13[0-9])|(14[5,7,9])|(15[0-3,5-9])|(166)|(17[3,5,6,7,8])" +"|(18[0-9])|(19[8,9]))\\d{8}$"
        val p = Pattern.compile(regExp)
        val m = p.matcher(str)
        return m.matches()
    }

    private fun showAlertDialog(msg: String){

        val builder = AlertDialog.Builder(this)
            .setMessage(msg)
        if (msg == "注册成功！") {
            builder.setPositiveButton("确定",
                DialogInterface.OnClickListener { _, _ ->
                    startActivity(
                        Intent(
                            this,
                            LoginActivity::class.java
                        )
                    )
                })
        }
        else {
            builder.setPositiveButton("确定", null)
        }
        builder.show()
    }

    override fun onDestroy() {
        super.onDestroy()
        ActivityCollector.removeActivity(this)
    }
}