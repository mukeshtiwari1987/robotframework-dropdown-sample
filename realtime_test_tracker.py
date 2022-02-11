import requests

ROBOT_LISTENER_API_VERSION = 2
WEBHOOK = "https://rfui.requestcatcher.com/test"

def start_suite(name, attrs):
    json_data = {'test_name':str(name),
                'suite_starttime': str({attrs['starttime']})
                }
    response = requests.post(WEBHOOK, json=json_data)
    print(response)

def end_suite(name, attrs):
    json_data = {'test_name':str(name),
                'suite_endtime': str({attrs['endtime']})
                }
    response = requests.post(WEBHOOK, json=json_data)
    print(response)

def start_test(name, attrs):
    json_data = {'test_name':str(name),
                'test_starttime': str({attrs['starttime']})
                }
    response = requests.post(WEBHOOK, json=json_data)
    print(response)

def end_test(name, attrs):
    json_data = {'test_name':str(name),
                'test_endtime': str({attrs['endtime']})
                }
    response = requests.post(WEBHOOK, json=json_data)
    print(response)
