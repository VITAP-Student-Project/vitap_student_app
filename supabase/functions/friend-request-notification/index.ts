import { createClient } from 'npm:@supabase/supabase-js@2'
import { JWT } from 'npm:google-auth-library@9'

// Define the shape of the database webhook payload
interface WebhookPayload {
  type: 'INSERT' | 'UPDATE'
  table: string
  record: {
    user_a_id: string
    user_b_id: string
    status: 'pending' | 'accepted' | 'rejected'
  }
  old_record?: {
    status: 'pending' | 'accepted' | 'rejected'
  }
}

Deno.serve(async (req) => {
  try {
    const payload: WebhookPayload = await req.json()
    console.log('Webhook received:', payload)

    // Only process inserts (new request) or updates (accepted request)
    const isNewRequest = payload.type === 'INSERT' && payload.record.status === 'pending'
    const isAcceptedRequest = payload.type === 'UPDATE' && 
                              payload.old_record?.status === 'pending' && 
                              payload.record.status === 'accepted'

    if (!isNewRequest && !isAcceptedRequest) {
      return new Response("Not a triggerable event", { status: 200 })
    }

    // Determine who should receive the notification
    const targetRegNo = isNewRequest ? payload.record.user_b_id : payload.record.user_a_id
    const senderRegNo = isNewRequest ? payload.record.user_a_id : payload.record.user_b_id

    // Initialize Supabase client
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // Fetch the target user's FCM token
    const { data: userData, error } = await supabaseClient
      .from('users')
      .select('fcm_token')
      .eq('reg_no', targetRegNo)
      .single()

    if (error || !userData?.fcm_token) {
      console.log('Target user has no FCM token. Aborting.')
      return new Response("Target has no FCM token", { status: 200 })
    }

    // Set up the notification content
    const title = isNewRequest ? "New Friend Request!" : "Friend Request Accepted!"
    const body = isNewRequest 
      ? `${senderRegNo} wants to connect and share timetables.` 
      : `${senderRegNo} accepted your friend request.`

    // Initialize Google Auth for Firebase HTTP v1 API
    // (Requires FIREBASE_SERVICE_ACCOUNT base64 string in Supabase Secrets)
    const serviceAccountBase64 = Deno.env.get('FIREBASE_SERVICE_ACCOUNT')
    if (!serviceAccountBase64) {
      throw new Error('FIREBASE_SERVICE_ACCOUNT environment variable is not set')
    }
    
    const serviceAccount = JSON.parse(atob(serviceAccountBase64))
    const auth = new JWT({
      email: serviceAccount.client_email,
      key: serviceAccount.private_key,
      scopes: ['https://www.googleapis.com/auth/firebase.messaging'],
    })

    const { token: accessToken } = await auth.getAccessToken()
    const projectId = serviceAccount.project_id

    // Send the push notification via Firebase FCM v1 API
    const fcmRes = await fetch(
      `https://fcm.googleapis.com/v1/projects/${projectId}/messages:send`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${accessToken}`,
        },
        body: JSON.stringify({
          message: {
            token: userData.fcm_token,
            notification: {
              title,
              body,
            },
            data: {
              click_action: "FLUTTER_NOTIFICATION_CLICK",
              route: "/connect",
            },
          },
        }),
      }
    )

    const fcmResult = await fcmRes.json()
    console.log('FCM Send Result:', fcmResult)

    return new Response(JSON.stringify({ success: true, result: fcmResult }), {
      headers: { 'Content-Type': 'application/json' },
    })
  } catch (err) {
    console.error('Error processing webhook:', err)
    return new Response("Internal Server Error", { status: 500 })
  }
})
