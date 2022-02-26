import urllib
import json
import sys

# Scope below limits what the token will provide access to.
# They are listed in the API reference for each request
# - e.g. to use the API to request records you need to include 'records' or 'search_records' (depending on which API call you use).

def SetToken(app_info_path, user_info_path):
    token_location = r'./Admin/AccelaToken.txt'

    url = 'https://auth.accela.com/oauth2/token'

    contentType = 'application/x-www-form-urlencoded'

    from Accela.GetLoginInfo import get_app_info
    app_id, app_secret = get_app_info(app_info_path)

    from Accela.GetUserInfo import get_user_info
    username, password = get_user_info(user_info_path)

    values = {
        'grant_type'      : 'password',
        'client_id'       : app_id,           #'635519551732860453',
        'client_secret'   : app_secret,           #'da4d29c285cf4f77b017811d86372863',
        'username'        : username,
        #'MyAccelaUser',
        'password'        : password,
        #'MyAccelaPassword',
        'scope'           : '',
        #'parcels
        ## get_record_workflow_task_histories get_record_workflow_task_statuses get_conditions_standard documents search_records global_search search_parcels get_record_workflow_task_histories get_record_parcels get_records records get_document get_record_documents get_record_parcels get_contacts get_settings_department_staffs search_professionals get_settings_departments open_data_query get_record_activities get_record_customtable get_record_customforms run_emse_script',
        'agency_name'     : '',
        #'ccsf',
        'environment'     : ''
        #'PROD'
            }
            
    headers = { 'Content-Type' : contentType }

    data = urllib.urlencode(values)
    req = urllib.Request(url, data, headers)
    response = urllib.urlopen(req)
    the_page = response.read()
    d = json.loads(the_page)

    theToken=d['access_token']
    print( d['access_token'])
    tokenfile = open(token_location, "w")
    tokenfile.write(theToken)
    tokenfile.close()
