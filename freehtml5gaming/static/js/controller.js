var ISSChatApp = angular.module('ISSChatApp', []);


ISSChatApp.controller('ChatController', function($scope){   
        var socket = io.connect('https://' + document.domain +':' + location.port + '/iss');
        $scope.messages = [];
        $scope.name = '';
        $scope.text = '';
        $scope.logIn = true;
        $scope.sendM = false;
        $scope.searchBox=false;
        socket.on('message', function(msg){
           console.log(msg);
           $scope.messages.push(msg);
           $scope.$apply();
           var elem = document.getElementById('msgpane');
           elem.scrollTop = elem.scrollHeight;
            
        });
        $scope.setUser = function setUser(usr){
            $scope.name = usr;
        };
        
        
       // var pg = require('pg').native;
 /*
        var conString = "tcp://postgres:1234@localhost:iss/db";
        var client = new pg.Client(conString);
        client.connect();
 
       // var io = require('socket.io').listen(8888);
 
       // io.sockets.on('connection', function (socket) {
       //     socket.on('sql', function (data) {
       //     var query = client.query(data.sql, data.values);
       //     query.on('row', function(row) {
      //      socket.emit('sql', row);
      //          });
     //       });
     //   });

       */ 
        $scope.send = function send(){
          console.log('Sending message: ', $scope.text);  
          socket.emit('message', $scope.text);
          $scope.text='';
         // dbStatement="INSERT INTO chatLog"
          //dbValues={$scope.name, $scope.text};
         // sendSql(dbStatement, dbValues)
            
        };
        
        $scope.setName = function setName(){
          socket.emit('identify', $scope.name)  
            
        };
        
        socket.on('connect', function(){
            console.log('connected');
            
        });
        
          console.log("HHHHHHHHHHHHHHHHEEEEEEEEEEEEEEEEEEEEERRRRRRRRRRRRRREEEEEEEEEEEEEEEEEE");
       // var socket ="";
        $scope.login = function (){
          //$scope.name = document.getElementById("userName").value;
          console.log('Sending login45: ', $scope.name );
          socket.emit('login', $scope.name, $scope.password);
          }
          
        socket.on('goAhead', function(){
            console.log("Finally here ", $scope.name);
            $scope.logIn = false;
            $scope.$apply();
            $scope.sendM = true;
            $scope.$apply();
            $scope.searchBox=true;
            $scope.$apply();
            //$scope.$apply();
             //$scope.name = name;
            //document.getElementById("userName").value = $scope.name;
            //$scope.$apply();
            console.log($scope.name);
           // $scope.setName();
           //socket.emit('identify', $scope.name);
        });
        
        $scope.search = function search(){
          console.log('Looking for : ', $scope.searchTerm);  
          socket.emit('search', $scope.searchTerm);
          $scope.searchTerm='';
        };


        
        
});


