from bottle import get, static_file, run , route, template, url , request

@route('/res/<filepath:path>', name='res')
def resources(filepath):
    return static_file(filepath, root='./res')

@route("/" , name="homepage")
def homepage():
    return template('index.tpl' , url=url)


@route("/worldmap" , name="worldmap")
def world_map():
    return template('worldmap.tpl' ,url=url)

run(host="0.0.0.0" , port=5000 , debug= False)

