from bottle import get, static_file, run , route, template, url , request
import requests
import os
import json
country = json.load(open("countrycodes.json","r"))
thresolds = {
    "HIGH" : [0.50,1],
    "MEDIUM": [0.25,0.50],
    "LOW": [0,0.25]
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
    datalist = requests.get("https://corona.lmao.ninja/countries").json()
    if argu not in list[datalist.keys()][1:]:
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
                    if ((i[argu]/max(tempf)*100) > thresolds[d][0]) and ((i[argu]/max(tempf)*100) < thresolds[d][1]):
                        keyin = d
            except Exception as e:
                keyin = "UNKNOWN"
            datatosend[country[i["country"]]] = {"fillKey":keyin , "numberOfThings":i[argu]}
        except Exception as e :
            try:
                try:
                    keyin = "LOW"
                    for d in list(thresolds.keys()):
                        if ((i[argu]/max(tempf)*100) >= thresolds[d][0]) and ((i[argu]/max(tempf)*100) <= thresolds[d][1]):
                            keyin = d
                except:
                    keyin = "UNKNOWN"
                if len(i["country"]) == 3:
                    datatosend[i["country"]] = {"fillKey":keyin , "numberOfThings":i[argu]}
                else:
                    pass
            except:
                continue
    return template('worldmap.tpl' ,url=url ,datalist=datatosend)


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    #run(host="0.0.0.0" , port=port , debug= False)
    run(debug=True)

