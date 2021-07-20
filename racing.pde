/*
Declaración de variables
**/
float x; // valor default del largo
float y; // valor default del ancho
float cX; // valor default de la coordenada X
float cY; // valor default de la coordenada Y
float coordX; // coordenada en el eje x
float coordY; // coordenada en el eje y
float largo; // largo de la imagen del carro
float ancho; // ancho de la imagen del carro
float velocidadMedia; // velocidad media considerando variaciones de 1 segundo
float aceleracionMedia; // aceleración media considerando variaciones de 1 segundo
float tiempo; // tiempo total del juego
int tiempoJugador1; // tiempo de recorrido de la pista del jugador 1 
int tiempoJugador2; // tiempo de recorrido de la pista del jugador 2
float tiempoJuego; // tiempo total del juego
float tiempoXJugador; // tiempo de juego de cada jugador
float tiempoPrevio; // tiempo previo a la salida de cada jugador
PImage fondo; // imagen de fondo del juego
PImage car; // imagen del carro que está en la pista
String msjTiempo; // mensaje de control del tiempo del juego
String msjVelocidadMedia; // mensaje de velocidad media en lapsos de 1 segundo
String msjAceleracionMedia; // mensaje de aceleración media en lapsos de 1 segundo
String msjTimpoRecorridoCar1; // mensaje de tiempo empleado en completar el recorrido del carro 1
String msjTimpoRecorridoCar2; // mensaje de tiempo empleado en completar el recorrido del carro 2
Game game; // instancia de la clase Game

/*
Inicialización de las variables del juego
**/
void setup() {
  size(800, 700);
  x = 80;
  ancho = x;
  y = 34;
  largo = y;
  cX = 365;
  coordX = cX;
  cY = 634;
  coordY = cY;
  game = new Game(ancho, largo, coordX, coordY);
  game.cargarImagenes();
  game.inicializarPrimerasImagenes();
  fondo = game._fondo;
  image(fondo, 0, 135, 800, 564);
  velocidadMedia = 0;
  aceleracionMedia = 0;
  tiempo = 0;
  tiempoJugador1 = 0;
  tiempoJugador2 = 0;
  tiempoJuego = 0;
  tiempoXJugador = 30;
  tiempoPrevio = 5;
  msjTiempo = "";
  msjVelocidadMedia = "";
  msjAceleracionMedia = "";
  msjTimpoRecorridoCar1 = "";
  msjTimpoRecorridoCar2 = "";
}

/*
Método bucle que ejecuta el juego
**/
void draw() {
  background(255);
  image(fondo, 0, 135, 800, 564);
  textSize(15);
  tiempoJuego = millis() /1000;
  //fill(255, 0, 0);
  //text(millis(), 30, 40);
  
  game.play(tiempoJuego, tiempoXJugador, tiempoPrevio);
  car = game._car;
  game.desplazamiento();
  coordX = game._coordX;
  coordY = game._coordY;
  largo = game._largo;
  ancho = game._ancho;
  image(car, coordX, coordY, ancho, largo);
  
  msjTiempo = game.controlTiempo(tiempoJuego, tiempoXJugador, tiempoPrevio);
  if (msjTiempo == "Game Over") {
    text("tiempo Car 1: " + game._tiempoCar1,470,69);
    text("tiempo Car 2: " + game._tiempoCar2,630,69);
    if (game._tiempoCar1 < game._tiempoCar2) {
      text("Ganador Carro 1 por " + (game._tiempoCar2 - game._tiempoCar1) + " segundos",187,114);
    } else {
      text("Ganador Carro 2 por " + (game._tiempoCar1 - game._tiempoCar2) + " segundos",187,114);
    }
    noLoop(); //termina una vez llegado al final
  }
  
  // muestra el tiempo en pantalla
  fill(0);
  game.cambioTiempo(millis());
  text("Velocidad: " + game._velocidadMediad, 19, 69);
  text("Aceleración: " + game._aceleracionMedia, 242, 69);
  //text("desplazamiento: " + game._desplazamientoTotal, 100, 120);
  //textSize(25);
  text(msjTiempo, 290, 20);
  //game.stopRace(tiempoJuego);
}



void mousePressed() {
  game.setCoordX(mouseX);
  game.setCoordY(mouseY);
  println("x " + game._coordX + " y " + game._coordY);
}

void keyPressed() {
  if (keyCode == RIGHT) {
    game.giroDerecha();
  }
  if (keyCode == LEFT) {
    game.giroIzqiuerda();
  }
  if (keyCode == DOWN) {
    game.giroAbajo();
  }
  if (keyCode == UP) {
    game.giroArriba();
  }
  if (key == 'a' || key == 'A') { // aceleración
    game.aceleracionCar();
  }
  if (key == 'd' || key == 'D') { // desaceleración
    game.desaceleracionCar();
  }
}
