import requests 
import argparse

def notify_via_ifttt(event, service_key, msg):
    try:
        body = { "value1" : msg}
        resp = requests.post(f"https://maker.ifttt.com/trigger/{event}/with/key/{service_key}", body)
        print(resp.text)
    except Exception as e:
        print("Error while notifying: " + str(e))

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--ifttt_event_name', required=True, help="IFTTT event name.", type=str)
    parser.add_argument('--ifttt_service_key', required=True, help="IFTTT service key.", type=str)
    l = parser.parse_args()
    notify_via_ifttt(l.ifttt_event_name, l.ifttt_service_key, 'testing...')