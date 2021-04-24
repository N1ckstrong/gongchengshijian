package six.daoyun.service;

import java.util.Optional;

import org.springframework.data.domain.Page;

import six.daoyun.entity.Course;
import six.daoyun.entity.User;

public interface CourseService {
    String createCourse(Course course);
    void updateCourse(Course course);
    void deleteCourse(String courseExId);

    void joinIntoCourse(Course course, User student);
    void exitCourse(Course course, User student);
    boolean courseHasStudent(Course course, User student);
    boolean isMemberOfCourse(Course course, User user);
    boolean isMemberOfCourse(String courseExId, User user);

    Optional<Course> getCourse(String courseExId);

    Page<Course> getCoursePage(int pageno, int size, String sortKey, boolean desc, String filter);
    Page<Course> getTeacherCoursePage(User teacher, int pageno, int size, String sortKey, boolean desc, String filter);
    Page<Course> getCourseStudentPage(User student, int pageno, int size, String sortKey, boolean desc, String filter);
}

