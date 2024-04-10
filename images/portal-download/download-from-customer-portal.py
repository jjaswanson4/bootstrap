import requests
import yaml
import os

def generate_access_token(offline_token):
    url = 'https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/token'
    data = {
        'grant_type': 'refresh_token',
        'client_id': 'rhsm-api',
        'refresh_token': offline_token
    }
    response = requests.post(url, data=data)
    if response.status_code == 200:
        return response.json()['access_token']
    else:
        print(f"Failed to generate access token. Status code: {response.status_code}")
        return None

def download_file(name, checksum, access_token):
    output_file = f"/workdir/{name}"
    url = f'https://api.access.redhat.com/management/v1/images/{checksum}/download'
    headers = {
        'Authorization': f'Bearer {access_token}'
    }
    
    response = requests.get(url, headers = headers)
    
    if response.status_code == 200:
        with open(output_file, 'wb') as file:
            file.write(response.content)
        print(f"Downloaded {name} to {output_file}")
    else:
        return False

def main():

    # Collect up env vars
    offline_token = os.environ.get('OFFLINE_TOKEN')
    downloads_file = os.environ.get('DOWNLOADS')
    
    # Get online token with offline token
    access_token = generate_access_token(offline_token)

    with open(downloads_file, 'r') as file:
        downloads = yaml.safe_load(file)

        for item in downloads:
            name = item.get('name')
            checksum = item.get('sha256')
            download_file(name, checksum, access_token)

if __name__ == "__main__":
    main()
