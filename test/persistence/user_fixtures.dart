import 'package:objectbox/objectbox.dart';
import 'package:vit_ap_student_app/core/models/attendance.dart';
import 'package:vit_ap_student_app/core/models/capstone_attendance.dart';
import 'package:vit_ap_student_app/core/models/exam_schedule.dart';
import 'package:vit_ap_student_app/core/models/grade_history.dart';
import 'package:vit_ap_student_app/core/models/mark.dart';
import 'package:vit_ap_student_app/core/models/mentor_details.dart';
import 'package:vit_ap_student_app/core/models/profile.dart';
import 'package:vit_ap_student_app/core/models/timetable.dart';
import 'package:vit_ap_student_app/core/models/user.dart';

/// A user with every relation populated, the way one arrives from a login.
///
/// Everything has a null id: that is what "parsed from VTOP, never stored"
/// looks like, and it is the difference the save path keys off.
User fullUser({int? id, String studentName = 'A Student'}) => User(
  id: id,
  profile: ToOne<Profile>(target: profile(studentName)),
  attendance: ToMany<Attendance>(
    items: [attendance('CSE1008'), attendance('CSE4004')],
  ),
  timetable: ToOne<Timetable>(target: timetable()),
  examSchedule: ToMany<ExamSchedule>(items: [examSchedule()]),
  marks: ToMany<Mark>(items: [mark()]),
  capstoneAttendance: ToOne<CapstoneAttendance>(target: capstone()),
);

Attendance attendance(String courseCode) => Attendance(
  classNumber: 'AP2026',
  faculty: 'Someone',
  courseId: 'AM_$courseCode',
  courseCode: courseCode,
  courseName: 'A course',
  courseType: 'Theory Only',
  courseTypeCode: 'TH',
  courseSlot: 'A1',
  attendedClasses: '10',
  totalClasses: '10',
  attendancePercentage: '100',
  betweenAttendancePercentage: '100',
  debarStatus: '',
);

Mark mark({String title = 'CAT1'}) => Mark(
  courseCode: 'CSE1008',
  courseTitle: 'Theory of Computation',
  courseType: 'Theory Only',
  serialNumber: '1',
  faculty: 'Someone',
  slot: 'A1',
  gradeCourseId: 'AM_CSE1008',
  details: ToMany<Detail>(items: [detail(title), detail('${title}b')]),
);

Detail detail(String title) => Detail(
  serialNumber: '1',
  markTitle: title,
  maxMark: '50',
  weightage: '15',
  status: 'Present',
  scoredMark: '40',
  weightageMark: '12',
  remark: '',
);

ExamSchedule examSchedule() =>
    ExamSchedule(ToMany<Subject>(items: [subject()]), examType: 'CAT - I');

Subject subject() => Subject(
  serialNumber: '1',
  courseCode: 'CSE1008',
  courseTitle: 'Theory of Computation',
  type: 'Theory Only',
  courseId: 'AM_CSE1008',
  slot: 'A1',
  date: '2026-08-14',
  session: 'FN',
  reportingTime: '09:00',
  examTime: '09:30',
  venue: 'AB1',
  seatLocation: '1',
  seatNumber: '1',
);

Profile profile(String studentName) => Profile(
  applicationNumber: '1',
  studentName: studentName,
  dob: '2005-01-01',
  gender: 'Male',
  bloodGroup: 'O+',
  email: 'student@example.com',
  base64Pfp: '',
  gradeHistory: ToOne<GradeHistory>(target: gradeHistory()),
  mentorDetails: ToOne<MentorDetails>(target: mentorDetails()),
);

GradeHistory gradeHistory() => GradeHistory(
  creditsRegistered: '20',
  creditsEarned: '20',
  cgpa: '9.0',
  courses: ToMany<Course>(items: [course()]),
);

Course course() => Course(
  courseCode: 'CSE1008',
  courseTitle: 'Theory of Computation',
  courseType: 'Theory Only',
  credits: '4',
  grade: 'S',
  examMonth: 'AUG 2026',
  courseDistribution: 'PC',
);

MentorDetails mentorDetails() => MentorDetails(
  facultyId: '1',
  facultyName: 'A Mentor',
  facultyDesignation: 'Professor',
  school: 'SCOPE',
  cabin: 'AB1',
  facultyDepartment: 'CSE',
  facultyEmail: 'mentor@example.com',
  facultyIntercom: '1',
  facultyMobileNumber: '1',
);

Timetable timetable() => Timetable(
  monday: ToMany<Day>(items: [day()]),
  tuesday: ToMany<Day>(items: []),
  wednesday: ToMany<Day>(items: []),
  thursday: ToMany<Day>(items: []),
  friday: ToMany<Day>(items: []),
  saturday: ToMany<Day>(items: []),
  sunday: ToMany<Day>(items: []),
);

Day day() => Day(
  startTime: '09:00',
  endTime: '09:50',
  courseCode: 'CSE1008',
  courseName: 'Theory of Computation',
  courseType: 'Theory Only',
  slot: 'A1',
  venue: 'AB1',
  faculty: 'Someone',
);

CapstoneAttendance capstone() => CapstoneAttendance(
  title: 'Capstone',
  guideEvaluationStatus: 'Registered',
  dateOfRegistration: '2026-07-06 00:00:00.0',
  present: '14',
  onDuty: '4',
  absent: '12',
  percentage: '60',
  punches: ToMany<CapstonePunch>(items: [punch('17'), punch('18')]),
);

CapstonePunch punch(String day) => CapstonePunch(
  serial: day,
  date: '$day-07-2026',
  day: 'FRIDAY',
  dayType: 'Instructional',
  status: 'Absent',
  punchTime: '',
);
