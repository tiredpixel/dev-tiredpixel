# Establish session, replacing endpoint if not London.
curl -X POST https://lon.identity.api.rackspacecloud.com/v2.0/tokens -d '{ "auth":{ "RAX-KSKEY:apiKeyCredentials":{ "username":"USERNAME", "apiKey":"APIKEY" } } }' -H "Content-type: application/json"

# Use returned JSON and CONTAINER_NAME to direct */ to */index.html.
curl -X POST -H "X-Container-Meta-Web-Index: index.html" -H "X-Auth-Token: ACCESS_TOKEN_ID" "ACCESS_SERVICECATALOG_ENDPOINTS_PUBLICURL/CONTAINER_NAME/"
