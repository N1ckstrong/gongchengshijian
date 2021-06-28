package com.example.daoyun.adapter

import android.app.Activity
import android.content.Context
import android.text.Layout
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import android.widget.ImageView
import android.widget.TextView
import com.example.daoyun.Course
import com.example.daoyun.R

class CoursesAdapter(activity: Context, val resourceId:Int, data:List<Course>):ArrayAdapter<Course>(activity,resourceId,data) {
    override fun getView(position: Int, convertView: View?, parent: ViewGroup): View {
        val view=LayoutInflater.from(context).inflate(resourceId,parent,false)

        //val courseImage:ImageView = view.findViewById(R.id.course_image)
        val courseName: TextView = view.findViewById(R.id.course_name)
        val teacherName: TextView = view.findViewById(R.id.teacher_name)
        val className:TextView = view.findViewById(R.id.class_name)
        val signInImg:ImageView = view.findViewById(R.id.signIn_Iv)
        val signInTv:TextView = view.findViewById(R.id.signIn_Tv)
        val course=getItem(position)
        if(course!=null){
            //courseImage.setImageResource(course.imageId)
            courseName.text=course.courseName
            teacherName.text=course.teacher.name
            className.text=course.className
        }
        return view
    }
}