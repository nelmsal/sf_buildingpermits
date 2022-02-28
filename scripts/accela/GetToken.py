import urllib
import json
import sys

# Scope below limits what the token will provide access to.
# They are listed in the API reference for each request
# - e.g. to use the API to request records you need to include 'records' or 'search_records' (depending on which API call you use).

def get_request(url, parameters, headers):
    if parameters!=None:
        parameters = urllib.parse.urlencode(parameters).encode("utf-8")
    req = urllib.request.Request(url, parameters, headers)
    with urllib.request.urlopen(req) as response:
        the_page = response.read()
        d = json.loads(the_page)
    return d

access_token_location = r'./Admin/AccelaAccessToken.txt'
refresh_token_location = r'./Admin/AccelaRefreshToken.txt'

ACCESS_URL = r'https://auth.accela.com/oauth2/token'

def SetToken(
    agency='', environment='PROD', scope="records parcels",
    app_type='citizen', grant_type='password'
    ):

    contentType = 'application/x-www-form-urlencoded'
    headers = { 'Content-Type' : contentType }

    parameters = {
        'grant_type'      : grant_type,
        'scope'           : scope,
            }

    from accela.GetAppInfo import GetAppUserInfo
    info_parameters = GetAppUserInfo(app_type = app_type)
    parameters.update(info_parameters)

    if agency != '':
        parameters['agency_name'] = agency
        ##'ccsf',
    if environment != '':
        parameters['environment'] = environment
        ##'PROD'

    token_response = get_request(ACCESS_URL, parameters, headers)

    AccessToken = token_response['access_token']
    RefreshToken = token_response['refresh_token']

    tokenfile = open(access_token_location, "w")
    tokenfile.write(AccessToken)
    tokenfile.close()

    tokenfile = open(refresh_token_location, "w")
    tokenfile.write(RefreshToken)
    tokenfile.close()

def GetToken(type='Access', location=''):
    if type=='Access':
        location = access_token_location
    elif type=='Refresh':
        location = refresh_token_location
    with open(location) as f:
        return f.read()