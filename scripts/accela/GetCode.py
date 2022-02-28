import urllib
import json
import sys

# Scope below limits what the token will provide access to.
# They are listed in the API reference for each request
# - e.g. to use the API to request records you need to include 'records' or 'search_records' (depending on which API call you use).

def GetAppUserInfo(app_info_path, user_info_path, app_type = 'citizen'):
    from accela.GetLoginInfo import get_app_info
    app_id, app_secret = get_app_info(app_info_path, app_type=app_type)

    from accela.GetUserInfo import get_user_info
    username, password = get_user_info(user_info_path)

    return app_id, app_secret, username, password


def SetToken(app_info_path, user_info_path, agency='', app_type='citizen', db_env='PROD', token_location = r'./Admin/AccelaToken.txt', grant_type='token'):
    url = 'https://auth.accela.com/oauth2/token'

    contentType = 'application/x-www-form-urlencoded'

    app_id, app_secret, username, password = GetAppUserInfo(app_info_path, user_info_path, app_type = app_type)

    values = {
        'grant_type'      : grant_type,
        'client_id'       : app_id,           #'635519551732860453',
        'client_secret'   : app_secret,           #'da4d29c285cf4f77b017811d86372863',
        'username'        : username,
        #'MyAccelaUser',
        'password'        : password,
        #'MyAccelaPassword',
        'scope'           : "records parcels"
        #'parcels
        ## get_record_workflow_task_histories get_record_workflow_task_statuses get_conditions_standard documents search_records global_search search_parcels get_record_workflow_task_histories get_record_parcels get_records records get_document get_record_documents get_record_parcels get_contacts get_settings_department_staffs search_professionals get_settings_departments open_data_query get_record_activities get_record_customtable get_record_customforms run_emse_script',
            }

    if agency != '' or app_type != 'citizen':
        values['agency_name'] = agency
        ##'ccsf',
    if db_env != '' or app_type != 'citizen':
        values['environment'] = db_env
        ##'PROD'

    headers = { 'Content-Type' : contentType }

    data = urllib.parse.urlencode(values).encode("utf-8")
    req = urllib.request.Request(url, data, headers)
    with urllib.request.urlopen(req) as response:
        #htmlSource = response.read()
        the_page = response.read()
        d = json.loads(the_page)

    theToken=d['access_token']
    print( d['access_token'])
    tokenfile = open(token_location, "w")
    tokenfile.write(theToken)
    tokenfile.close()

def GetToken(token_location = r'./Admin/AccelaToken.txt'):
    with open(token_location) as f:
        return f.read()