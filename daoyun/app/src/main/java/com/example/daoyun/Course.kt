package com.example.daoyun

import android.widget.Toast
import java.util.*

class Course(val courseExId: Long, val courseName: String, val briefDescription: String, val teacher: Teacher, val students: List<Student>, val tasks:List<Task>,val checkins:List<Checkin>){
    val imageId = -1
    val imgFilePath = ""
    val className: String? = null


}

class Checkin {

}

class Task(val id: Int,val releasedate: Date,val committable: Boolean, taskTilte: String, content: String)

class Student(val userName: String,val name: String,val studentTeacherId: String,val score: Int)

class Teacher(val userName:String,val name:String)
