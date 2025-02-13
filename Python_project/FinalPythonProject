from flask import Flask, request, jsonify
import requests
from requests.auth import HTTPBasicAuth
import json

app = Flask(__name__)

# Jira API Configuration
JIRA_API_TOKEN="xxx"
JIRA_EMAIL = "xxxx@gmail.com"  # <---Replace with your Jira email
JIRA_URL = "your JIRA URL"

JIRA_AUTH = HTTPBasicAuth(JIRA_EMAIL, JIRA_API_TOKEN)

HEADERS = {
    "Accept": "application/json",
    "Content-Type": "application/json"
}

@app.route("/", methods=["POST", "GET"])
def process_github_webhook():
    if request.method == "GET":
        return jsonify({"message": "Use POST to trigger Jira ticket creation."})

    data = request.json  # Extract JSON payload from GitHub

    # Validate the GitHub webhook payload
    if not data or "comment" not in data:
        return jsonify({"error": "Invalid GitHub webhook payload. No comment found."}), 400

    comment_body = data["comment"].get("body", "").strip()

    # Only proceed if the comment contains "/jira"
    if comment_body == "/jira":
        payload = json.dumps({
            "fields": {
                "project": {"key": "CPG"},
                "summary": "Jira Ticket from GitHub Comment",
                "description": {
                    "type": "doc",
                    "version": 1,
                    "content": [
                        {
                            "type": "paragraph",
                            "content": [
                                {"type": "text", "text": "This issue is created via GitHub webhook."}
                            ]
                        }
                    ]
                },
                "issuetype": {"name": "Task"}
            }
        })

        response = requests.post(JIRA_URL, data=payload, headers=HEADERS, auth=JIRA_AUTH)

        return jsonify(response.json()), response.status_code  # Return Jira response

    return jsonify({"message": "Please comment /jira to create a Jira ticket"}), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

