import azure.functions as func
import json

def main(req: func.HttpRequest) -> func.HttpResponse:
    data = {"message": "Hello from Azure Function API!"}
    return func.HttpResponse(json.dumps(data), mimetype="application/json")
