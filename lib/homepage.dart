import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/dialog.dart';
import 'package:tic_tac_toe/game_tiles_button.dart';


class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
var  player_one;
var  player_two;
var active_player;
 List  buttonList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonList = doInit();
  }

  List<GameButton> doInit(){

    player_one = List();
    player_two = List();
    active_player = 1;

    List gameButtons = <GameButton>[

      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];

    return gameButtons;
  }

  void playGame(GameButton gb){

    setState(() {
      if(active_player==1){
        gb.text = "X";
        gb.bg = Colors.red;
        active_player = 2 ;
        player_one.add(gb.id);
      }else{
        gb.text = "0";
        gb.bg = Colors.black;
        active_player = 1;
        player_two.add(gb.id);
      }
     gb.enabled = false;
      int winner = checkWinner();
      if(winner == -1){
        if(buttonList.every((p) => p.text!="")){
          showDialog(
              context: context,
              builder: (_)=> CustomDialog("Game tied",
                  "Press the reset button to start again "
                  , resetGame)
          );
        }else{
          active_player ==2?autoPlay():null;
        }
      }
    });

  }


  void autoPlay(){
  var emptyCells = List();
  var list = List.generate(9, (i) => i+1);
  for(var cellID in list ){
     if(!(player_one.contains(cellID) || player_two.contains(cellID))){
       emptyCells.add(cellID);
     }

  }


  var r = Random();
  var randIndex = r.nextInt(emptyCells.length-1);
  var cellID = emptyCells[randIndex];
  int i = buttonList.indexWhere((p) => p.id == cellID);
  playGame(buttonList[i]);




  }

  int checkWinner(){
    var winner = -1;

    //rows
    if(player_one.contains(1) && player_one.contains(2) && player_one.contains(3)){
    winner = 1;
    }

    if(player_two.contains(1) && player_two.contains(2) && player_two.contains(3)){
      winner = 2;
    }


    if(player_one.contains(4) && player_one.contains(5) && player_one.contains(6)){
      winner = 1;
    }

    if(player_two.contains(4) && player_two.contains(5) && player_two.contains(6)){
      winner = 2;
    }

    if(player_one.contains(7) && player_one.contains(8) && player_one.contains(9)){
      winner = 1;
    }

    if(player_two.contains(7) && player_two.contains(8) && player_two.contains(9)){
      winner = 2;
    }

    //columns

    if(player_one.contains(1) && player_one.contains(4) && player_one.contains(7)){
      winner = 1;
    }

    if(player_two.contains(1) && player_two.contains(4) && player_two.contains(7)){
      winner = 2;
    }

    if(player_one.contains(2) && player_one.contains(5) && player_one.contains(8)){
      winner = 1;
    }

    if(player_two.contains(2) && player_two.contains(5) && player_two.contains(8)){
      winner = 2;
    }

    if(player_one.contains(3) && player_one.contains(6) && player_one.contains(9)){
      winner = 1;
    }

    if(player_two.contains(3) && player_two.contains(6) && player_two.contains(9)){
      winner = 2;
    }


    //diagonal
    if(player_one.contains(1) && player_one.contains(5) && player_one.contains(9)){
      winner = 1;
    }

    if(player_two.contains(1) && player_two.contains(5) && player_two.contains(9)){
      winner = 2;
    }
    if(player_one.contains(3) && player_one.contains(5) && player_one.contains(7)){
      winner = 1;
    }

    if(player_two.contains(3) && player_two.contains(5) && player_two.contains(7)){
      winner = 2;
    }

    if(winner !=-1){
      if(winner == 1){
        showDialog(
            context: context,
        builder: (_)=>CustomDialog("player one won ",
            "Press the reset button to start again",resetGame)

        );
      }else{
        showDialog(
            context: context,
            builder: (_)=>CustomDialog("player two won ",
                "Press the reset button to start again",resetGame)

        );
      }
        
    }

    return winner;

    }

  void resetGame(){
  if(Navigator.canPop(context))Navigator.pop(context);
  setState(() {
    buttonList = doInit();
  });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tac Toe"),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Expanded(

            child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 9.0,
                crossAxisCount: 3,
                mainAxisSpacing: 9.0,
                childAspectRatio: 1.0
              ),
                itemCount: buttonList.length,
                itemBuilder: (context,i)=>SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    onPressed: buttonList[i].enabled?
                        ()=>playGame(buttonList[i]):null,
                    child: Text(
                      buttonList[i].text,
                      style: TextStyle(color: Colors.white,fontSize: 20.0),
                    ),

                    color: buttonList[i].bg,
                    disabledColor: buttonList[i].bg,
                  ),

                )
            ),
          ),

          RaisedButton(
              child: Text(
                  "Reset",
                style: TextStyle(color: Colors.white,fontSize: 20.0),
              ),
              color: Colors.red,
              padding: const EdgeInsets.all(20),
              onPressed: resetGame
          )
        ],
      ),
    );
  }
}
