package com.example.daoyun.fragment

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView.OnItemClickListener
import android.widget.ArrayAdapter
import android.widget.ListView
import android.widget.ProgressBar
import android.widget.Toast
import androidx.fragment.app.Fragment
import com.example.daoyun.*
import com.example.daoyun.adapter.CourseAdapter
import com.example.daoyun.adapter.CoursesAdapter
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import okhttp3.*
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.RequestBody.Companion.toRequestBody
import org.json.JSONObject
import java.util.*
import kotlin.collections.ArrayList
import kotlin.concurrent.thread

// TODO: Rename parameter arguments, choose names that match
// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
private const val ARG_PARAM1 = "param1"
private const val ARG_PARAM2 = "param2"

/**
 * A simple [Fragment] subclass.
 * Use the [MyCreateFragment.newInstance] factory method to
 * create an instance of this fragment.
 */
class MyCreateFragment : Fragment() {
    private var courseList: MutableList <Course> = ArrayList<Course>()
    private val myJoinNum = 0
    //var adapter: CourseAdapter? = null
    var listView: ListView? = null
    var progressDialog: ProgressBar? = null
    private lateinit var jwtToken:String
    private lateinit var retmsg:String
    private var param1: String? = null
    private var param2: String? = null
    private var debugmsg:String?=null
    private lateinit var anytst:Any

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {
            param1 = it.getString(ARG_PARAM1)
            param2 = it.getString(ARG_PARAM2)
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_my_create, container, false)
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        progressDialog = ProgressBar(context)
        val userData= activity?.getSharedPreferences("userData", Context.MODE_PRIVATE)
        jwtToken= userData?.getString("jwtToken", "error").toString()

        getCourses()
        //Toast.makeText(activity,"1debugmsg\n$debugmsg",Toast.LENGTH_SHORT).show()
        val st=ArrayList<Student>()
        st.add(Student("htq","htq","czb",1))
        val tk=ArrayList<Task>()
        val checkins=ArrayList<Checkin>()
        val cs=Course(1,"工程实践","1", Teacher("czb","czb"),st,tk,checkins)
        courseList.add(cs)
        Toast.makeText(activity,"cl.size=$cs",Toast.LENGTH_SHORT).show()
        val adapter = CoursesAdapter(context!!, R.layout.course_item, courseList)
        listView = activity!!.findViewById(R.id.list_view1)
        listView?.adapter = adapter
        listView?.onItemClickListener = OnItemClickListener { _, _, position, _ ->
            val course = courseList[position]
            val intent = Intent(context, ClassTabActivity::class.java)
            intent.putExtra("courseName", course.courseName)
            intent.putExtra("classId", course.courseExId)
            intent.putExtra("enterType", "create")
            startActivity(intent)

        }
    }

    private fun initCourses(){
        val userData = activity?.getSharedPreferences("userData", Context.MODE_PRIVATE)
        val className= userData?.getString("class","error").toString()
        val gradeClass= userData?.getString("grade","error").toString()
        val classId= userData?.getString("courseExId","error").toString()
        //val course = Course(R.drawable.course_img_1, className, "", gradeClass, classId)
        //courseList.add(course)
    }

    private fun getCourses(){
        thread {
            try {
                val url = HttpUrl.Builder()
                    .scheme("https")
                    .host("gcsj.lidotcircle.ltd")
                    .addPathSegment("apis")
                    .addPathSegment("course")
                    .addPathSegment("page")
                    .addQueryParameter("role", "teacher")
                    .build()
                val client= OkHttpClient()
                val request= Request.Builder()
                    .url(url)
                    .header("Authorization",jwtToken)
                    .get()
                    .build()
                val response=client.newCall(request).execute()
                val responseData=response.body?.string()
                debugmsg=responseData.toString()
                anytst=JSONObject(responseData)?.getJSONArray("pairs")

                parseJSONWithGSON(anytst.toString())
            }catch (e: Exception){
                Log.e("TAG", Log.getStackTraceString(e))
            }
        }.join()
    }

    private fun parseJSONWithGSON(jsonData:String){
        val gson= Gson()
        val typeOf=object: TypeToken<List<Course>>() {}.type
        val csList=gson.fromJson<MutableList<Course>>(jsonData,typeOf)
        courseList=csList
    }

    override fun onResume() {
        super.onResume()
        initCourses()
    }

    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment MyCreateFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance(param1: String, param2: String) =
            MyCreateFragment().apply {
                arguments = Bundle().apply {
                    putString(ARG_PARAM1, param1)
                    putString(ARG_PARAM2, param2)
                }
            }
    }
}