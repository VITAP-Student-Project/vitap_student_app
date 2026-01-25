use super::super::types::*;
use scraper::{Html, Selector};
use regex::Regex;

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
            let re_for_url = Regex::new(r"vtopDownload\('([^']+)'\)").unwrap();
            let qp_download_url;
            if(can_qp_download){
                qp_download_url = cells[5]
                .select(&Selector::parse("a").unwrap())
                .next()
                .and_then(|a| a.value().attr("href"))
                .and_then(|href| {
                  re_for_url.captures(href)
                      .and_then(|caps| caps.get(1))
                      .map(|m| m.as_str().to_string())})
                .unwrap_or_default();}
            else{qp_download_url = String::new();}
            let submission_status = cells[6]
                .text()
                .collect::<Vec<_>>()
                .join("")
                .trim()
                .replace("\t", "")
                .replace("\n", "");
            let can_update = cells[7].inner_html().trim().contains("pencil");
            let can_da_download = cells[8].inner_html().trim().contains("Download")
                && (!submission_status.eq("") && !submission_status.contains("File Not Uploaded"));
            let da_download_url;
            if(can_da_download){
                  da_download_url =  cells[8]
                  .select(&Selector::parse("a").unwrap())
                  .next()
                  .and_then(|a| a.value().attr("href"))
                  .and_then(|href| {
                    re_for_url.captures(href)
                        .and_then(|caps| caps.get(1))
                        .map(|m| m.as_str().to_string())})
                  .unwrap_or_default();
                }
            else{da_download_url = String::new();}
            let record = AssignmentRecordEach {
                serial_number,
                assignment_title,
                max_assignment_mark,
                assignment_weightage_mark,
                due_date,
                can_qp_download,
                qp_download_url,
                submission_status,
                can_update,
                can_da_download,
                da_download_url,
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

    #[test]
    fn test_parse_per_course_dassignments() {
        //digital assignments per course with no assignments uploaded
        let html = r#"<!DOCTYPE html>
<!--
  Author: Prabakaran Ramu
  Date  : 23/06/2018
  Updated author : Poornima V -- 10/01/2023
-->
<html>
<!--<head th:include="layouts/header :: style_sheets">-->
<head>
<link rel="stylesheet" href="assets/css/sweetalert.css" />
<script type="text/javascript" src="assets/js/sweetalert.min.js"
	charset="utf-8"></script>
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

						<form role="form" id="daUpload" name="daUpload" method="post"
							autocomplete="off">
							<input type="hidden" name="authorizedID" id="authorizedID"
								value="2XBCEXXXXX" />
							<!-- th:object="${examSchedule}"> -->
							<div class="col-md-16"
								style="margin-top: 20px; margin-left: 1px;">
								<div>

									<div align="center">
										<span
											style="color: green; font-size: 20px; font-weight: bold;"></span> <span
											style="color: red; font-size: 20px; font-weight: bold;"></span></div>

									<div id="fixedTableContainer" class="fixedTableContainer">
										<table class="customTable" style="align: center;">
											<tbody>
												<tr class="fixedContent tableHeader">
													<td style="width: 20%;">Semester</td>
													<td style="width: 12%;">Course Code</td>
													<td style="width: 30%;">Course Title</td>
													<td style="width: 12%;">Course Type</td>
													<td style="width: 10%;">Class Number</td>
												</tr>
												<tr class="fixedContent tableContent">
													<td style="width: 20%;">Winter Semester 2025-26</td>
													<td style="width: 10%;">CSE3015</td>
													<td style="width: 30%;">Natural Language Processing</td>
													<td style="width: 10%;">ETH</td>
													<td style="width: 10%;">AP2025264000667</td>
												</tr>
											</tbody>
										</table>
									</div>


									<br /> 
									
								<div class="col-md-10">
									<p style="color: red;">
										Notes:  <br /> 
										1. File size (Max. upto 4MB) <br /> 
										2. File type should be pdf,xls,xlsx,doc,docx <br /> 
									</p>
								</div>
									
									<div id="fixedTableContainer" class="fixedTableContainer">
										<table class="customTable">
											<tbody>
												<tr class="fixedContent tableHeader">
													<td rowspan="2" style="width: 5%;">Sl.No.</td>
													<td rowspan="2" style="width: 20%;">Title</td>
													<td rowspan="2" style="width: 5%;">Max. Mark</td>
													<td rowspan="2" style="width: 5%;">Weightage %</td>
													<td rowspan="2" style="width: 10%;">Due Date</td>
													<td rowspan="2" style="width: 5%;">QP</td>
													<td colspan="3" style="width: 50%;">Document Details</td>
												</tr>
												<tr class="fixedContent tableHeader">
													<td style="width: 20%;">Last Updated On</td>
													<td style="width: 20%;">Upload/Edit</td>
													<td style="width: 20%;">Download</td>
												</tr>
											</tbody>

											<tr class="fixedContent tableContent">
												<td style=" vertical-align: middle; text-align: center;">1</td>
												<td >Digital Assessment-1</td>
												<td style=" vertical-align: middle; text-align: center;">10</td>
												<td style=" vertical-align: middle; text-align: center;">10</td>

												<td
													style=" vertical-align: middle; text-align: center;">
													<span style="color: green;">02-May-2026</span> 
												</td>
												<td></td>
													
												<td style=" text-align: center;">
												
																						
												<span>20 Jan 2026 03:09 PM</span>
													</td>
													
												
												<td style=" text-align: center;">
												
												<br/>
												 <span>
														<span> <input
															type="hidden" name="code"
															value="DA01"></input> <input
															type="hidden" name="opt" value="Digital Assessment-1"></input>
															 <span>
																<button type="button" class="icon-button"
																	style="vertical-align: middle; text-align: center;"
																	onclick="javascript:doDAssignmentProcess(&#39;AP2025264000667&#39;,
												&#39;DA01&#39;);">
																	<span
																		class="glyphicon glyphicon-pencil glyphiconDefault"></span>
																</button>
														</span>


													</span>
												</span>
												</td>
	
												<td style=" text-align: center;">
													 <a class="btn btn-link"
														href="javascript:vtopDownload(&#39;examinations/downloadSTudentDA/DA01/AP2025264000667&#39;)">
														<span class="glyphicon glyphicon-download-alt"></span>														
														</a>
												</td>	


											</tr>

											<tr class="fixedContent tableContent">
												<td style=" vertical-align: middle; text-align: center;">2</td>
												<td >Digital Assessment-2</td>
												<td style=" vertical-align: middle; text-align: center;">10</td>
												<td style=" vertical-align: middle; text-align: center;">10</td>

												<td
													style=" vertical-align: middle; text-align: center;">
													<span style="color: green;">02-May-2026</span> 
												</td>
												<td></td>
													
												<td style=" text-align: center;">
												
												<span style="color: green;"></span>										
												
													</td>
													
												
												<td style=" text-align: center;">
												
												<br/>
												 <span>
														<span> <input
															type="hidden" name="code"
															value="DA02"></input> <input
															type="hidden" name="opt" value="Digital Assessment-2"></input>
															 <span>
																<button type="button" class="icon-button"
																	style="vertical-align: middle; text-align: center;"
																	onclick="javascript:doDAssignmentProcess(&#39;AP2025264000667&#39;,
												&#39;DA02&#39;);">
																	<span
																		class="glyphicon glyphicon-pencil glyphiconDefault"></span>
																</button>
														</span>


													</span>
												</span>
												</td>
	
												<td style=" text-align: center;">
													 <a class="btn btn-link"
														href="javascript:vtopDownload(&#39;examinations/downloadSTudentDA/DA02/AP2025264000667&#39;)">
																												
														</a>
												</td>	


											</tr>


										</table>

									</div>
									
							<div class="modal" id="myModal" role="dialog">
								<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
									<!-- Modal content-->
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-bs-dismiss="modal">&times;</button>
											<h4 class="modal-title">File Upload</h4>
										</div>
										<div class="modal-body">
											<embed id="tes"  width="100%" height="400px" />
										</div>
										<div class="modal-footer">

											<button type="button" class="btn btn-default"
												data-bs-dismiss="modal">confirm</button>

											<button type="button" class="btn btn-default" id="close"
												data-bs-dismiss="modal">close</button>


										</div>
									</div>
								</div>
							</div>
							
								

									<div align="left" class="col-md-6">
										<br />
										<button type="button" class="btn btn-primary"
											onclick="javascript:reload(&#39;AP2025264&#39;);">
											Go Back</button>
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
		<!-- Custom Scripts for VTOP Pages-->


		<script>
			/*<![CDATA[*/
				
				$('#studDaUpload').change(function() {
									// Initializing our modal.
					var daUploadFlag = true;
					 var uploadedFile =document.getElementById("studDaUpload").value;
					 if(uploadedFile==''){
						 swal("Kindly upload the file","", "warning");
						 daUploadFlag =  false;
					 }
				     if(uploadedFile!=''){
				          var checkimg = uploadedFile.toLowerCase();
				          
				          if (!checkimg.match(/(\.pdf|\.xls|\.xlsx|\.doc|\.docx)$/)){ // validation of file extension using regular expression before file upload
				              document.getElementById("studDaUpload").focus();
				              swal("File type should be pdf,xls,xlsx,doc,docx","", "warning");
				              daUploadFlag =  false;
				           }
				            var img = document.getElementById("studDaUpload");			            
				            if(uploadedFile!='' && img.files[0].size > 4194304)  // validation according to file size
				            {			            	
				            	swal("File size (Max. upto 4MB)","", "warning");
				            	daUploadFlag =  false;
				            }			            
				      }
				     if(daUploadFlag==true)
				    	 {
				    	 	var checkimg = uploadedFile.toLowerCase();
				          
				          if (checkimg.match(/(\.pdf)$/)){ // validation of file extension using regular expression before file upload
				        	  readURL(this, 'studDaUpload');
								if (this.name == 'studDaUpload') {
									$("/#close").click(function() {
										$("/#studDaUpload").val("")
									});
								}
				           }									
				    	 }
				});
			
				function readURL(input, ch) {
					if (input.files && input.files[0]) {

						var reader = new FileReader();

						reader.onload = function(e) {

							$('#tes').attr('src',
									e.target.result);

							$('#myModal').modal('show');

						}

						reader.readAsDataURL(input.files[0]);

					}

				}
				
			function doDAssignmentProcess(classId, mode) {
				var myform = document.getElementById("daUpload");
				var fd = new FormData(myform);
				var csrfName = "_csrf";
	            var csrfValue = "XXX619c2-baba-474X-a95e-b1937c33XXXX";
	            fd.append(csrfName,csrfValue);

				$
						.blockUI({

							message : '<img src="assets/img/482.GIF"> loading... Just a moment...'
						});

				var authorizedID = document.getElementById("authorizedID").value;
				var now = new Date();
				params = "authorizedID=" + authorizedID + "&x="
						+ now.toUTCString() + "&classId=" + classId + "&mode="
						+ mode+"&"+csrfName+"="+csrfValue;

				$.ajax({
					url : "examinations/processDigitalAssignmentUpload",
					type : "POST",
					data : params,

					success : function(response) {
						$.unblockUI();
						$("/#main-section").html(response);

					}

				});
			}

			function reload(semesterSubId) {

				var myform = document.getElementById("daUpload");
				var fd = new FormData(myform);
				var csrfName = "_csrf";
	            var csrfValue = "XXX619c2-baba-474X-a95e-b1937c33XXXX";
	            fd.append(csrfName,csrfValue);

				$
						.blockUI({

							message : '<img src="assets/img/482.GIF"> loading... Just a moment...'
						});

				var authorizedID = document.getElementById("authorizedID").value;
				var now = new Date();
				params = "authorizedID=" + authorizedID + "&x="
						+ now.toUTCString() + "&semesterSubId=" + semesterSubId+"&"+csrfName+"="+csrfValue;

				$.ajax({
					url : "examinations/doDigitalAssignment",
					type : "POST",
					data : params,

					success : function(response) {
						$.unblockUI();
						$("/#main-section").html(response);

					}

				});
			}

			function doSaveDigitalAssignment(classId, mCode) {
				var myform = document.getElementById("daUpload");
				var fd = new FormData(myform);
				var csrfName = "_csrf";
	            var csrfValue = "XXX619c2-baba-474X-a95e-b1937c33XXXX";
	            fd.append(csrfName,csrfValue);

				fd.append("classId", classId);
				fd.append("mCode", mCode);
				
				var daUploadFlag = true;
				 var uploadedFile =document.getElementById("studDaUpload").value;
				 if(uploadedFile==''){
					 swal("Kindly upload the file","", "warning");
					 daUploadFlag =  false;
				 }
			     if(uploadedFile!=''){
			          var checkimg = uploadedFile.toLowerCase();
			          
			          if (!checkimg.match(/(\.pdf|\.xls|\.xlsx|\.doc|\.docx)$/)){ // validation of file extension using regular expression before file upload
			              document.getElementById("studDaUpload").focus();
			              swal("File type should be pdf,xls,xlsx,doc,docx","", "warning");
			              daUploadFlag =  false;
			           }
			            var img = document.getElementById("studDaUpload");			            
			            if(uploadedFile!='' && img.files[0].size > 4194304)  // validation according to file size
			            {			            	
			            	swal("File size (Max. upto 4MB)","", "warning");
			            	daUploadFlag =  false;
			            }			            
			      }
			     if(daUploadFlag==true)
			    	 {
			    	 
			    		 $
						.blockUI({
							message : '<img src="assets/img/482.GIF"> loading... Just a moment...'
						});
				    	 $.ajax({
								url : "examinations/doDAssignmentUploadMethod",
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
			}

			function doCancelAssgnUpload(classId) {
				var authorizedID = document.getElementById("authorizedID").value;
				var now = new Date();
				var authorizedId="2XBCEXXXXX";
				var csrfName = "_csrf";
	            var csrfValue = "XXX619c2-baba-474X-a95e-b1937c33XXXX";
				params = "authorizedID=" + authorizedID + "&x="
						+ now.toUTCString() + "&classId=" + classId+"&"+csrfName+"="+csrfValue;
				$
						.blockUI({

							message : '<img src="assets/img/482.GIF"> loading... Just a moment...'
						});

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

			/*]]>*/
		</script>
	</div>


</body>
</html>"#;
        let result = parse_per_course_dassignments(html.to_string());
        assert_eq!(result[0].serial_number, "1");
        assert_eq!(result[0].assignment_title, "Digital Assessment-1");
        assert_eq!(result[0].max_assignment_mark, "10");
        assert_eq!(result[0].assignment_weightage_mark, "10");
        assert_eq!(result[0].due_date, "02-May-2026");
        assert_eq!(result[0].can_qp_download, false);
        assert_eq!(result[0].da_download_url, "examinations/downloadSTudentDA/DA01/AP2025264000667");
        assert_eq!(result[0].qp_download_url, "");
        assert_eq!(result[0].can_update, true);
        assert_eq!(result[0].submission_status, "20 Jan 2026 03:09 PM");
        assert_eq!(result.len(), 2);
    }


}
