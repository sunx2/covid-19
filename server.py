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
@route('/res/<filepath:path>', name='res')
def resources(filepath):
    return static_file(filepath, root='./res')

@route("/" , name="homepage")
def homepage():
    return template('index.tpl' , url=url)


@route("/worldmap/<argu>" , name="worldmap")
def world_map(argu):
    datatosend = {}
    appdata = json.load(open("app.json" ,"r"))
    if datetime.datetime.now().timestamp()-100000 > appdata["time"] :
        appdata["time"] = datetime.datetime.now().timestamp()
        json.dump(appdata,open("app.json","w"))
        datalist = requests.get(appdata["url"]).json()
        json.dump(datalist ,open("datalist.json" , "w"))
    else:
        datalist = json.load(open("datalist.json" , 'r'))
    if argu not in datalist[0].keys():
        return "Wrong Argument"
    tempf = []
    for i in datalist:
        if len(tempf) == 0 :
            tempf += [i[argu]]
        else:
            pass
        try:
            try:
                keyin = "LOW"
                for d in list(thresolds.keys()):
                    if ((i[argu]/max(tempf))*100 >= thresolds[d][0]) and ((i[argu]/max(tempf))*100 <= thresolds[d][1]):
                        keyin = d
            except Exception as e:
                keyin = "UNKNOWN"
            datatosend[country[i["country"]]] = {"fillKey":keyin , "numberOfThings":i[argu]}
        except Exception as e :
            try:
                try:
                    keyin = "LOW"
                    for d in list(thresolds.keys()):
                        if ((i[argu]/max(tempf))*100 >= thresolds[d][0]) and ((i[argu]/max(tempf))*100 <= thresolds[d][1]):
                            keyin = d
                except:
                    keyin = "UNKNOWN"
                if len(i["country"]) == 3:
                    datatosend[i["country"]] = {"fillKey":keyin , "numberOfThings":i[argu]}
                else:
                    pass
            except:
                continue
    tmpl = '''
        <span class="popup">total ${window.location.pathname.split('/')[2]}(${geo.properties.name}) : ${data.numberOfThings}</span>

    '''
    return template('worldmap.tpl' ,url=url ,datalist=datatosend)


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    run(host="0.0.0.0" , port=port , debug= False)
    #run(debug=True)

