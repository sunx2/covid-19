from bottle import get, static_file, run , route, template, url , request
import requests
import os
import json
import datetime

country = json.load(open("countrycodes.json","r"))
thresolds = {
    "HIGH" : [20,100],
    "MEDIUM": [10,20],
    "LOW": [2,10],
    "VERYLOW": [0,2]
}
def date_format(date):
    date = date.split('/')
    date = date[1] + '/' + date[0]
    return date

@route('/res/<filepath:path>', name='res')
def resources(filepath):
    return static_file(filepath, root='./res')

@route("/" , name="homepage")
def homepage():
    return template('index.tpl' , url=url)

@route('/country/<argu>')
def countries(argu):
    url_to_get = f"https://corona.lmao.ninja/v2/historical/{argu}?lastdays=100"
    total_cases_url = f"https://corona.lmao.ninja/countries/{argu}"
    datatosend = {}
    
    data = requests.get(url_to_get).json()
    data_country = requests.get(total_cases_url).json()
    dates = []
    try:
        datatosend['total_cases'] = format(data_country['cases'], ',d')
        datatosend['total_deaths'] = format(data_country['deaths'], ',d')
        datatosend['today_cases'] = format(data_country['todayCases'], ',d')
        datatosend['today_deaths'] = format(data_country['todayDeaths'], ',d')
        datatosend['total_recovered'] = format(data_country['recovered'], ',d')
        new_dict = {}
        new_data = {key:value for key, value in data['timeline']['cases'].items() if value != 0}
        for key, value in new_data.items():
            new_dict_count = list(new_dict.values()).count(value)
            old_dict_count = list(new_data.values()).count(value)
            if new_dict_count < (old_dict_count / 2):
                new_dict[key] = value
                dates.append(date_format(key))
        datatosend['dates'] = dates
        
        for i in data['timeline']:
            y_axis = []
            for key, value in data['timeline'][i].items():
                if date_format(key) in dates:
                    y_axis.append(value)
            datatosend[i] = y_axis
            
    except KeyError:
        return data['message']
    datatosend['length'] = len(dates)
    datatosend['country'] = argu.title()
    return template('countryGraph.tpl', url = url, datalist=datatosend)

@route("/worldmap/" , name="worldmap")
def world_map():
    datatosend = {}
    all_url = "https://corona.lmao.ninja/all"
    data_all = requests.get(all_url).json()
    datatosend['all_cases'] = format(data_all['cases'], ',d')
    datatosend['all_deaths'] = format(data_all['deaths'], ',d')
    datatosend['all_recovered'] = format(data_all['recovered'], ',d')
    with open("app.json" ,"r") as f:
        appdata = json.load(f)
    if datetime.datetime.now().timestamp()-100000 > appdata["time"] :
        appdata["time"] = datetime.datetime.now().timestamp()
        with open("app.json" ,"w") as f:
            json.dump(appdata, f)
        datalist = requests.get(appdata["url"]).json()
        with open("datalist.json" ,"w") as f:
            json.dump(datalist, f)
    else:
        with open("datalist.json" , 'r') as f:
            datalist = json.load(f)
    if 'cases' not in datalist[0].keys():
        return "Wrong Argument"
    tempf = []
    for i in datalist:
        if len(tempf) == 0 :
            tempf += [i['cases']]
        else:
            pass
        try:
            try:
                keyin = "LOW"
                for d in list(thresolds.keys()):
                    if ((i['cases']/max(tempf))*100 >= thresolds[d][0]) and ((i['cases']/max(tempf))*100 <= thresolds[d][1]):
                        keyin = d
            except Exception as e:
                keyin = "UNKNOWN"
            datatosend[country[i["country"]]] = {"fillKey":keyin , "cases": format(i['cases'], ',d'), "deaths": format(i['deaths'], ',d'), "recovered": format(i['recovered'], ',d')}
        except Exception as e :
            try:
                try:
                    keyin = "LOW"
                    for d in list(thresolds.keys()):
                        if ((i['cases']/max(tempf))*100 >= thresolds[d][0]) and ((i['cases']/max(tempf))*100 <= thresolds[d][1]):
                            keyin = d
                except:
                    keyin = "UNKNOWN"
                if len(i["country"]) == 3:
                    datatosend[i["country"]] = {"fillKey":keyin , "cases": format(i['cases'], ',d'), "deaths": format(i['deaths'], ',d'), "recovered": format(i['recovered'], ',d')}
                else:
                    pass
            except:
                continue
    tmpl = '''
        <span class="popup">Total ${window.location.pathname.split('/')[2]}(${geo.properties.name}) : ${data.numberOfThings}</span>

    '''
    return template('worldmap.tpl' ,url=url ,datalist=datatosend)


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    run(host="0.0.0.0" , port=port , debug= False)
    # run(debug=True)

