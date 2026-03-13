import json
import os
import boto3
from datetime import datetime
from botocore.exceptions import ClientError

print("=== LAMBDA INIT ===")

# ====================
# AWS Clients
# ====================
translate = boto3.client("translate")  # Amazon Translate
dynamodb = boto3.resource("dynamodb")

# ====================
# Environment Variables
# ====================
TABLE_NAME = os.environ["TABLE_NAME"]
SOURCE_LANG = os.environ.get("SOURCE_LANG", "ja")
TARGET_LANG = os.environ.get("TARGET_LANG", "es")
MAX_CHARS = int(os.environ.get("MAX_CHARS_PER_REQUEST", "500"))
MONTHLY_LIMIT = int(os.environ.get("MONTHLY_FREE_LIMIT", "100000"))

table = dynamodb.Table(TABLE_NAME)

# ====================
# Response helper
# ====================
def response(status_code: int, body: dict):
    return {
        "statusCode": status_code,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
        },
        "body": json.dumps(body, ensure_ascii=False),
    }

# ====================
# Lambda Handler
# ====================
def lambda_handler(event, context):
    print("=== LAMBDA START ===")
    print("EVENT:", json.dumps(event, ensure_ascii=False))

    try:
        # --------------------
        # Parse request body
        # --------------------
        raw_body = event.get("body") or "{}"
        print("RAW BODY:", raw_body)

        body = json.loads(raw_body)

        text = (body.get("text") or "").strip()
        source = body.get("source", SOURCE_LANG)
        target = body.get("target", TARGET_LANG)

        print("TEXT:", text)
        print("SOURCE:", source, "TARGET:", target)

        # 仮ユーザー（将来 Cognito など）
        user_id = "guest"
        month = datetime.utcnow().strftime("%Y-%m")

        # --------------------
        # Validation
        # --------------------
        if not text:
            return response(400, {"error_code": "EMPTY_TEXT"})

        if len(text) > MAX_CHARS:
            return response(400, {"error_code": "TEXT_TOO_LONG"})

        text_length = len(text)

        # --------------------
        # Get current usage
        # --------------------
        try:
            result = table.get_item(
                Key={
                    "userId": user_id,
                    "month": month
                }
            )
            used_chars = result.get("Item", {}).get("usedChars", 0)
        except ClientError as e:
            print("DynamoDB GetItem error:", e)
            used_chars = 0

        print("USED CHARS:", used_chars)

        # --------------------
        # Monthly limit check
        # --------------------
        if used_chars + text_length > MONTHLY_LIMIT:
            return response(403, {
                "error_code": "MONTHLY_LIMIT_EXCEEDED"
            })

        # --------------------
        # Translate
        # --------------------
        try:
            translate_result = translate.translate_text(
                Text=text,
                SourceLanguageCode=source,
                TargetLanguageCode=target
            )
        except ClientError as e:
            print("Translate ERROR:", e)
            return response(502, {"error_code": "TRANSLATE_ERROR"})

        translated_text = translate_result["TranslatedText"]
        print("TRANSLATED:", translated_text)

        # --------------------
        # Update DynamoDB
        # --------------------
        try:
            table.update_item(
                Key={
                    "userId": user_id,
                    "month": month
                },
                UpdateExpression="ADD usedChars :inc",
                ExpressionAttributeValues={
                    ":inc": text_length
                }
            )
        except ClientError as e:
            print("DynamoDB UpdateItem ERROR:", e)
            return response(500, {"error_code": "DYNAMODB_ERROR"})

        # --------------------
        # Success
        # --------------------
        return response(200, {
            "translatedText": translated_text,
            "source": source,
            "target": target
        })

    except Exception as e:
        print("UNEXPECTED ERROR:", e)
        return response(500, {"error_code": "INTERNAL_ERROR"})