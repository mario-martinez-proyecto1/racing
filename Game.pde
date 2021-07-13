class Game {

  PImage jugador;
  //float timer;
  PImage [] imgs = new PImage[9];
  Car[] cars = new Car[8];
  boolean gameState;
  float aceleracion;
  float velocidadFinal;
  float velocidadInicial;
  float tiempoDeAceleracion;
  float xCoord;
  float yCoord;

  Game () {
    state = false;
    aceleracion = 0;
    velocidadFinal = 0;
    velocidadInicial = 0;
    tiempoDeAceleracion = 0;
    xCoord = 365;
    yCoord = 634;
  }

  String controlTiempo(float pTiempoJuego, float pTiempoXJugador, float pTiempoPrevio) {
    if (pTiempoJuego <= pTiempoPrevio) { // segundos para iniciar 1er jugador
      return "Inicia el jugador uno en : " + (tiempoPrevio - pTiempoJuego);
    } else if (pTiempoJuego > pTiempoPrevio && pTiempoJuego <= pTiempoXJugador + pTiempoPrevio) { // tiempo 1er jugador
      return "Tiempo: " + (pTiempoXJugador + tiempoPrevio - pTiempoJuego);
    } else if (pTiempoJuego > tiempoXJugador + pTiempoPrevio && pTiempoJuego <= tiempoXJugador + 2 * pTiempoPrevio) { // segundos para iniciar 2do jugador
      return  "Inicia el jugador dos en : " + (pTiempoXJugador + 2 * pTiempoPrevio - pTiempoJuego);
    } else if (pTiempoJuego > pTiempoXJugador + 2 * pTiempoPrevio && pTiempoJuego <= 2 * pTiempoXJugador + 2 * pTiempoPrevio) { // tiempo 2do jugador
      return "Tiempo: " + (2 * pTiempoXJugador + 2 * pTiempoPrevio - pTiempoJuego);
    } else {
      return "Game Over";
    }
  }
  void cargarImagenes() {
    imgs[0] = loadImage("./imgs/red-carN.png");
    imgs[1] = loadImage("./imgs/red-carE.png");
    imgs[2] = loadImage("./imgs/red-carS.png");
    imgs[3] = loadImage("./imgs/red-carO.png");
    imgs[4] = loadImage("./imgs/yellow-carN.png");
    imgs[5] = loadImage("./imgs/yellow-carE.png");
    imgs[6] = loadImage("./imgs/yellow-carS.png");
    imgs[7] = loadImage("./imgs/yellow-carO.png");
    imgs[8] = loadImage("./imgs/pistaA.jpeg");
  }
  PImage inicializarPrimerJugador() {
    return imgs[1];
  }
  float coordenadaX(){
    return xCoord;
  }
  float coordenadaY(){
    return yCoord;
  }
  void setCoordX(float pCoordX) {
    xCoord = pCoordX;
  }
  void setCoordY(float pCoordY) {
    yCoord = pCoordY;
  }
  void stateGame(boolean state, float tiempo, float tiempoXJugador) {
    //println("entra a game.starRacing " );
    if (state == false && tiempo == tiempoXJugador) {
      gameState = true;
      tiempoDeAceleracion = 0;
      velocidadInicial = 0;
      velocidadInicial = 0;
      aceleracion = 0;
      println("stado Game " + state);
    }
  }
  void aceleracionCar(float tiempo){
    aceleracion += 1;
    if (tiempoDeAceleracion == 0) {
      tiempoDeAceleracion = 1;
    }
    println("aceleracion " + aceleracion);
    // no puede quedar acelerado
  }
  void desaceleracionCar(float tiempo){
    if (aceleracion > 0) {
      aceleracion -= 1;
    }
    
    println("aceleracion " + aceleracion);
    // no puede quedar acelerado
  }
  void velocidad(){
    velocidadFinal = velocidadInicial + aceleracion * 1;
  }
}
