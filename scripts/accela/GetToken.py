import urllib
import json
import sys

# Scope below limits what the token will provide access to.
# They are listed in the API reference for each request
# - e.g. to use the API to request records you need to include 'records' or 'search_records' (depending on which API call you use).

access_token_location = r'./Admin/AccelaAccessToken.txt'
refresh_token_location = r'./Admin/AccelaRefreshToken.txt'

ACCESS_URL = r'https://auth.accela.com/oauth2/token'

def SetToken(
    agency='', environment='PROD', scope="records parcels",
    app_type='citizen', grant_type='password'
    ):

    contentType = 'application/x-www-form-urlencoded'
    headers = { 'Content-Type' : contentType }

    values = {
        'grant_type'      : grant_type,
        #'MyAccelaPassword',
        'scope'           : scope,
            }

    from accela.GetAppInfo import GetAppUserInfo
    info_values = GetAppUserInfo(app_type = app_type)
    values.update(info_values)

    if agency != '' or app_type != 'citizen':
        values['agency_name'] = agency
        ##'ccsf',
    if environment != '':
        values['environment'] = environment
        ##'PROD'

    data = urllib.parse.urlencode(values).encode("utf-8")
    req = urllib.request.Request(ACCESS_URL, data, headers)
    with urllib.request.urlopen(req) as response:
        the_page = response.read()
        d = json.loads(the_page)

    AccessToken = d['access_token']
    RefreshToken = d['refresh_token']

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