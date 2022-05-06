import urllib
import json

API_URL = 'https://apis.accela.com'
AUTH_URL = 'https://auth.accela.com'
TOKEN_URL = AUTH_URL + '/oauth2/token'
RECORDS_URL = API_URL + '/v4/records'

def get_workflow_url(record_id):
    WORKFLOW_URL = RECORDS_URL + f'/{record_id}/workflowTasks'
    return WORKFLOW_URL

def get_request(url, parameters, headers):
    if parameters!=None:
        parameters = urllib.parse.urlencode(parameters).encode("utf-8")
    req = urllib.request.Request(url, parameters, headers)
    with urllib.request.urlopen(req) as response:
        the_page = response.read()
        d = json.loads(the_page)
    return d

def AccelaRequest(url, parameters, headers):
    results = get_request(url, parameters, headers)
    print(results['status'])
    return results['result']