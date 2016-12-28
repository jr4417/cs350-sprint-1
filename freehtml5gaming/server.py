import os
import psycopg2
import psycopg2.extras
import uuid

from flask import Flask, session, render_template, request
from flask.ext.socketio import SocketIO, emit
app = Flask(__name__)
appChat = Flask(__name__, static_url_path='')
appChat.config['SECRET_KEY'] = 'secret!'

def connectToDB():
    connectionString = 'dbname=gamesdb user=postgres password = 1234 host = localhost'
    print connectionString
    try:
        return psycopg2.connect(connectionString)
        
    except:
        print("Can not connect to db")
            

@app.route('/')
def mainIndex():
    goingPlay=True
    game="Arkham"
    return render_template('index.html',willU=goingPlay,game=game)

@app.route('/games')
def showGames():
    games = [{'name' : 'Guild Ball', 'pub' : 'Strong forge', 'site' : 'http://guildball.com', 'pic' : '/static/images/gb.jpg'},
    {'name' : 'Arkham Horror', 'pub' : 'Fantasy Flight', 'site' : 'https://www.fantasyflightgames.com/en/index/', 'pic' : '/static/images/Arkham.jpg'}]
    return render_template('games.html', games=games)

@app.route('/vidgames')
def showVidGames():
    return render_template('vidgames.html')

@app.route('/addTo', methods=['GET', 'POST'])
def addTo():
    conn = connectToDB()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    if request.method == 'POST':
    # add new entry into database
        try:
            cur.execute("""INSERT INTO games (title, publisher, genre, weight, released, site) 
             VALUES (%s, %s, %s, %s, %s, %s);""",
            (request.form['Title'], request.form['Publisher'],request.form['Genre'], request.form['Weight'],
                request.form['Released'],  request.form['Site']))
        except:
            print("ERROR inserting into games")
            htp = "asg"
           # print("Tried: INSERT INTO games (title, publisher, genre, weight, released, site) VALUES (%s);" %
            #(request.form['Title'],))
            print("Tried: INSERT INTO games (title, publisher, genre, weight, released, site) VALUES (%s, %s, %s, %s, %s, %s);" %
            (request.form['Title'], request.form['Publisher'],request.form['Genre'], request.form['Weight'], request.form['Released'], request.form['Site'] ))

            conn.rollback()

        conn.commit()
  
    return render_template('addTo.html')
  
@app.route('/gameList')
def showChart():
    """rows returned from postgres are just an ordered list"""
    conn = connectToDB()
    cur = conn.cursor()
    try:
        cur.execute("SELECT title FROM games;")
        results0 = cur.fetchall()
        cur.execute("SELECT publisher FROM games;")
        results1 = cur.fetchall()
        cur.execute("SELECT genre FROM games;")
        results2 = cur.fetchall()
        cur.execute("SELECT released FROM games;")
        results3 = cur.fetchall()
        cur.execute("SELECT playtime FROM games;")
        results4 = cur.fetchall()

    except:
        print("Error executing select")
        
    print results0[0][0]
 #   print results1[0][0]
 #   print results2[0][0]
 #   print results3[0][0]
 #   print results4[0][0]
   
    return render_template('list_games.html', games = results0, pubs = results1, gens = results2, rels = results3, playTimes = results4)

#app.config['SECRET_KEY'] = 'secret!'

socketio = SocketIO(app)
loggedIn = 1;


messages = [{'text': 'Booting system', 'name': 'Bot'},
            {'text': 'ISS Chat now live!', 'name': 'Bot'}]
            
users = {}

@socketio.on('connect', namespace = '/iss')
def makeConnection():

    if loggedIn == 1:
        session['uuid'] = uuid.uuid1()
        session['username'] = 'New user'
        print('connected')
        users[session['uuid']] = {'username': 'New user'}
        print("here")
        #print("user is %s" % (users[session['uuid']]['username']))
        #return app.send_static_file('index.html')
    
    else:
        #login()
        print("loggin in")
        return app.send_static_file('login.html')
        
@socketio.on('message', namespace='/iss')
def newMessage(message):
    db = connectToDB()
    cur = db.cursor(cursor_factory=psycopg2.extras.DictCursor)

    tmp = {'text' : message, 'name' : users[session['uuid']]['username']}
    print(tmp)
    messages.append(tmp)
    cur.execute("""INSERT INTO chatLog (chatentry, username) VALUES( '%s', '%s');""" % (message, users[session['uuid']]['username']))
    db.commit()
    emit('message', tmp, broadcast=True)

@socketio.on('identify', namespace='/iss')
def on_identify(message):
    print('identify' + message)
    
    users[session['uuid']] = {'username': message}


@socketio.on('login', namespace='/iss')
def login(name, pword):
    global loggedIn
    db = connectToDB()
    cur = db.cursor(cursor_factory=psycopg2.extras.DictCursor)
    #currentUser = message
    print(name)
    print(pword)
      
    query = "select * from users WHERE username = '%s' AND crypt('%s', password) = password;" % (name, pword)
    #users[session['uuid']] = name
    print(query)
    try:
        cur.execute(query)
        
    except:
        print("USER NOT FOUND")
    if cur.fetchone():
        loggedIn = 1
        print("loggid in is %s." %(loggedIn));
        for message in messages:
            print(message)
            emit('message', message)

        emit('goAhead')
        
    else:
        loggedIn = 0
    print(loggedIn)
    #return app.send_static_file('login.html')

@socketio.on('search', namespace='/iss')
def searchData(searchTerm):
    db = connectToDB()
    cur = db.cursor(cursor_factory=psycopg2.extras.DictCursor)
 
    print("Give me a minute %s" %(searchTerm))
    searchState = """select * from chatlog where chatentry ~ '%s';""" %(searchTerm)

    try:
        print(searchState)
        cur.execute(searchState)
        
    except:
        print("TERM NOT FOUND")
    msgs = cur.fetchall()
    
    for msg in msgs:
        tmp = {'text': msg["chatentry"], 'name' : msg["username"]}
        emit('message', tmp, broadcast=False)
        print("%s : %s" % ( msg["username"], msg["chatentry"]))



###use join room function
###when sending must add room to send function



@app.route('/chat')
def startChat():
     return render_template('chat.html')
    
  






# start the server
if __name__ == '__main__':
        #socketio.run(app, host=os.getenv('IP', '0.0.0.1'), port =int(os.getenv('PORT', 8080)), debug=False)
        app.debug=True
        app.run(host='0.0.0.0', port=8080)
