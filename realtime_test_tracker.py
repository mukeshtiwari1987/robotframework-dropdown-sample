import requests
import os
ROBOT_LISTENER_API_VERSION = 2

# JOB_NAME = "stray_job"
# WEBHOOK = "http://192.168.53.7:9200/robotframework-dropdown-sample/" + JOB_NAME
ELK_HOST = "http://192.168.53.7:9200"
os.environ["JOB_NAME"] = "robotframework_dropdown_sample3"
JOB_NAME = os.getenv('JOB_NAME').lower()
HOST_NAME = os.uname()[1]
BUILD_NUMBER = "2"
WEBHOOK = ELK_HOST + "/" + JOB_NAME + "/" + HOST_NAME + "/" + BUILD_NUMBER

# def start_suite(name, attrs):
#     json_data = {'suite_name': name,
#     'longname':attrs['longname'],
#     'tests':attrs['tests'],
#     'totaltests':attrs['totaltests'],
#     'suite_starttime':attrs['starttime']
#     }
#     response = requests.post(WEBHOOK, json=json_data)
#     print(response)

# def end_suite(name, attrs):
#     json_data = {}
#     response = requests.post(WEBHOOK, json=json_data)
#     print(response)

# def start_test(name, attrs):
#     json_data = {'test_name':name,
#     'longname':attrs['longname'],
#     'originalname':attrs['originalname'],
#     'tags':attrs['tags'],
#     'template':attrs['template'],
#     'lineno':attrs['lineno'],
#     'starttime':attrs['starttime']
#     }
#     response = requests.post(WEBHOOK, json=json_data)
#     print(response)

def end_test(name, attrs):
    json_data = {'test_name':name,
    'longname':attrs['longname'],
    'originalname':attrs['originalname'],
    'tags':attrs['tags'],
    'template':attrs['template'],
    'lineno':attrs['lineno'],
    'starttime':attrs['starttime'],
    'endtime':attrs['endtime'],
    'elapsedtime':attrs['elapsedtime'],
    'status':attrs['status'],
    'message':attrs['message']
    }
    response = requests.post(WEBHOOK, json=json_data)
    print(response)
