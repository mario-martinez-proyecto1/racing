class Game {

  PImage [] imgs; // arreglo de imagenes que contiene las imágenes del juego
  PImage _car; // imagen del carro que está en la pista
  PImage _fondo; // imagen de fondo del juego
  float _aceleracionMedia; // aceleración medio correspondiente a un cambio de 1 segundo
  //float _velocidadFinal; // velocidad del carro en el intervalo superior de tiempo analizado (1 segundo)
  float _velocidadInicial; // velocidad del carro en el intervalo inferior de tiempo analizado (1 segundo)
  float _velocidadMedia; // velocidad media del carro por cada variación de un segundo
  float _velocidadMediaCar1; // velocidad media del carro 1
  float _velocidadMediaCar2; // velocidad media del carro 2
  float _coordXInicial; // coordenada en el eje 'x' del carro en el intervalo inferior de tiempo analizado (1 segundo)
  float _coordX; // coordenada en el eje 'x' del carro en el intervalo superior de tiempo analizado (1 segundo)
  float _coordXSalida; // coordenada en el eje 'x' del carro en la posición de salida
  float _coordXMeta; // coordenada en el eje 'x' del carro en la posición de meta
  float _coordYInicial; // coordenada en el eje 'y' del carro en el intervalo inferior de tiempo analizado (1 segundo)
  float _coordY; // coordenada en el eje 'y' del carro en el intervalo superior de tiempo analizado (1 segundo)
  float _coordYSalida; // coordenada en el eje 'y' del carro en la posición de salida
  float _coordYMetaSuperior; // coordenada en el eje 'y' superior del carro en la posición de meta
  float _coordYMetaInferior; // coordenada en el eje 'y' inferior del carro en la posición de meta
  float _largo; // largo de la imagen del carro
  float _ancho; // ancho de la imagen del carro
  float _desplazamientoTotal; // dezplazamiento total del carro en su recorrido en la pista
  int _sentidoDesplazamiento; // sentido del desplazamiento del carro en la pista
  int _jugador; // jugador que está en la pista
  float _aceleracion; // cambio en el número de pixel
  float _ajusteAceleracion; // ajuste en la aceleración
  float _movimiento; // movimiento aplicado en el sentido que va el carro
  float _ajusteMovimiento; // ajuste en el movimiento del carro
  float _variacionTiempo; // control de ciclos por segundo
  float _tiempoCar1; // tiempo utilizado por el carro 1
  float _tiempoCar2; // tiempo utilizado por el carro 2
  float _t0; // tiempo en el momento cero en milésimas de segundo
  boolean _estadoRaceCar1; // valida si finaliza la vuelta del carro 1
  boolean _estadoRaceCar2; // valida si finaliza la vuelta del carro 2
  /*
  Constructor de la clase Game que inicializa las variables del juego, recibe como
   parámetro el ancho, el ato del carro, y las coordenadas de salida 'X' y 'Y'
   **/
  Game (float pAncho, float pLargo, float pCoordX, float pCoordY) {
    imgs = new PImage[9];
    _aceleracionMedia = 0;
    //_velocidadFinal = 0;
    _velocidadInicial = 0;
    _velocidadMedia = 0;
    _coordXInicial = pCoordX;
    _coordX = pCoordX;
    _coordXSalida = pCoordX;
    _coordXMeta = pCoordX + pLargo;
    _coordYInicial = pCoordY;
    _coordY = pCoordY;
    _coordYSalida = pCoordY;
    _coordYMetaSuperior = 611; // ajustar
    _coordYMetaInferior = 691; // ajustar
    _largo = pLargo;
    _ancho = pAncho;
    _desplazamientoTotal = 0; 
    _sentidoDesplazamiento = 1;
    _jugador = 1;
    _aceleracion = 0;
    _ajusteAceleracion = 0.1;
    _movimiento = 0;
    _ajusteMovimiento = 0;
    _variacionTiempo = 0;
    _t0 = 0;
    _estadoRaceCar1 =  false;
    _estadoRaceCar2 = false;
    _tiempoCar1 = 0;
    _tiempoCar2 = 0;
    _velocidadMediaCar1 = 0;
    _velocidadMediaCar2 = 0;
  }
  /*
  Método:          setCoordX
   Descripción:     setter de la variable coordX
   **/
  void setCoordX(float pCoordX) {
    _coordX = pCoordX;
  }
  /*
  Método:          setCoordY
   Descripción:     setter de la variable coordY
   **/
  void setCoordY(float pCoordY) {
    _coordY = pCoordY;
  }
  /*
  Método:          cargarImanenes
   Descripción:     Método que permite cargar las imágenes del juego
   **/
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

  /*
  Método:          inicializarPrimerJugador
   Descripción:     Método que permite cargar la imagen del carro del primer jugador
   **/
  void inicializarPrimerasImagenes() {
    _car = imgs[1];
    _fondo = imgs[8];
  }

  /*
  Método:          controlTiempo
   Descripción:     Método que permite llevar el control del tiempo de cada jugador, así
   como el tiempo previo de salida de cada uno de los jugadores
   **/
  String controlTiempo(float pTiempoJuego, float pTiempoXJugador, float pTiempoPrevio) {
    if (pTiempoJuego <= pTiempoPrevio) { // segundos para iniciar 1er jugador
      return "Inicia el jugador uno en : " + (tiempoPrevio - pTiempoJuego);
    } else if (pTiempoJuego > pTiempoPrevio &&
      pTiempoJuego <= pTiempoXJugador + pTiempoPrevio) { // tiempo 1er jugador
      return "Tiempo: " + (pTiempoXJugador + tiempoPrevio - pTiempoJuego);
    } else if (pTiempoJuego > tiempoXJugador + pTiempoPrevio &&
      pTiempoJuego <= tiempoXJugador + 2 * pTiempoPrevio) { // segundos para iniciar 2do jugador
      return  "Inicia el jugador dos en : " + (pTiempoXJugador + 2 * pTiempoPrevio - pTiempoJuego);
    } else if (pTiempoJuego > pTiempoXJugador + 2 * pTiempoPrevio &&
      pTiempoJuego <= 2 * pTiempoXJugador + 2 * pTiempoPrevio) { // tiempo 2do jugador
      return "Tiempo: " + (2 * pTiempoXJugador + 2 * pTiempoPrevio - pTiempoJuego);
    } else {
      return "Game Over";
    }
  }


  /*
  Método:           play
   Descripción:      Método que permite establecer el valor de los parámetros del juego
   Parámetros:
   pTiempoJuego      variable de tipo float que representa el tiempo de juego en segundos
   pTiempoPrevio     variable de tipo float que representa el tiempo previo de salida de 
   cada jugador en segundos
   pTiempoXJugador   variable de tipo float que representa el tiempo de juego de cada 
   jugador en segundos
   **/
  void play(float pTiempoJuego, float pTiempoXJugador, float pTiempoPrevio) {
    if (pTiempoJuego == 0) {
      inicializarInicio();
    }
    if (pTiempoJuego > 0 && pTiempoJuego <= pTiempoPrevio) {
      inicializarSalidaJugador1();
    }
    if (pTiempoJuego == pTiempoXJugador + pTiempoPrevio) {
      inicializarJugador2();
    }
    if (pTiempoJuego > pTiempoXJugador + pTiempoPrevio &&
      pTiempoJuego <= pTiempoXJugador + 2 * pTiempoPrevio) {
      inicializarSalidaJugador2();
    }
  }
  /*
 Método:           inicializarInicio
   Descripción:      Método que permite inicializar las imágen del inicio del juego
   **/
  void inicializarInicio() {
    _car = imgs[1];
    _fondo = imgs[8];
  }
  /*
 Método:           inicializarSalidaJugador1
   Descripción:      Método que permite inicializar la salida del jugador 1 en el tiempo previo de salida
   **/
  void inicializarSalidaJugador1() {
    _coordX = cX;
    _coordY = cY;
  }
  /*
 Método:           inicializarJugador2
   Descripción:      Método que permite inicializar las variables para la salida del jugador 2
   **/
  void inicializarJugador2() {
    _aceleracionMedia = 0;
    //_velocidadFinal = 0;
    _velocidadInicial = 0;
    _velocidadMedia = 0;
    _coordXInicial = cX;
    _coordX = cX;
    _coordYInicial = cY;
    _coordY = cY;
    _desplazamientoTotal = 0; 
    _sentidoDesplazamiento = 1;
    _car = imgs[5];
    _jugador = 2;
    _aceleracion = 0;
    _ajusteAceleracion = 0.1;
    _movimiento = 0;
    _ajusteMovimiento = 0;
    _variacionTiempo = 0;
    _t0 = 0;
    _estadoRaceCar1 =  false;
  }
  /*
 Método:           inicializarSalidaJugador2
   Descripción:      Método que permite inicializar la salida del jugador 2 en el tiempo previo de salida
   **/
  void inicializarSalidaJugador2() {
    _coordX = cX;
    _coordY = cY;
  }
  /*
 Método:           aceleracionCar
   Descripción:      Método que permite aumentar la aceleración
   **/
  void aceleracionCar(float pTiempoJuego  ) {
    if ( pTiempoJuego > tiempoPrevio && pTiempoJuego <= tiempoXJugador + tiempoPrevio &&
          _estadoRaceCar1 == false ) {
      _aceleracion += 1;
      _ajusteMovimiento = _aceleracion * _ajusteAceleracion;
    } else if (pTiempoJuego > 2 * tiempoPrevio + tiempoXJugador && _estadoRaceCar2 == false) {
    _aceleracion += 1;
      _ajusteMovimiento = _aceleracion * _ajusteAceleracion;
    }
  }

  /*
 Método:           play
   Descripción:      Método que permite
   **/
  void desaceleracionCar() { // cambiar a desplazamiento
    _aceleracion -= 1;
    _ajusteMovimiento = _aceleracion * _ajusteAceleracion;
  }
  void velocidad() {
    //velocidadFinal = _velocidadInicial + aceleracion * 1;
  }

  void setSentidoDesplazamiento(int pSentidoDezplazamiento) {
    if (_sentidoDesplazamiento != pSentidoDezplazamiento) {
      _sentidoDesplazamiento = pSentidoDezplazamiento;
    }
  }

  void giroDerecha() {
    if (_sentidoDesplazamiento != 1) {
      _sentidoDesplazamiento = 1;
    }
    //println("_anchos  " + _ancho + " largo " + _largo);
    if (_ancho != x) {
      _largo = y;
      _ancho = x;
    }

    if (_jugador == 1) {
      _car = imgs[1];
    } else {
      _car = imgs[5];
    }
    //println("_movimiento  " + _movimiento );
  }

  void giroIzqiuerda() {
    if (_sentidoDesplazamiento != 3) {
      _sentidoDesplazamiento = 3;
    }
    //println("_anchos  " + _ancho + " largo " + _largo);
    if (_ancho != x) {
      _largo = y;
      _ancho = x;
    }

    if (_jugador == 1) {
      _car = imgs[3];
    } else {
      _car = imgs[7];
    }
  }

  void giroArriba() {
    if (_sentidoDesplazamiento != 4) {
      _sentidoDesplazamiento = 4;
      //println("sentido " + _sentidoDesplazamiento);
    }
    //println("_anchos  " + _ancho + " _largo " + _largo);
    if (_ancho != y) {
      _largo = x;
      _ancho = y;
    }
    if (_jugador == 1) {
      _car = imgs[0];
    } else {
      _car = imgs[4];
    }
  }

  void giroAbajo() {
    if (_sentidoDesplazamiento != 2) {
      _sentidoDesplazamiento = 2;
    }
    //println("_anchos  " + _ancho + " _largo " + _largo);
    if (_ancho != y) {
      _largo = x;
      _ancho = y;
    }
    if (_jugador == 1) {
      _car = imgs[2];
    } else {
      _car = imgs[6];
    }
  }

  void desplazamiento(float pTiempoJuego) {
    if ( (pTiempoJuego > tiempoPrevio && pTiempoJuego <= tiempoXJugador + tiempoPrevio) ||
      (pTiempoJuego > 2 * tiempoPrevio + tiempoXJugador) ) {
      if (_sentidoDesplazamiento == 1 && _coordX <= 708) {
        _movimiento = _ajusteMovimiento * _aceleracion;
        _coordX += _movimiento;
      }
      if (_sentidoDesplazamiento == 2 && _coordY <= 611) {
        _movimiento = _ajusteMovimiento * _aceleracion;
        _coordY += _movimiento;
      }
      if (_sentidoDesplazamiento == 3 && _coordX >= 9) {
        _movimiento = _ajusteMovimiento * _aceleracion;
        _coordX -= _movimiento;
      }
      if (_sentidoDesplazamiento == 4  && _coordY >= 145) {
        //println("entre desplaz arriba");
        _movimiento = _ajusteMovimiento * _aceleracion;
        _coordY -= _movimiento;
      }
    }
  }
  void cambioTiempo(float pTiempo) {
    _variacionTiempo = (pTiempo - _t0) / 1000;
    _t0 = pTiempo;
    velocidadMedia();
  }
  void velocidadMedia() {
    //_velocidadMediad = _movimiento / _variacionTiempo;
    _velocidadMedia = _movimiento * 22.315;
    aceleracionMedia();
  }
  void aceleracionMedia() { 
    //_aceleracionMedia = (_velocidadMediad - _velocidadInicial) / _variacionTiempo;
    _aceleracionMedia = (_velocidadMedia - _velocidadInicial) * 22.315;
    _velocidadInicial = _velocidadMedia;
    recorridoTotal();
  }
  void recorridoTotal() {
    _desplazamientoTotal += _movimiento;
    stopRace();
  }
  void stopRace() {
    if ( (_desplazamientoTotal > 3000 && _coordX >= cX  && _coordY >= 612 && _coordY <= 691) 
      || (tiempoJuego == tiempoPrevio + tiempoXJugador) ) {
      //println("entra a stop");
      _movimiento = 0;
      _aceleracion = 0;
      if (_tiempoCar1 == 0 && _estadoRaceCar1 ==  false) {
        _tiempoCar1 = tiempoJuego - tiempoPrevio;
        _velocidadMediaCar1 = _desplazamientoTotal / _tiempoCar1;
        println("tiempoCar1 " + _tiempoCar1 +  " tiempoJuego " + tiempoJuego + " tiempoPrevio " + tiempoPrevio);
      } else if (_tiempoCar2 == 0 && _estadoRaceCar2 ==  false && _estadoRaceCar1 ==  true) {
        _tiempoCar2 = tiempoJuego - (2 * tiempoPrevio + tiempoXJugador);
        _estadoRaceCar2 = true;
        _velocidadMediaCar2 = _desplazamientoTotal / _tiempoCar2;
        println("tiempoCar2 " + _tiempoCar2 +  " tiempoJuego " + tiempoJuego + " 2 tiempoPrevio " + (2 * tiempoPrevio) + " tiempoXJugador " + tiempoXJugador);
      }
      _estadoRaceCar1 =  true;
      _desplazamientoTotal = 0;
    }
  }
}
