use crate::api::vtop::{
    parser, types::*, vtop_client::VtopClient, vtop_errors::VtopError, vtop_errors::VtopResult,
};
use reqwest::multipart;

impl VtopClient {
    /// Retrieves the student's general outing (day leave) records from VTOP.
    ///
    /// Fetches a list of all general outing applications submitted by the student, including
    /// both approved and pending requests. General outings are typically used for day trips
    /// or short leaves that don't require overnight permission.
    ///
    /// # Returns
    ///
    /// Returns a `VtopResult<Vec<GeneralOutingRecord>>` containing:
    /// - Leave application ID (for PDF download)
    /// - Purpose of visit/outing
    /// - Destination/place of visit
    /// - Outing date and time
    /// - Return date and time
    /// - Application status (pending/approved/rejected)
    /// - Parent contact number
    /// - Application submission timestamp
    ///
    /// # Errors
    ///
    /// This function will return an error if:
    /// - The session is not authenticated (`VtopError::SessionExpired`)
    /// - Network communication fails (`VtopError::NetworkError`)
    /// - The VTOP server returns an error response (`VtopError::VtopServerError`)
    /// - Session expires during the request and re-authentication fails
    ///
    /// # Examples
    ///
    /// ```
    /// # async fn example(client: &mut VtopClient) -> Result<(), Box<dyn std::error::Error>> {
    /// let outings = client.get_general_outing_reports().await?;
    /// for outing in outings {
    ///     println!("Destination: {}", outing.destination);
    ///     println!("Date: {}", outing.outing_date);
    ///     println!("Status: {}", outing.status);
    /// }
    /// # Ok(())
    /// # }
    /// ```
    pub async fn get_general_outing_reports(&mut self) -> VtopResult<Vec<GeneralOutingRecord>> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!("{}/vtop/hostel/StudentGeneralOuting", self.config.base_url);
        let body = format!(
            "verifyMenu=true&_csrf={}&authorizedID={}&nocache=@(new Date().getTime())",
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
            self.username
        );

        let res = self
            .client
            .post(url)
            .body(body)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;

        // Check for session expiration and auto re-authenticate if needed
        self.handle_session_check(&res).await?;

        let text = res.text().await.map_err(|_| VtopError::VtopServerError)?;
        let leave_data = parser::hostel::general_outing_parser::parse_hostel_leave(text);
        Ok(leave_data)
    }

    /// Downloads the PDF pass for a specific general outing application.
    ///
    /// Retrieves the official leave pass document in PDF format for an approved general
    /// outing. This pass typically needs to be shown to hostel security when leaving campus.
    /// The PDF contains student details, outing information, and approval signatures.
    ///
    /// # Arguments
    ///
    /// * `leave_id` - The unique identifier of the leave application (obtained from `get_general_outing_reports()`)
    ///
    /// # Returns
    ///
    /// Returns a `VtopResult<Vec<u8>>` containing the PDF file as a byte vector that can be:
    /// - Saved to disk as a `.pdf` file
    /// - Displayed in a PDF viewer
    /// - Shared or printed
    ///
    /// # Errors
    ///
    /// This function will return an error if:
    /// - The session is not authenticated (`VtopError::SessionExpired`)
    /// - The provided leave ID is invalid or not found
    /// - The leave application is not yet approved (may return empty/error)
    /// - Network communication fails (`VtopError::NetworkError`)
    /// - The VTOP server returns an error response (`VtopError::VtopServerError`)
    /// - Session expires during the request and re-authentication fails
    ///
    /// # Examples
    ///
    /// ```
    /// # async fn example(client: &mut VtopClient) -> Result<(), Box<dyn std::error::Error>> {
    /// // First get the outing records
    /// let outings = client.get_general_outing_reports().await?;
    /// 
    /// // Download PDF for an approved outing
    /// if let Some(outing) = outings.iter().find(|o| o.status == "Approved") {
    ///     let pdf_bytes = client.get_general_outing_pdf(outing.leave_id.clone()).await?;
    ///     
    ///     // Save to file
    ///     std::fs::write("outing_pass.pdf", pdf_bytes)?;
    ///     println!("PDF saved successfully");
    /// }
    /// # Ok(())
    /// # }
    /// ```
    pub async fn get_general_outing_pdf(&mut self, leave_id: String) -> VtopResult<Vec<u8>> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!(
            "{}/vtop/hostel/downloadLeavePass/{}?authorizedID={}&_csrf={}&x={}",
            self.config.base_url,
            leave_id,
            self.username,
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
            chrono::Utc::now().to_rfc2822()
        );

        let res = self
            .client
            .get(url)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;

        // Check for session expiration and auto re-authenticate if needed
        self.handle_session_check(&res).await?;

        let bytes = res.bytes().await.map_err(|_| VtopError::VtopServerError)?;
        Ok(bytes.to_vec())
    }

    /// Retrieves the student's weekend outing records from VTOP.
    ///
    /// Fetches a list of all weekend outing bookings made by the student, including past and
    /// upcoming weekend leaves. Weekend outings typically require advance booking and cover
    /// Friday evening through Sunday night or longer holiday periods.
    ///
    /// # Returns
    ///
    /// Returns a `VtopResult<Vec<WeekendOutingRecord>>` containing:
    /// - Booking ID (for PDF download)
    /// - Outing type (weekend/holiday)
    /// - Check-out date and time
    /// - Expected check-in date and time
    /// - Destination information
    /// - Booking status (confirmed/pending/cancelled)
    /// - Emergency contact details
    /// - Mode of transport
    /// - Booking timestamp
    ///
    /// # Errors
    ///
    /// This function will return an error if:
    /// - The session is not authenticated (`VtopError::SessionExpired`)
    /// - Network communication fails (`VtopError::NetworkError`)
    /// - The VTOP server returns an error response (`VtopError::VtopServerError`)
    /// - Session expires during the request and re-authentication fails
    ///
    /// # Examples
    ///
    /// ```
    /// # async fn example(client: &mut VtopClient) -> Result<(), Box<dyn std::error::Error>> {
    /// let weekend_outings = client.get_weekend_outing_reports().await?;
    /// for outing in weekend_outings {
    ///     println!("Checkout: {}", outing.checkout_date);
    ///     println!("Expected return: {}", outing.checkin_date);
    ///     println!("Status: {}", outing.status);
    /// }
    /// # Ok(())
    /// # }
    /// ```
    pub async fn get_weekend_outing_reports(&mut self) -> VtopResult<Vec<WeekendOutingRecord>> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!("{}/vtop/hostel/StudentWeekendOuting", self.config.base_url);
        let body = format!(
            "verifyMenu=true&_csrf={}&authorizedID={}&nocache=@(new Date().getTime())",
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
            self.username
        );

        let res = self
            .client
            .post(url)
            .body(body)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;

        // Check for session expiration and auto re-authenticate if needed
        self.handle_session_check(&res).await?;

        let text = res.text().await.map_err(|_| VtopError::VtopServerError)?;
        let hostel_data = parser::hostel::weekend_outing_parser::parse_hostel_outing(text);
        Ok(hostel_data)
    }

    /// Downloads the PDF pass for a specific weekend outing booking.
    ///
    /// Retrieves the official weekend outing pass document in PDF format. This pass must be
    /// shown to hostel security when leaving for a weekend outing and upon return. The PDF
    /// includes student details, outing dates, emergency contacts, and approval information.
    ///
    /// # Arguments
    ///
    /// * `booking_id` - The unique identifier of the weekend outing booking (obtained from `get_weekend_outing_reports()`)
    ///
    /// # Returns
    ///
    /// Returns a `VtopResult<Vec<u8>>` containing the PDF file as a byte vector that can be:
    /// - Saved to disk as a `.pdf` file
    /// - Displayed in a PDF viewer
    /// - Shared with parents or guardians
    /// - Shown to security personnel
    ///
    /// # Errors
    ///
    /// This function will return an error if:
    /// - The session is not authenticated (`VtopError::SessionExpired`)
    /// - The provided booking ID is invalid or not found
    /// - The booking is not yet confirmed (may return empty/error)
    /// - Network communication fails (`VtopError::NetworkError`)
    /// - The VTOP server returns an error response (`VtopError::VtopServerError`)
    /// - Session expires during the request and re-authentication fails
    ///
    /// # Examples
    ///
    /// ```
    /// # async fn example(client: &mut VtopClient) -> Result<(), Box<dyn std::error::Error>> {
    /// // Get weekend outing records
    /// let outings = client.get_weekend_outing_reports().await?;
    /// 
    /// // Download PDF for a confirmed booking
    /// if let Some(outing) = outings.iter().find(|o| o.status == "Confirmed") {
    ///     let pdf_bytes = client.get_hostel_outing_pdf(outing.booking_id.clone()).await?;
    ///     
    ///     // Save to file
    ///     std::fs::write("weekend_pass.pdf", pdf_bytes)?;
    ///     println!("Weekend pass downloaded");
    /// }
    /// # Ok(())
    /// # }
    /// ```
    pub async fn get_hostel_outing_pdf(&mut self, booking_id: String) -> VtopResult<Vec<u8>> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!(
            "{}/vtop/hostel/downloadOutingForm/{}?authorizedID={}&_csrf={}&x={}",
            self.config.base_url,
            booking_id,
            self.username,
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
            chrono::Utc::now().to_rfc2822()
        );

        let res = self
            .client
            .get(url)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;

        // Check for session expiration and auto re-authenticate if needed
        self.handle_session_check(&res).await?;

        let bytes = res.bytes().await.map_err(|_| VtopError::VtopServerError)?;
        Ok(bytes.to_vec())
    }

    /// Submits a new general outing application form to VTOP.
    ///
    /// Creates a new day outing application with the provided details. The application will
    /// be submitted to the hostel administration for approval. Students typically need approval
    /// before leaving campus for general outings during weekdays.
    ///
    /// # Arguments
    ///
    /// * `purpose_of_visit` - The reason for the outing (e.g., "Medical appointment", "Shopping", "Family visit")
    /// * `outing_date` - The date of the outing in the format expected by VTOP (usually "DD-MM-YYYY")
    /// * `contact_number` - Student's contact number during the outing
    /// * `out_place` - Destination or place to be visited
    /// * `out_time` - Expected departure time (usually in "HH:MM" format)
    ///
    /// # Returns
    ///
    /// Returns a `VtopResult<String>` containing the server response message, which typically includes:
    /// - Success/failure status
    /// - Application reference number
    /// - Approval status or pending message
    ///
    /// # Errors
    ///
    /// This function will return an error if:
    /// - The session is not authenticated (`VtopError::SessionExpired`)
    /// - Required student profile fields are missing (auto-populated fields may be empty)
    /// - The outing date/time format is invalid
    /// - Network communication fails (`VtopError::NetworkError`)
    /// - The VTOP server rejects the application (`VtopError::VtopServerError`)
    /// - Session expires during the request and re-authentication fails
    ///
    /// # Notes
    ///
    /// Some fields like `name`, `gender`, `hostelBlock`, and `roomNo` are auto-populated by the
    /// server based on the authenticated student's profile. These are sent as empty strings
    /// in the current implementation.
    ///
    /// # Examples
    ///
    /// ```
    /// # async fn example(client: &mut VtopClient) -> Result<(), Box<dyn std::error::Error>> {
    /// // Submit a general outing application
    /// let response = client.submit_outing_form(
    ///     "Medical checkup at Apollo Hospital".to_string(),
    ///     "15-03-2024".to_string(),
    ///     "9876543210".to_string(),
    ///     "Apollo Hospital, Vijayawada".to_string(),
    ///     "14:00".to_string(),
    /// ).await?;
    /// 
    /// println!("Application response: {}", response);
    /// # Ok(())
    /// # }
    /// ```
    ///
    /// ```
    /// # async fn example2(client: &mut VtopClient) -> Result<(), Box<dyn std::error::Error>> {
    /// // Submit for shopping trip
    /// let response = client.submit_outing_form(
    ///     "Shopping for essentials".to_string(),
    ///     "20-03-2024".to_string(),
    ///     "9123456789".to_string(),
    ///     "PVP Mall, Vijayawada".to_string(),
    ///     "16:30".to_string(),
    /// ).await?;
    /// 
    /// if response.contains("success") {
    ///     println!("Outing application submitted successfully");
    /// }
    /// # Ok(())
    /// # }
    /// ```
    pub async fn submit_outing_form(
        &mut self,
        purpose_of_visit: String,
        outing_date: String,
        contact_number: String,
        out_place: String,
        out_time: String,
    ) -> VtopResult<String> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!("{}/vtop/hostel/saveOutingForm", self.config.base_url);

        let form = multipart::Form::new()
            .text(
                "_csrf",
                self.session
                    .get_csrf_token()
                    .ok_or(VtopError::SessionExpired)?,
            )
            .text("authorizedID", self.username.clone())
            .text("regNo", self.username.clone())
            .text("name", "") // This might need to be dynamic
            .text("applicationNo", "") // This might need to be dynamic
            .text("gender", "") // This might need to be dynamic
            .text("hostelBlock", "") // This might need to be dynamic
            .text("roomNo", "") // This might need to be dynamic
            .text("outPlace", out_place)
            .text("purposeOfVisit", purpose_of_visit)
            .text("outingDate", outing_date)
            .text("outTime", out_time)
            .text("contactNumber", contact_number)
            .text("parentContactNumber", "") // This might need to be dynamic
            .text("x=", chrono::Utc::now().to_rfc2822());

        let res = self
            .client
            .post(url)
            .multipart(form)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;

        // Check for session expiration and auto re-authenticate if needed
        self.handle_session_check(&res).await?;

        let text = res.text().await.map_err(|_| VtopError::VtopServerError)?;
        Ok(text)
    }
}
