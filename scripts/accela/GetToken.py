import urllib
import json
import sys

from accela.AccelaRequest import *

# Scope below limits what the token will provide access to.
# They are listed in the API reference for each request
# - e.g. to use the API to request records you need to include 'records' or 'search_records' (depending on which API call you use).

access_token_path = r'./Admin/AccelaAccessToken.txt'
refresh_token_path = r'./Admin/AccelaRefreshToken.txt'

TOKEN_URL = r'https://auth.accela.com/oauth2/token'

def openwrite(path, data):
    tokenfile = open(path, "w")
    tokenfile.write(data)
    tokenfile.close()

def SetToken(
    agency_info={}, agency='', environment='', scope="records parcels",
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

    # get agency info
    ## replace agency info dict with direct variables
    if 'agency' in agency_info.keys():
        agency_info['agency_name'] = agency_info['agency']
        agency_info.pop('agency')
    if agency != '':
        agency_info['agency_name'] = agency
    if environment != '':
        agency_info['environment'] = environment
    parameters.update(agency_info)

    token_response = get_request(TOKEN_URL, parameters, headers)

    AccessToken = token_response['access_token']
    openwrite(access_token_path, AccessToken)

    RefreshToken = token_response['refresh_token']
    openwrite(refresh_token_path, RefreshToken)

def GetToken(type='Access', path=''):
    if type=='Access':
        path = access_token_path
    elif type=='Refresh':
        path = refresh_token_path
    with open(path) as f:
        return f.read()