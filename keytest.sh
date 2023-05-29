#!/usr/bin/zsh

RED='\033[0;31m'
GREEN='\033[0;32m'
NOCOLOR='\033[0;0m'
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

#title
padding="********************************************"
owner="Scripted by Jestin Gigi"
flag='y'

cols=$(tput cols)
printf "%*s\n\n" $((( ${#padding} + $cols )/2)) "$padding"
printf  "%*s\n" $((( ${#padding} + $cols )/2)) "$padding"

figlet -cptf slant < ./head.txt | lolcat  -a -F .4 -s 50 #Title formatting 

printf "%*s\n" $((( ${#padding} + $cols )/2)) "$padding"
printf "%*s\n" $((( ${#owner} + $cols )/2)) "$owner" | lolcat
printf "%*s\n" $((( ${#padding} + $cols )/2)) "$padding"

#Menu
while :
do

echo -e "Menu:" 

echo -e "\n[1] Slack API token\n[2] Facebook Access token\n[3] Twitter API Secret\n[4] HubSpot API key\n[5] New Relic REST API\n[6] Dropbox API\n[7] FreshDesk API Key\n[8] Heroku API key\n[9] Twitter Bearer token\n[10] Azure Application Insights APP ID and API Key\n[11] Bing Map API key\n[12] Youtube API key\n[13] Zendesk Access Token\n[14] Google Map API key"

echo -n -e "\nYour choice: "
read opt
mkdir Result

if [ $opt -eq 1 ]; #Slack API token 
then 
	echo -n -e  "\nEnter the token: "
	read token
	echo ""
	curl -sX POST "https://slack.com/api/auth.test?token=xoxp-${token}&pretty=1" > ./Result/slack_response.json
	if grep -q '"ok": true' "./Result/slack_response.json"; 
	then
		echo -e "\nResult: The provided token is ${GREEN}${BOLD}valid${NORMAL}${NOCOLOR}" 
	else
		echo -e "\nResult: The provided token is ${RED}${BOLD}invalid${NORMAL}${NOCOLOR}"
	fi
	echo "The response has been saved to ./Result/slack_response.json"
elif [ $opt -eq 2 ]; #Facebook Access token 
then 
	echo -n -e "\nEnter Access token: " 
	read token 
	echo ""
	echo  "Go to this link: https://developers.facebook.com/tools/debug/accesstoken/?access_token=${token}&version=v3.2"
elif [ $opt -eq 3 ]; #Twitter API Secret 
then 
	echo -n -e "\nEnter API key: "
	read api
	echo -n -e "\nEnter API secret key: "
	read secret
	echo ""
	curl -u "${api}:${secret}" --data "grant_type=client_credentials" "https://api.twitter.com/oauth2/token" > ./Result/twitter_response.json
	if grep -q "access_token" "./Result/twitter_response.json"; 
        then
        echo -e "\nResult: The provided keys are ${GREEN}${BOLD}valid${NORMAL}${NOCOLOR}" 
        else
        echo -e "\nResult: The provided keys are ${RED}${BOLD}invalid${NORMAL}${NOCOLOR}"
        fi
	echo "The response has been saved to ./Result/twitter_response.json"
elif [ $opt -eq 4 ]; #HubSpot API Key 
then
	echo -n -e "\nEnter key: " 
	read key
	echo ""
	curl https://api.hubapi.com/owners/v2/owners?hapikey=$key > ./Result/hubspot_response_owners.json
	curl https://api.hubapi.com/contacts/v1/lists/all/contacts/all?hapikey=$key > ./Result/hubspot_response_contacts.json
	if grep -q '"createdAt"' "./Result/hubspot_response_contacts.json"; 
        then
                echo -e "\nThe provided key is ${GREEN}${BOLD}valid${NORMAL}${NOCOLOR}"
        else
                echo -e "\nThe provided key is ${RED}${BOLD}invalid${NORMAL}${NOCOLOR}"
        fi
	echo "The response has been saved to ./Result/hubspot_response_owners.json and response of contacts to ./Result/hubspot_response_contacts.json"
elif [ $opt -eq 5 ]; #New Relic REST API
then 
	echo  -e -n "\nEnter API key: "
	read key
	echo ""
	curl -X GET 'https://api.newrelic.com/v2/applications.json' -H "X-Api-Key:${key}" -i > ./Result/newrelic_response.json
	if grep -q "applications" "./Result/newrelic_response.json"; 
        then
		echo -e "\nThe provided key is ${GREEN}${BOLD}valid${NORMAL}${NOCOLOR}"
	else
		echo -e "${RED}\nThe provided key is ${RED}${BOLD}valid${NORMAL}${NOCOLOR}"
	fi
	echo "The response has been saved to ./Result/newrelic_response.json"
	echo "For more reference go to - https://docs.newrelic.com/docs/apis/rest-api-v2/application-examples-v2/list-your-app-id-metric-timeslice-data-v2"
elif [ $opt -eq 6 ]; #Dropbox API
then 
	echo -e -n "\nEnter token: "
	read token
	echo ""
	curl -X POST https://api.dropboxapi.com/2/users/get_current_account --header "Authorization: Bearer ${token}" > ./Result/Dropbox_response.json	
	if grep -q "account_id" "./Result/Dropbox_response.json"; 
        then
		echo -e "\nThe provided token is ${GREEN}${BOLD}valid${NORMAL}${NOCOLOR}"
	else
		echo -e "${RED}\nThe provided token is ${RED}${BOLD}valid${NORMAL}${NOCOLOR}"
	fi
	echo "The response has been saved to ./Result/Dropbox_response.json"
elif [ $opt -eq 7 ]; #Freshdesk API Key 
then 
	echo -e -n "\nEnter API Key: "
	read key
	echo -e -n "\nEnter domain name(<domain_name>freshdesk.com): "
	read domain
	echo ""
	curl -u $key:X -H "Content-Type: application/json" -X GET "https://${domain}.freshdesk.com/api/v2/tickets" > ./Result/fresh_response.json
	if grep -q '"created_at"' "./Result/fresh_response.json"; 
        then
		echo -e "\nThe API key is ${GREEN}${BOLD}valid${NORMAL}${NOCOLOR}"
	else
		echo -e "${RED}\nThe API key is ${RED}${BOLD}valid${NORMAL}${NOCOLOR}"
	fi
	echo "The response has been saved to ./Result/fresh_response.json"
elif [ $opt -eq 8 ]; #Heroku API Key 
then 
	echo -e -n "\nEnter API key: "
	read key 
	echo ""
	curl -X POST https://api.heroku.com/apps -H "Accept: application/vnd.heroku+json; version=3" -H "Authorization: Bearer $key" > ./Result/heroku_response.json
	if grep -q "created_at" "./Result/heroku_response.json"; 
        then
                echo -e "\nThe API key is ${GREEN}${BOLD}valid${NORMAL}${NOCOLOR}"
        else
                echo -e "${RED}\nThe API key is ${RED}${BOLD}valid${NORMAL}${NOCOLOR}"
        fi
	echo "The response has been saved to ./Result/heroku_response.json"
elif  [ $opt -eq 9 ]; #Twitter Bearer token
then
	echo -e -n "\nEnter Bearer token: "
	read token 
	echo ""
	curl --request GET --url https://api.twitter.com/1.1/account_activity/all/subscriptions/count.json --header "authorization: $token" > ./Result/twitter_bearer.json
	if grep -q '"valid": true' "./Result/twitter_bearer.json"; 
        then
                echo -e "\nThe API key is ${GREEN}${BOLD}valid${NORMAL}${NOCOLOR}"
        else
                echo -e "${RED}\nThe API key is ${RED}${BOLD}valid${NORMAL}${NOCOLOR}"
        fi
        echo "The response has been saved to ./Result/twitter_bearer.json"
elif [ $opt -eq 10 ]; #Azure Application Insights APP ID and API Key 
then 
	echo -e -n "\nEnter API key: " 
	read key 
	echo -e -n "\nEnter APP ID: " 
	read id 
	echo ""
	curl "https://api.applicationinsights.io/v1/apps/${id}/metrics/requests/duration?timespan=PT6H&interval=PT1H" -H "x-api-key:${key}" > ./Result/azure_response.json 
	if grep -q '"PathNotFoundError"' "./Result/azure_response.json"; 
	then
                echo "The API ID is not ${GREEN}${BOLD}valid${NORMAL}${NOCOLOR}"
        elif grep -q '"InsufficientAccessError"' "./Result/azure_response.json";
	then 
		echo -e "\nThe API Key is ${RED}${BOLD}valid${NORMAL}${NOCOLOR}"
	else
		echo -e "${RED}\nThe API key is ${GREEN}${BOLD}valid${NORMAL}${NOCOLOR}" 
        fi
        echo "The response has been saved to ./Result/azure_response.json"
elif [ $opt -eq 11 ]; #Bing Map API key
then 
	echo -n -e "\nEnter API key: "
	read key
	echo ""
	curl "https://dev.virtualearth.net/REST/v1/Locations?CountryRegion=US&adminDistrict=WA&locality=Somewhere&postalCode=98001&addressLine=100%20Main%20St.&key=${key}" > ./Result/bing_response.json
	if grep -q '"authenticationResultCode":"ValidCredentials"' "./Result/bing_response.json"; 
	then
                echo -e "\nThe API key is ${GREEN}${BOLD}valid${NORMAL}${NOCOLOR}"
        else
                echo -e "${RED}The API key is ${RED}${BOLD}valid${NORMAL}${NOCOLOR}$" 
        fi
        echo "The response has been saved to ./Result/bing_response.json"	
elif [ $opt -eq 12 ]; #Youtube API key
then 
	echo -n -e "\nEnter API key: "
	read key
	echo ""
	curl -iLk "https://www.googleapis.com/youtube/v3/activities?part=contentDetails&maxResults=25&channelId=UC-lHJZR3Gqxm24_Vd_AJ5Yw&key=${key}" > ./Result/youtube_response.json
	if grep -q "HTTP/2 200" "./Result/youtube_response.json"; 
        then
                echo -e "\nThe API key is ${GREEN}${BOLD}valid${NORMAL}${NOCOLOR}"
        else
                echo -e "\nThe API key is ${RED}${BOLD}valid${NORMAL}${NOCOLOR}" 
        fi
        echo "The response has been saved to ./Result/youtube_response.json" 
elif [ $opt -eq 13 ]; #Zendesk Access Token
then 
        echo -n -e "\nEnter Access Token: "
        read token
	echo -n -e "\nEnter Subdomain: "
	read subdomain
	echo ""
	curl https://$subdomain.zendesk.com/api/v2/tickets.json  -H "Authorization: Bearer ${token}" > ./Result/zendesk_response.json
        if grep -q '"created_at"' "./Result/zendesk_response.json"; 
        then
                echo -e "\nThe API key is ${GREEN}${BOLD}valid${NORMAL}${NOCOLOR}"
        else
                echo -e "\nThe API key is ${RED}${BOLD}valid${NORMAL}${NOCOLOR}" 
        fi
        echo "The response has been saved to ./Result/zendesk_response.json" 
elif [ $opt -eq 14 ] #GMAP API key
then
	echo -n -e "\nEnter key: "
	read key
	echo ""
	echo $key | python maps_api_scanner.py > ./Result/result_gmap.txt
	cat ./Result/result_gmap.txt
else
	echo -e "\nEnter correct option!!"
	
fi
echo -n -e "\nDo you want to check more APIs(y/n): "
read flag
if [ $flag == 'n' ]
then 
	break	
else
	clear
fi
done
