import { ViewportScroller } from '@angular/common';
import { Component, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { NbToastrService, NbWindowService } from '@nebular/theme';
import { Observable, Subject, from, of } from 'rxjs';
import { concatMap, map, takeUntil, tap } from 'rxjs/operators';
import { Course } from 'src/app/entity';
import { CourseCheckin, CourseInfo, CourseTask, Student } from 'src/app/entity/Course';
import { CourseCheckinService } from 'src/app/service/course/course-check-in.service';
import { CourseTaskService } from 'src/app/service/course/course-task.service';
import { CourseService } from 'src/app/service/course/course.service';
import { ObjectTransferService } from 'src/app/service/object-transfer.service';
import { ConfirmWindowComponent } from 'src/app/shared/components/confirm-window.component';
import { httpErrorHandler, sortObject } from 'src/app/shared/utils';
import { BasicInfoEditorComponent } from './basic-info-editor.component';
import { CourseCheckinEditorComponent } from './course-checkin-editor.component';
import { CourseInfoViewComponent } from './course-info-viewer.component';
import { CourseTaskEditorComponent } from './course-task-editor.component';
import { CourseTaskViewComponent } from './course-task-viewer.component';
import { JustInputComponent } from './just-input.component';

@Component({
    selector: 'ngx-course-info',
    templateUrl: './course-info.component.html',
    styleUrls: ['./course-info.component.scss']
})
export class CourseInfoComponent implements OnInit, OnDestroy {
    private $destroy = new Subject<void>();
    course: Course;
    students: Student[] = [];
    tasks: CourseTask[] = [];
    infos: CourseInfo[] = [];
    checkins: CourseCheckin[] = [];
    issuper: boolean = false;
    private studentsFilter: string = '';
    private tasksFilter: string = '';
    private infosFilter: string = '';
    private checkinsFilter: string = '';
    private runStudentsFilter() {
        this.students = this.course.Students
            .sort(sortObject([{prop: 'studentTeacherId'}, {prop: 'name'}, {prop: 'userName'}]))
            .filter(student => {
                return this.studentsFilter.trim().length == 0 ||
                    student.userName.match(this.studentsFilter) ||
                    (student.studentTeacherId && student.studentTeacherId.match(this.studentsFilter)) ||
                    (student.name && student.name.match(this.studentsFilter));
            });
    }
    private runTasksFilter() {
        this.tasks = this.course.Tasks.filter(task => {
            return this.tasksFilter.trim().length == 0 ||
                task.taskTitle.match(this.tasksFilter);
        });
    }
    private runInfosFilter() {
        this.infos = this.course.Infos.filter(info => {
            return this.infosFilter.trim().length == 0 ||
                info.taskTitle.match(this.infosFilter);
        });
    }
    private runCheckinsFilter() {
        this.checkins = this.course.CheckinList.filter(checkins => {
            return this.checkinsFilter.trim().length == 0 ||
                checkins.deadline.toISOString().match(this.checkinsFilter);
        });
    }
    onStudentsEnter(input: string) {
        this.studentsFilter = input;
        this.runStudentsFilter();
    }
    onTasksEnter(input: string) {
        this.tasksFilter = input;
        this.runTasksFilter();
    }
    onInfosEnter(input: string) {
        this.infosFilter = input;
        this.runInfosFilter();
    }
    onCheckinsEnter(input: string) {
        this.checkinsFilter = input;
        this.runCheckinsFilter();
    }

    private async refreshCourseFrom(courseExId: string) //{
    {
        return await of(courseExId)
            .pipe(concatMap(courseExId => this.courseService.get(courseExId)))
            .pipe(tap(course => {
                this.course = course;
                this.runInfosFilter();
                this.runTasksFilter();
                this.runStudentsFilter();
                this.runCheckinsFilter();
            })).toPromise();
    } //}

    constructor(private courseService: CourseService,
                private courseTaskService: CourseTaskService,
                private objectTransferService: ObjectTransferService,
                private courseCheckinService: CourseCheckinService,
                private windowService: NbWindowService,
                private toastrService: NbToastrService,
                private viewportScroller: ViewportScroller,
                private router: Router,
                private activatedRoute: ActivatedRoute) {
        this.course = new Course();

        this.activatedRoute.queryParamMap
            .pipe(map(params => params.get('courseExId')))
            .subscribe(courseExId => this.refreshCourseFrom(courseExId));
    }

    ngOnDestroy(): void {
        this.$destroy.next();
        this.$destroy.complete();
    }

    ngOnInit(): void {
        this.courseService.getSuperme()
            .subscribe(s => this.issuper = s);
    }

    async editBasic() //{
    {
        const win = this.windowService.open(BasicInfoEditorComponent, {
            title: '??????????????????',
            context: {
                courseName: this.course.courseName,
                briefDescription: this.course.briefDescription,
            }
        });
        await win.onClose.toPromise();

        if(win.config.context['isConfirmed']) {
            const { courseName, briefDescription } = win.config.context as any;

            try {
                const req = {
                    courseExId: this.course.courseExId,
                };
                if(courseName) req['courseName'] = courseName;
                req['briefDescription'] = briefDescription || ' ';
                await this.courseService.put(req);
                this.course.courseName = courseName;
                this.course.briefDescription = briefDescription;
                this.toastrService.info('????????????', '????????????');
            } catch (err) {
                httpErrorHandler(err, '????????????', '????????????');
            }
        }
    } //}

    async addStudent() //{
    {
        const win = this.windowService.open(JustInputComponent, {
            title: '????????????',
            context: {
                type: 'text',
                pattern: '.{2,}',
                name: '???????????????',
            }
        });
        await win.onClose.toPromise();

        if(win.config.context['isConfirmed']) {
            const { value } = win.config.context as any;

            try {
                await this.courseService.invite(this.course.courseExId, value);
                await this.refreshCourseFrom(this.course.courseExId);
                this.toastrService.info('????????????: ' + value, '????????????');
            } catch (err) {
                httpErrorHandler(err, '????????????', '????????????');
            }
        }
    } //}
    async deleteStudent(n: number) //{
    {
        const student = this.students[n];
        const win = this.windowService.open(ConfirmWindowComponent, {
            title: `?????? ${student.name || student.userName}`,
            context: {}
        });
        await win.onClose.toPromise();

        if(win.config.context['isConfirmed']) {
            try {
                await this.courseService.deleteStudent(this.course.courseExId, student.userName);
                await this.refreshCourseFrom(this.course.courseExId);
            } catch (err) {
                httpErrorHandler(err, '????????????', '???????????? ');
            }
        }
    } //}

    async assignTask() //{
    {
        const win = this.windowService.open(CourseTaskEditorComponent, {
            title: '??????????????????',
            context: {
                committable: true,
            }
        });
        await win.onClose.toPromise();

        if(win.config.context['isConfirmed']) {
            const task: CourseTask = win.config.context['courseTask'];
            task.courseExId = this.course.courseExId;
            try {
                await this.courseTaskService.postTask(task);
                await this.refreshCourseFrom(this.course.courseExId);
            } catch (err) {
                httpErrorHandler(err, "????????????", "??????????????????");
            }
        }
    } //}

    async startCheckin() //{
    {
        const win = this.windowService.open(CourseCheckinEditorComponent, {
            title: '????????????',
            context: {
                committable: false,
            }
        });
        await win.onClose.toPromise();

        if(win.config.context['isConfirmed']) {
            const checkin: CourseCheckin = win.config.context['checkin'];
            checkin.courseExId = this.course.courseExId;
            try {
                await this.courseCheckinService.postCheckin(checkin);
                await this.refreshCourseFrom(this.course.courseExId);
            } catch (err) {
                httpErrorHandler(err, "????????????", "??????????????????");
            }
        }
    } //}

    async startInfo() //{
    {
        const win = this.windowService.open(CourseTaskEditorComponent, {
            title: '??????????????????',
            context: {
                committable: false,
            }
        });
        await win.onClose.toPromise();

        if(win.config.context['isConfirmed']) {
            const info: CourseInfo = win.config.context['courseTask'];
            info.courseExId = this.course.courseExId;
            try {
                await this.courseTaskService.postInfo(info);
                await this.refreshCourseFrom(this.course.courseExId);
            } catch (err) {
                httpErrorHandler(err, "????????????", "????????????????????????");
            }
        }

    } //}

    async viewTask(n: number) {
        const task: CourseTask = this.tasks[n];
        const win = this.windowService.open(CourseTaskViewComponent, {
            title: '????????????',
            context: {
                courseTask: task,
            }
        });
        await win.onClose.toPromise();

        if(win.config.context['delete']) {
            try {
                await this.courseTaskService.deleteTask(task.taskId);
                await this.refreshCourseFrom(this.course.courseExId);
            } catch (err) {
                httpErrorHandler(err, "????????????", "??????????????????");
            }
        }
    }

    async viewInfo(n: number) //{
    {
        const info: CourseInfo = this.infos[n];
        const win = this.windowService.open(CourseInfoViewComponent, {
            title: '????????????',
            context: {
                courseInfo: info,
            }
        });
        await win.onClose.toPromise();

        if(win.config.context['delete']) {
            try {
                await this.courseTaskService.deleteTask(info.taskId);
                await this.refreshCourseFrom(this.course.courseExId);
            } catch (err) {
                httpErrorHandler(err, "????????????", "??????????????????");
            }
        }
    } //}

    async viewCheckin(n: number) {
        const o = this.objectTransferService.store(this.course);
        const i = this.course.checkins[n].checkinId;

        this.router.navigate(['../checkin-info'], {
            relativeTo: this.activatedRoute,
            queryParams: {
                checkinId: `${i}`,
                courseExId: this.course.courseExId,
            }
        });
    }

    async deleteCourse() {
        const win = this.windowService.open(ConfirmWindowComponent, {
            title: `????????????`,
            context: {}
        });
        await win.onClose.toPromise();

        if(win.config.context['isConfirmed']) {
            try {
                await this.courseService.delete(this.course.courseExId);
                this.toastrService.success("??????????????????", "????????????");
                this.router.navigate(["../course-list"], {
                    relativeTo: this.activatedRoute,
                    queryParams: {},
                });
            } catch (err) {
                httpErrorHandler(err, '????????????', '???????????? ');
            }
        }
    }

    gotoStudentList() { this.viewportScroller.scrollToAnchor('student-list'); }
    gotoTaskList()    { this.viewportScroller.scrollToAnchor('task-list'); }
    gotoInfoList()    { this.viewportScroller.scrollToAnchor('info-list'); }
    gotoCheckinList() { this.viewportScroller.scrollToAnchor('check-in-list'); }
}

