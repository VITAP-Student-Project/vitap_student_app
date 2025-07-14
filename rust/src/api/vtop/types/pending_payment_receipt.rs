use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb(json_serializable)]
#[frb]
pub struct PendingPaymentReceipt {
    pub s_no: String,
    pub fprefno: String,
    pub fees_heads: String,
    pub end_date: String,
    pub amount: String,
    pub fine: String,
    pub total_amount: String,
    pub payment_status: String, // Always "Unpaid"
}
