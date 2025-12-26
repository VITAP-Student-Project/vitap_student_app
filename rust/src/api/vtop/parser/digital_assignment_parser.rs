use super::super::types::*;
use scraper::{Html, Selector};

pub fn parse_all_assignments(html: String) -> Vec<DigitalAssignments> {
    let document = Html::parse_document(&html);
    let rows_selector = Selector::parse("tr").unwrap();
    let mut all_assignments: Vec<DigitalAssignments> = Vec::new();

    for row in document.select(&rows_selector).skip(1) {
        let cells: Vec<_> = row.select(&Selector::parse("td").unwrap()).collect();
        if cells.len() == 7 {
            let serial_number = cells[0]
                .text()
                .collect::<Vec<_>>()
                .join("")
                .trim()
                .replace("\t", "")
                .replace("\n", "");
            let class_id = cells[1]
                .text()
                .collect::<Vec<_>>()
                .join("")
                .trim()
                .replace("\t", "")
                .replace("\n", "");
            let course_code = cells[2]
                .text()
                .collect::<Vec<_>>()
                .join("")
                .trim()
                .replace("\t", "")
                .replace("\n", "");
            let course_title = cells[3]
                .text()
                .collect::<Vec<_>>()
                .join("")
                .trim()
                .replace("\t", "")
                .replace("\n", "");
            let course_type = cells[4]
                .text()
                .collect::<Vec<_>>()
                .join("")
                .trim()
                .replace("\t", "")
                .replace("\n", "");
            let faculty = cells[5]
                .text()
                .collect::<Vec<_>>()
                .join("")
                .trim()
                .replace("\t", "")
                .replace("\n", "");
            let details: Vec<AssignmentRecordEach> = Vec::new(); // Details to be filled separately
            let assignment = DigitalAssignments {
                serial_number,
                class_id,
                course_code,
                course_title,
                course_type,
                faculty,
                details,
            };
            all_assignments.push(assignment);
        }
    }

    all_assignments
}

pub fn parse_per_course_dassignments(html: String) -> Vec<AssignmentRecordEach> {
    let mut course_assignments: Vec<AssignmentRecordEach> = Vec::new();
    let document = Html::parse_document(&html);
    let rows_selector = Selector::parse("tr").unwrap();
    for row in document.select(&rows_selector).skip(4) {
        let cells: Vec<_> = row.select(&Selector::parse("td").unwrap()).collect();
        if cells.len() == 9 {
            let serial_number = cells[0]
                .text()
                .collect::<Vec<_>>()
                .join("")
                .trim()
                .replace("\t", "")
                .replace("\n", "");
            let assignment_title = cells[1]
                .text()
                .collect::<Vec<_>>()
                .join("")
                .trim()
                .replace("\t", "")
                .replace("\n", "");
            let max_assignment_mark = cells[2]
                .text()
                .collect::<Vec<_>>()
                .join("")
                .trim()
                .replace("\t", "")
                .replace("\n", "");
            let assignment_weightage_mark = cells[3]
                .text()
                .collect::<Vec<_>>()
                .join("")
                .trim()
                .replace("\t", "")
                .replace("\n", "");
            let due_date = cells[4]
                .text()
                .collect::<Vec<_>>()
                .join("")
                .trim()
                .replace("\t", "")
                .replace("\n", "");
            let can_qp_download = cells[5].inner_html().trim().contains("Download");
            let submission_status = cells[6]
                .text()
                .collect::<Vec<_>>()
                .join("")
                .trim()
                .replace("\t", "")
                .replace("\n", "");
            let can_update = cells[7].inner_html().trim().contains("Upload");
            let can_da_download = cells[8].inner_html().trim().contains("Download")
                && (!submission_status.eq("") && !submission_status.contains("File Not Uploaded"));
            let record = AssignmentRecordEach {
                serial_number,
                assignment_title,
                max_assignment_mark,
                assignment_weightage_mark,
                due_date,
                can_qp_download,
                submission_status,
                can_update,
                can_da_download,
            };
            course_assignments.push(record);
        }
    }
    course_assignments
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_all_assignments() {
        //digital assignments page with no data found response
        let html = r#"<!DOCTYPE html>
<!--
  Author: Prabakaran Ramu
  Date  : 23/06/2018
  -->
<html>
  <!--<head th:include="layouts/header :: style_sheets">-->
  <head>
    <link rel="stylesheet" href="assets/css/sweetalert.css" />
    <script type="text/javascript" src="assets/js/sweetalert.min.js" charset="utf-8"></script>
  </head>
  <body class="hold-transition skin-blue-light sidebar-mini fixed">
    <div id="main-section">
      <!-- Main content -->
      <section class="content">
        <div class="col-sm-12">
          <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">Assignment Upload</h3>
            </div>
            <div class="box-body">
              <form role="form" id="digitalAssignment" name="digitalAssignment"
                method="post" autocomplete="off">
                <input type="hidden" name="authorizedID" id="authorizedID"
                  value="2XBCEXXXX" />
                <!-- th:object="${examSchedule}"> -->
                <div class="col-md-16"
                  style="margin-top: 20px; margin-left: 1px;">
                  <div>
                    <div class="col-md-12">
                      <div class="col-md-3"></div>
                      <div class="col-md-6">
                        <br />
                        <div>
                          <label for="acadYear" class="col-sm-4 control-label">Select
                          Semester</label>
                          <div class="col-md-8">
                            <select class="form-control" name="semesterSubId"
                              id="semesterSubId" required="required"
                              onchange="dAOnChange();">
                              <option value="" selected="selected">-- Choose
                                Semester --
                              </option>
                              <option value="AP2025264"
                                selected="selected">Winter Semester 2025-26</option>
                              <option value="AP2025263">Fall Semester 2025-26 Freshers</option>
                              <option value="AMR2017181">FALL SEM (2017-18)</option>
                            </select>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="col-md-12"
                      style="align-content: center; text-align: center;">
                      <br /> <span
                        style="color: red; font-size: 20px;"> No data found</span>
                    </div>
                    <input type="hidden" id="success" value="" /> <input
                      type="hidden" id="jsonBom" value="" />
                    <script>
                      /*<![CDATA[*/
                      
                      var message = document
                      		.getElementById("jsonBom").value;
                      var success = document
                      		.getElementById("success").value;
                      
                      if (message != "") {
                      	swal(message, "", "error");
                      }
                      
                      if (success != "") {
                      	swal(success, "", "success");
                      }
                      //}				 				
                      
                      /*]]>*/
                    </script>
                  </div>
                </div>
                <script>
                  $(document).ready(function() {
                  	$('[data-toggle="tooltip"]').tooltip();
                  });
                </script>
              </form>
            </div>
          </div>
        </div>
      </section>
      <noscript>
        <h2 class="text-red">Enable JavaScript to Access VTOP</h2>
      </noscript>
      <script type="text/javascript">
        /*<![CDATA[*/
        
        function myFunction(classId) {
        	
        	var csrfName = "_csrf";
                  var csrfValue = "da8eb9d2-55a6-4b09-9d6a-43be87XXXXXX";
        
        	$
        			.blockUI({
        
        				message : '<img src="assets/img/482.GIF"> loading... Just a moment...'
        			});
        
        	var authorizedID = document.getElementById("authorizedID").value;
        	var now = new Date();
        	params = "authorizedID=" + authorizedID + "&x="
        			+ now.toUTCString() + "&classId=" + classId+"&"+csrfName+"="+csrfValue;
        
        	$.ajax({
        		url : "examinations/processDigitalAssignment",
        		type : "POST",
        		data : params,
        
        		success : function(response) {
        			$.unblockUI();
        
        			$("/#main-section").html(response);
        
        		}
        
        	});
        }
        
        function dAOnChange() {
        	var myform = document.getElementById("digitalAssignment");
        	var fd = new FormData(myform);
        	var csrfName = "_csrf";
                  var csrfValue = "da8eb9d2-55a6-4b09-9d6a-43be87XXXXXX";
                  fd.append(csrfName,csrfValue);
        
        	$
        			.blockUI({
        
        				message : '<img src="assets/img/482.GIF"> loading... Just a moment...'
        			});
        	$.ajax({
        		url : "examinations/doDigitalAssignment",
        		type : "POST",
        		data : fd,
        		cache : false,
        		processData : false,
        		contentType : false,
        		success : function(response) {
        			$.unblockUI();
        			$("/#main-section").html(response);
        
        		}
        
        	});
        }
        
        /*]]>*/
      </script>
    </div>
  </body>
</html>"#;
        let result = parse_all_assignments(html.to_string());
        assert_eq!(result.is_empty(), true);
    }
}
