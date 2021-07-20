float xCoord;
float yCoord;
float alto;
float ancho;

float tiempo;
int score = 0;
float tiempoJuego;
float tiempoXJugador;
float tiempoPrevio;
PImage fondo, imgPlayer;
int player;
//Car redCar, yellowCar;
String msjTiempo;
Game game = new Game();
boolean state;
//Car [] cars = new Car[2];

void setup() {
  game.cargarImagenes();
  fondo = game.imgs[8];
  player = 1;
  imgPlayer = game.inicializarPrimerJugador();
  alto = 34;
  ancho = 80;
  size(800, 700);
  state = game.gameState;
  score = 0;
  tiempoJuego = 0;
  tiempoXJugador = 10;
  tiempoPrevio = 5;
  msjTiempo = "";
  xCoord = game.coordenadaX();
  yCoord = game.coordenadaY();
}

void draw() {

  background(255);

  image(fondo, 0, 135, 800, 564);
  xCoord = game.coordenadaX();
  yCoord = game.coordenadaY();
  image(imgPlayer, xCoord, yCoord, ancho, alto);
  fill(255, 0, 0);
  text("Coordenadas: (" + xCoord + ", " + yCoord + ")", 620, 70);
  noFill();
  stroke(255, 0, 0);
  arc(200, 300, 50, 50, 0, HALF_PI, OPEN);
  fill(0);
  tiempoJuego = millis() /1000;
  game.stateGame(state, tiempoJuego, tiempoXJugador);
  state = game.gameState;
  if (state == true && tiempoXJugador + tiempoPrevio <= tiempoJuego
    && tiempoXJugador + 2 * tiempoPrevio >= tiempoJuego) {
    println("cambio de carro " + tiempoJuego );
    imgPlayer = game.imgs[5];
    player = 2;
    //image(game.imgs[5],365,634,80,34);
    game.setCoordX(365);
    game.setCoordY(634);
    //xCoord = 365;
    //yCoord = 634;
    //println("carrro 2 estado "+state);
  } else if (state == false && tiempoPrevio >= tiempoJuego) {
    game.setCoordX(365);
    game.setCoordY(634);
    //xCoord = 365;
    //yCoord = 634;
  }

  msjTiempo = game.controlTiempo(tiempoJuego, tiempoXJugador, tiempoPrevio);
  if (msjTiempo == "Game Over") {
    noLoop(); //termina una vez llegado al final
    textSize(25);
  }
  text(msjTiempo, 10, 20);
  // muestra el tiempo en pantalla
  fill(0);
}


//boolean stateCar(){

//}

void mousePressed() {

  //xCoord = mouseX;
  //yCoord = mouseY;
  game.setCoordX(mouseX);
  game.setCoordY(mouseY);
  println("x " + game.coordenadaX() + " y " + game.coordenadaY());
}

void keyPressed() {
  if (keyCode == RIGHT) {
    println("mov a la derecha");
    alto = 34;
    ancho = 80;
    if (player == 1) {
      imgPlayer = game.imgs[1];
    } else {
      imgPlayer = game.imgs[5];
    }
  }
  if (keyCode == LEFT) {
    println("mov a la izquierda");
    alto = 34;
    ancho = 80;
    if (player == 1) {
      imgPlayer = game.imgs[3];
    } else {
      imgPlayer = game.imgs[7];
    }
  }
  if (keyCode == DOWN) {
    println("mov hacia abajo");
    alto = 80;
    ancho = 34;
    if (player == 1) {
      imgPlayer = game.imgs[2];
    } else {
      imgPlayer = game.imgs[6];
    }
  }
  if (keyCode == UP) {
    println("movimiento hacia arriba");
    alto = 80;
    ancho = 34;
    if (player == 1) {
      imgPlayer = game.imgs[0];
    } else {
      imgPlayer = game.imgs[4];
    }
  }
  if (key == 'a' || key == 'A') { // aceleración
    game.aceleracionCar(tiempoJuego);
  }
  if (key == 'd' || key == 'D') { // desaceleración
    game.desaceleracionCar(tiempoJuego);
  }
}
