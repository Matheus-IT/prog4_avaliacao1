import 'dart:math';
import 'package:flutter/material.dart';
import 'package:prog4_avaliacao1/components/bottom_info.dart';
import 'package:prog4_avaliacao1/models/enemy.dart';
import '../components/accent_text.dart';
import '../models/game_functions.dart';
import '../consts/colors.dart';

class BattlePage extends StatefulWidget {
  const BattlePage({Key? key}) : super(key: key);

  @override
  State<BattlePage> createState() => _BattlePageState();
}

class _BattlePageState extends State<BattlePage> {
  var gameChoices = ["pedra", "papel", "tesoura"];

  final _randomPick = Random();

  var gamePlay = {
    "0": " Você perdeu!",
    "1": "Você Venceu!",
    "2": "Empate!.",
    "3": "Falta! Pedra 2x não pode!"
  };

  var battleMessenger = {
    -1: kWhite, //neutral color for the first move
    0: kColor5,
    1: kColor6,
    2: kColor7,
    3: kFault
  };

  int result = -1;
  String computerMove = "";
  int playerPoints = 0;
  int computerPoints = 0;
  int loseCondition = 0;
  var enemyMood = "lib/assets/images/enemy.png";

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kColor1,
      appBar: AppBar(
        title: const AccentText(content: 'Jokenpô', fontSize: 46.0),
        backgroundColor: kColor3,
        actions: [
          SizedBox(
            width: 150,
            child: scoreCounter(playerPoints, computerPoints),
          )
        ],
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: false,
        children: <Widget>[
          Stack(
            children: [
              SizedBox(
                height: screenSize.height * .35,
                child: EnemyCard(
                  imgFile: enemyMood,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 80,
            child: Center(
              child: AccentText(
                content: 'VS',
                fontSize: 50,
              ),
            ),
          ),
          Align(
            heightFactor: 1.0,
            child: Container(
              width: 600,
              height: screenSize.height * .45,
              decoration: const BoxDecoration(
                  color: kColor3,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Card(
                    color: battleMessenger[result],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    child: Container(
                      alignment: Alignment.center,
                      width: 350,
                      height: 55,
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        computerMove == "" || result == -1
                            ? "Faça sua jogada"
                            : "Computador jogou $computerMove. ${gamePlay[result.toString()]}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'LDFComicSans',
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Card(
                          color: kColor3,
                          shape: const CircleBorder(),
                          elevation: 1,
                          child: InkWell(
                            radius: 45,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: kColor4,
                            child:
                                getImage("lib/assets/icons/rock.png", context),
                            onTap: () {
                              computerMove = gameChoices[
                                  _randomPick.nextInt(gameChoices.length)];
                              result = getWinner("pedra", computerMove);
                              stateChange(result);
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          color: kColor3,
                          shape: const CircleBorder(),
                          elevation: 1,
                          child: InkWell(
                            radius: 45,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: kColor4,
                            child:
                                getImage("lib/assets/icons/paper.png", context),
                            onTap: () {
                              computerMove = gameChoices[
                                  _randomPick.nextInt(gameChoices.length)];
                              result = getWinner("papel", computerMove);
                              stateChange(result);
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          color: kColor3,
                          shape: const CircleBorder(),
                          elevation: 1,
                          child: InkWell(
                            radius: 45,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: kColor4,
                            child: getImage(
                                "lib/assets/icons/scissors.png", context),
                            onTap: () {
                              computerMove = gameChoices[
                                  _randomPick.nextInt(gameChoices.length)];
                              result = getWinner("tesoura", computerMove);
                              stateChange(result);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: kColor4,
                    elevation: 2,
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        width: 200.0,
                        height: 36.0,
                        padding: const EdgeInsets.all(5),
                        child: const Text(
                          'Reiniciar',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: kWhite),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          playerPoints = 0;
                          computerPoints = 0;
                          computerMove = "";
                          result = -1;
                          loseCondition = 0;
                          enemyMood = "lib/assets/images/enemy.png";

                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomLabel(),
    );
  }

  int getWinner(String playerChoice, String computerChoice) {
    if (playerChoice == "pedra") {
      loseCondition++;
    }
    if (loseCondition > 1) {
      return 3;
    }
    if ((playerChoice == "pedra" && computerChoice == "papel") ||
        (playerChoice == "papel" && computerChoice == "tesoura") ||
        (playerChoice == "tesoura" && computerChoice == "pedra")) {
      return 0;
    } else if ((playerChoice == "pedra" && computerChoice == "tesoura") ||
        (playerChoice == "tesoura" && computerChoice == "papel") ||
        (playerChoice == "papel" && computerChoice == "pedra")) {
      return 1;
    } else {
      return 2;
    }
  }

  void stateChange(int result) {
    setState(() {
      if (result == 0) {
        playerPoints = playerPoints;
        computerPoints = computerPoints + 1;
        loseCondition = 0;
        enemyMood = "lib/assets/images/happyenemy.png";
      } else if (result == 1) {
        playerPoints = playerPoints + 1;
        computerPoints = computerPoints;
        enemyMood = "lib/assets/images/madenemy.png";
      } else if (result == 3) {
        computerPoints = computerPoints + 1;
        loseCondition = 0;
        enemyMood = "lib/assets/images/happyenemy.png";
      } else {
        enemyMood = "lib/assets/images/enemy.png";
        playerPoints = playerPoints;
        computerPoints = computerPoints;
      }
    });
  }
}
