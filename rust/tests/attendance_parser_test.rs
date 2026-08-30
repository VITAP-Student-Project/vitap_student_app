use std::assert_eq;

use lib_vtop::api::vtop::parser::attendance_parser::{
    parse_cap_or_sdp_attendance, parse_attendance
};

#[test]
fn test_parse_cap_or_sdp_attendance() {
    // Test case for parsing CAP or SDP attendance
    let html = r#"<div id="sdpAttendanceFragment">
    <div class="modal" id="sdpAttendanceModal">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" style="max-width: 70%;">
            <div class="modal-content">
                <!-- Header -->
                <div class="modal-header">
                    <h4 class="modal-title" style="font-weight: bold; text-decoration: underline;">
                        CAPSTONE/SDP Attendance Detail
                    </h4>
                </div>
                
                <!-- SDP Info Section -->
                <!-- <div class="modal-body">
                    <table class="table table-bordered">
                        <tr>
                            <th style="width: 25%;">Title</th>
                            <td style="width: 75%;" th:text="${title}"></td>
                        </tr>
                        <tr>
                            <th>Guide Evaluation Status</th>
                            <td>
                                <span th:if="${status == 0}" class="badge bg-danger">Rejected</span>
                                <span th:if="${status == 1}" class="badge bg-success">Approved</span>
                                <span th:if="${status == 2}" class="badge bg-warning text-dark">Pending</span>
                            </td>
                        </tr>
                        <tr>
                            <th>Date of Registration</th>
                            <td th:text="${dateOfRegistered}"></td>
                        </tr>
                    </table>
                </div> -->
                <div class="modal-body">
											<table class="table table-bordered">
												<tr>
													<th style="width: 25%;">Title</th>
													<td style="width: 75%;">Capstone</td>
												</tr>
												<tr>
													<th>Guide Evaluation Status</th>
													<td><span>Registered, Invoice Generated, Approved by Academics and Faculty</span></td>
												</tr>
												<tr>
													<th>Date of Registration</th>
													<td>2026-09-04 00:00:00.0</td>
												</tr>
											</table>
										</div>
                
                <!-- Attendance Summary -->
                <div class="modal-body">
                    <h5 style="font-weight: bold; text-decoration: underline;">Attendance Summary</h5>
                    <table class="table table-bordered text-center">
                        <thead>
                            <tr style="background-color: #3c8dbc; color: #fff;">
                                <th style="width: 12%;">Present</th>
                                <th style="width: 12%;">On Duty (OD)</th>
                                <th style="width: 12%;">Absent</th>
                                <th style="width: 12%;">Percentage</th>
                                <th style="width: 15%;">Punch Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td style="color: green; font-weight: bold;">18</td>
                                <td style="color: blue; font-weight: bold;">4</td>
                                <td style="color: red; font-weight: bold;">8</td>
                                <td>
                                    <span style="color: red; font-size: 18px; font-weight: bold;">74%</span>
                                </td>
                                <td>
                                    <a href="\#" data-bs-toggle="collapse" data-bs-target="\#punchDetailsCollapse" 
                                       style="text-decoration: none; color: #3c8dbc; font-weight: bold;">
                                       <span class="glyphicon glyphicon-eye-open"></span> View
                                    </a>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="collapse mt-3" id="punchDetailsCollapse">
                        <div class="card card-body">
                            <h6 style="font-weight: bold; color: #3c8dbc;">
                                Punch Details Upto Today
                            </h6>
                            <table id="sdpCalendarTable" class="table table-bordered table-hover">
                                <thead>
                                    <tr style="background-color: #2471a3; color: white; text-align: center;">
                                        <th style="width: 8%;">Sl.No.</th>
                                        <th style="width: 12%;">Date</th>
                                        <th style="width: 12%;">Day</th>
                                        <th style="width: 15%;">Day Type</th>
<!--                                         <th style="width: 25%;">Description</th>  -->   
                                      <th style="width: 13%;">Status</th>
                                        <th style="width: 15%;">Punch Time</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td align="center">1</td>
                                        <td align="center">17-07-2026</td>
                                        <td align="center">FRIDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                
                                                <span style="color: blue; font-weight: bold;">On Duty</span>
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">2</td>
                                        <td align="center">18-07-2026</td>
                                        <td align="center">SATURDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                
                                                <span style="color: blue; font-weight: bold;">On Duty</span>
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">3</td>
                                        <td align="center">19-07-2026</td>
                                        <td align="center">SUNDAY</td>
                                        <td align="center">Holiday</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                
                                                
                                                 <span>-</span>
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">4</td>
                                        <td align="center">20-07-2026</td>
                                        <td align="center">MONDAY</td>
                                        <td align="center">No Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                
                                                
                                                 <span>-</span>
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">5</td>
                                        <td align="center">21-07-2026</td>
                                        <td align="center">TUESDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                <span style="color: red; font-weight: bold;">Absent</span>
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">6</td>
                                        <td align="center">22-07-2026</td>
                                        <td align="center">WEDNESDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                <span style="color: red; font-weight: bold;">Absent</span>
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">7</td>
                                        <td align="center">23-07-2026</td>
                                        <td align="center">THURSDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                <span style="color: red; font-weight: bold;">Absent</span>
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">8</td>
                                        <td align="center">24-07-2026</td>
                                        <td align="center">FRIDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                <span style="color: red; font-weight: bold;">Absent</span>
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">9</td>
                                        <td align="center">25-07-2026</td>
                                        <td align="center">SATURDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                <span style="color: red; font-weight: bold;">Absent</span>
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">10</td>
                                        <td align="center">26-07-2026</td>
                                        <td align="center">SUNDAY</td>
                                        <td align="center">Holiday</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                
                                                
                                                 <span>-</span>
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">11</td>
                                        <td align="center">27-07-2026</td>
                                        <td align="center">MONDAY</td>
                                        <td align="center">No Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                
                                                
                                                 <span>-</span>
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">12</td>
                                        <td align="center">28-07-2026</td>
                                        <td align="center">TUESDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                
                                                <span style="color: blue; font-weight: bold;">On Duty</span>
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">13</td>
                                        <td align="center">29-07-2026</td>
                                        <td align="center">WEDNESDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                
                                                <span style="color: blue; font-weight: bold;">On Duty</span>
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">14</td>
                                        <td align="center">30-07-2026</td>
                                        <td align="center">THURSDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                <span style="color: red; font-weight: bold;">Absent</span>
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">15</td>
                                        <td align="center">31-07-2026</td>
                                        <td align="center">FRIDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                <span style="color: red; font-weight: bold;">Absent</span>
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">16</td>
                                        <td align="center">01-08-2026</td>
                                        <td align="center">SATURDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                <span style="color: red; font-weight: bold;">Absent</span>
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">17</td>
                                        <td align="center">02-08-2026</td>
                                        <td align="center">SUNDAY</td>
                                        <td align="center">Holiday</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                
                                                
                                                 <span>-</span>
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">18</td>
                                        <td align="center">03-08-2026</td>
                                        <td align="center">MONDAY</td>
                                        <td align="center">No Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                
                                                
                                                 <span>-</span>
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">19</td>
                                        <td align="center">04-08-2026</td>
                                        <td align="center">TUESDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                <span style="color: green; font-weight: bold;">Present</span>
                                                
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            <span style="color: green; font-weight: bold;">16:30:05</span>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">20</td>
                                        <td align="center">05-08-2026</td>
                                        <td align="center">WEDNESDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                <span style="color: green; font-weight: bold;">Present</span>
                                                
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            <span style="color: green; font-weight: bold;">12:39:54</span>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">21</td>
                                        <td align="center">06-08-2026</td>
                                        <td align="center">THURSDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                <span style="color: green; font-weight: bold;">Present</span>
                                                
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            <span style="color: green; font-weight: bold;">15:49:18</span>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">22</td>
                                        <td align="center">07-08-2026</td>
                                        <td align="center">FRIDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                <span style="color: green; font-weight: bold;">Present</span>
                                                
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            <span style="color: green; font-weight: bold;">11:11:30</span>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">23</td>
                                        <td align="center">08-08-2026</td>
                                        <td align="center">SATURDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                <span style="color: green; font-weight: bold;">Present</span>
                                                
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            <span style="color: green; font-weight: bold;">17:52:04</span>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">24</td>
                                        <td align="center">09-08-2026</td>
                                        <td align="center">SUNDAY</td>
                                        <td align="center">Holiday</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                
                                                
                                                 <span>-</span>
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">25</td>
                                        <td align="center">10-08-2026</td>
                                        <td align="center">MONDAY</td>
                                        <td align="center">No Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                
                                                
                                                 <span>-</span>
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">26</td>
                                        <td align="center">11-08-2026</td>
                                        <td align="center">TUESDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                <span style="color: green; font-weight: bold;">Present</span>
                                                
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            <span style="color: green; font-weight: bold;">11:11:18</span>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">27</td>
                                        <td align="center">12-08-2026</td>
                                        <td align="center">WEDNESDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                <span style="color: green; font-weight: bold;">Present</span>
                                                
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            <span style="color: green; font-weight: bold;">12:27:06</span>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">28</td>
                                        <td align="center">13-08-2026</td>
                                        <td align="center">THURSDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                <span style="color: green; font-weight: bold;">Present</span>
                                                
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            <span style="color: green; font-weight: bold;">13:59:21</span>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">29</td>
                                        <td align="center">14-08-2026</td>
                                        <td align="center">FRIDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                <span style="color: green; font-weight: bold;">Present</span>
                                                
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            <span style="color: green; font-weight: bold;">11:11:48</span>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">30</td>
                                        <td align="center">15-08-2026</td>
                                        <td align="center">SATURDAY</td>
                                        <td align="center">Holiday</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                
                                                
                                                 <span>-</span>
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">31</td>
                                        <td align="center">16-08-2026</td>
                                        <td align="center">SUNDAY</td>
                                        <td align="center">Holiday</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                
                                                
                                                 <span>-</span>
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">32</td>
                                        <td align="center">17-08-2026</td>
                                        <td align="center">MONDAY</td>
                                        <td align="center">CAT1</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                
                                                
                                                 <span>-</span>
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">33</td>
                                        <td align="center">18-08-2026</td>
                                        <td align="center">TUESDAY</td>
                                        <td align="center">CAT1</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                <span style="color: green; font-weight: bold;">Present</span>
                                                
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            <span style="color: green; font-weight: bold;">11:15:51</span>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">34</td>
                                        <td align="center">19-08-2026</td>
                                        <td align="center">WEDNESDAY</td>
                                        <td align="center">CAT1</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                <span style="color: green; font-weight: bold;">Present</span>
                                                
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            <span style="color: green; font-weight: bold;">16:54:13</span>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">35</td>
                                        <td align="center">20-08-2026</td>
                                        <td align="center">THURSDAY</td>
                                        <td align="center">CAT1</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                <span style="color: green; font-weight: bold;">Present</span>
                                                
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            <span style="color: green; font-weight: bold;">11:11:49</span>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">36</td>
                                        <td align="center">21-08-2026</td>
                                        <td align="center">FRIDAY</td>
                                        <td align="center">CAT1</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                <span style="color: green; font-weight: bold;">Present</span>
                                                
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            <span style="color: green; font-weight: bold;">11:18:34</span>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">37</td>
                                        <td align="center">22-08-2026</td>
                                        <td align="center">SATURDAY</td>
                                        <td align="center">CAT1</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                <span style="color: green; font-weight: bold;">Present</span>
                                                
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            <span style="color: green; font-weight: bold;">12:02:10</span>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">38</td>
                                        <td align="center">23-08-2026</td>
                                        <td align="center">SUNDAY</td>
                                        <td align="center">Holiday</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                
                                                
                                                 <span>-</span>
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">39</td>
                                        <td align="center">24-08-2026</td>
                                        <td align="center">MONDAY</td>
                                        <td align="center">CAT1</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                
                                                
                                                 <span>-</span>
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">40</td>
                                        <td align="center">25-08-2026</td>
                                        <td align="center">TUESDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                <span style="color: green; font-weight: bold;">Present</span>
                                                
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            <span style="color: green; font-weight: bold;">11:11:12</span>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">41</td>
                                        <td align="center">26-08-2026</td>
                                        <td align="center">WEDNESDAY</td>
                                        <td align="center">Holiday</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                
                                                
                                                
                                                 <span>-</span>
                                            </span>
                                        </td>
                                        <td align="center">
                                            
                                            <span>-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">42</td>
                                        <td align="center">27-08-2026</td>
                                        <td align="center">THURSDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                <span style="color: green; font-weight: bold;">Present</span>
                                                
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            <span style="color: green; font-weight: bold;">11:11:32</span>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">43</td>
                                        <td align="center">28-08-2026</td>
                                        <td align="center">FRIDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                <span style="color: green; font-weight: bold;">Present</span>
                                                
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            <span style="color: green; font-weight: bold;">11:11:19</span>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">44</td>
                                        <td align="center">29-08-2026</td>
                                        <td align="center">SATURDAY</td>
                                        <td align="center">Instructional</td>
<!--                                         <td th:text="${entry.description}"></td>  --> 
                                       <td align="center">
                                            <span>
                                                <span style="color: green; font-weight: bold;">Present</span>
                                                
                                                
                                                 
                                            </span>
                                        </td>
                                        <td align="center">
                                            <span style="color: green; font-weight: bold;">11:11:06</span>
                                            
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <!-- Footer -->
                <div class="modal-footer">
                    <button class="btn btn-primary" type="button" data-bs-dismiss="modal">
                        Close
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>"#;

    let (attd_record, punch_details) = parse_cap_or_sdp_attendance(html.to_string());

    assert_eq!(attd_record.course_id, "AM_CAP4000_00000");
    assert_eq!(attd_record.course_code, "CAP4001");
    assert_eq!(attd_record.course_name, "Capstone");
    assert_eq!(attd_record.attended_classes, "22");
    assert_eq!(attd_record.total_classes, "30");
    assert_eq!(attd_record.attendance_percentage, "74%");

    assert_eq!(punch_details[0].day_time, "SAT / 11:11:06");
    assert_eq!(punch_details.len(), 44);

}

#[test]
fn test_parse_attendance() {
    let html = r#"<div class="form-group" id="getStudentDetails">
																
								<div class="col-sm-12 form-group table-responsive" style="overflow-y: hidden;">
								<h4 style="text-decoration: underline;"><b>Attendance Information:</b></h4>	
								<h5>
									<span><span style="color:red;">* Note:</span> As per norms, <b>Virtual Slots</b> &amp; <b>Medical Leave</b> are not included in attendance percentage calculation.</span>
								</h5>
								
								<!-- <h5>
									<span>* <b>CAT2/FAT Period Attendance Percentage </b>is Based on academic calendar dates let's say current date is between CAT1 and CAT2 it will show CAT2 period attendance.</span>
								</h5> -->
								<table id="AttendanceDetailDataTable" class="table table-bordered table-hover responsive">
									 
										<thead>
											<tr style="background-color: #3c8dbc; border-color: #fff; color: #fff;">
												<td style="width: 3%; text-align: center;"><b>Sl.No.</b></td>
												<td style="width: 10%; text-align: center;"><b>Class Group</b></td>
												<td style="width: 15%; text-align: center;"><b>Course Detail</b></td>
												<td style="width: 15%; text-align: center;"><b>Class Detail</b></td>
												<td style="width: 15%; text-align: center;"><b>Faculty Detail</b></td>
												<td style="width: 8%; text-align: center;"><b>Attended Classes</b></td>
												<td style="width: 8%; text-align: center;"><b>Total Classes</b></td>
												<td style="width: 8%; text-align: center;"><b>Attendance Percentage</b></td>
												<!-- <td style="width: 8%; text-align: center;"><b>CAT2/FAT Period Att. Percentage</b></td> -->
												<td style="width: 10%; text-align: center;"><b>Debar Status</b></td>
												<td style="width: 8%; text-align: center;"><b>Attendance Detail</b></td>
											</tr>
										</thead>
										
										<tbody>
											
										</tbody>
									</table>
									</div>
								<div class="text-center">
									<button type="button" class="btn btn-success"
										onclick="viewSDPAttendance()">View CAPSTONE/SDP Attendance</button>
								</div>
							</div>"#;
    let html1 = r#"<div class="form-group" id="getStudentDetails">
                                                            
                            <div class="col-sm-12 form-group table-responsive" style="overflow-y: hidden;">
                            <h4 style="text-decoration: underline;"><b>Attendance Information:</b></h4>	
                            <h5>
                                <span><span style="color:red;">* Note:</span> As per norms, <b>Virtual Slots</b> &amp; <b>Medical Leave</b> are not included in attendance percentage calculation.</span>
                            </h5>
                            
                            <!-- <h5>
                                <span>* <b>CAT2/FAT Period Attendance Percentage </b>is Based on academic calendar dates let's say current date is between CAT1 and CAT2 it will show CAT2 period attendance.</span>
                            </h5> -->
                            <table id="AttendanceDetailDataTable" class="table table-bordered table-hover responsive">
                                    
                                    <thead>
                                        <tr style="background-color: #3c8dbc; border-color: #fff; color: #fff;">
                                            <td style="width: 3%; text-align: center;"><b>Sl.No.</b></td>
                                            <td style="width: 10%; text-align: center;"><b>Class Group</b></td>
                                            <td style="width: 15%; text-align: center;"><b>Course Detail</b></td>
                                            <td style="width: 15%; text-align: center;"><b>Class Detail</b></td>
                                            <td style="width: 15%; text-align: center;"><b>Faculty Detail</b></td>
                                            <td style="width: 8%; text-align: center;"><b>Attended Classes</b></td>
                                            <td style="width: 8%; text-align: center;"><b>Total Classes</b></td>
                                            <td style="width: 8%; text-align: center;"><b>Attendance Percentage</b></td>
                                            <!-- <td style="width: 8%; text-align: center;"><b>CAT2/FAT Period Att. Percentage</b></td> -->
                                            <td style="width: 10%; text-align: center;"><b>Debar Status</b></td>
                                            <td style="width: 8%; text-align: center;"><b>Attendance Detail</b></td>
                                        </tr>
                                    </thead>
                                    
                                    <tbody>
                                        
                                    </tbody>
                                </table>
                                </div>
                        </div>"#;

    let (mut rec, mut btn) = parse_attendance(html.to_string());
    assert_eq!(rec.len(), 0);
    assert_eq!(btn, true);

    (rec, btn) = parse_attendance(html1.to_string());
    assert_eq!(rec.len(), 0);
    assert_eq!(btn, false);
}