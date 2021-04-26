@echo off
setlocal enabledelayedexpansion

set initVar=__init__.py
set routesVar=routes.py
set dirForsrc=database models routes schemas 


mkdir apiflask
cd apiflask

REM creacion del readme
fsutil file createnew README.md 0

echo # Estrcutura basica de una api con flask"Cambia el nombrede este titulo">>README.md
echo ## Requisitos:>>README.md
echo - Python 3.6.9>>README.md
echo - LAMP para poder usar MySQL o XAMPP en windows>>README.md
echo - Flask 1.1.2>>README.md
echo - UBUNTU 18.04.5 LTS o windows 10>>README.md
echo ## Variables de entorno:>>README.md
echo.
echo Ubuntu:>>README.md
echo.
echo - export FLASK_APP="app">>README.md
echo - export FLASK_ENV="development">>README.md
echo - export APP_SETTINGS_MODULE="config.local">>README.md
echo.
echo.
echo Windows>>README.md
echo.
echo.
echo ## Como usar este proyecto en UBUNTU 18.04.5 LTS>>README.md
echo.
echo - Estar en la carpeta de api-sepomex>>README.md
echo - Crear el entorno virtual desde la terminal: python3 -m venv venv, si manda un error ejecutar el siguiente comando en terminal: sudo apt install python3-venv>>README.md
echo - Activar el entorno virtual, desde la terminal ejecutar el siguiente comando: . venv/bin/activate>>README.md
echo - Instalar dependencias, en la terminal ejecutar lo siguiente: pip install -r requirements.txt>>README.md
echo.
echo ## Como usar en windows>>README.md
echo - Estar en la carpeta de api-sepomex>>README.md
echo - Crear el entorno virtual desde cmd: py -3 -m venv venv>>README.md
echo - Activar el entorno virtal : .\venv\Scripts\activate.bat>>README.md
echo - Instalar dependencias, en la terminal ejecutar lo siguiente: pip install -r requirements.txt>>README.md
echo.
echo ## Correr la app en local ya sea para ubuntu o windows>>README.md
echo `flask run`>>README.md

echo - set "FLASK_APP=app">>README.md
echo - set "FLASK_ENV=development">>README.md
echo - set "APP_SETTINGS_MODULE=config.local">>README.md

REM Creacion del archivo del entry point
fsutil file createnew app.py 0

echo #entry point: rutas>>app.py

echo import os>>app.py
echo from flask import Flask>>app.py
echo from src import create_app>>app.py

echo settingsModule = os.getenv('APP_SETTINGS_MODULE')>>app.py

echo app = create_app(settingsModule)>>app.py




REM Carpeta de configuraciones
mkdir config
cd config

REM echo.>> __init__.py
REM Configuraciones para flask, base de datos, entorno, etc...

REM __init__.py para indicar que es un paquete
fsutil file createnew !initVar! 0

REM Entorno por defecto, el que se usa actualmente local o produccion

fsutil file createnew default.py 0

echo #Configuracion de la base de datos>>default.py
echo.>>default.py
echo.>>default.py
echo #Entorno>>default.py
echo APP_ENV_LOCAL = 'local'>>default.py
echo APP_ENV_DEVELOPMENT = 'development'>>default.py
echo APP_ENV_PRODUCTION = 'production'>>default.py
echo APP_ENV = ''>>default.py

REM Entorno de desarrollo

fsutil file createnew dev.py 0

echo from .default import *>>dev.py
echo.>>dev.py
echo.>>dev.py
echo APP_ENV = APP_ENV_DEVELOPMENT>>dev.py
echo SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://javier:password12345@localhost/sepomexdb'>>dev.py


REM Entorno local

fsutil file createnew local.py 0

echo #Aqui tienes que colocar tus credenciales de tu base de datos>>local.py
echo from .default import *>>local.py
echo.>>local.py
echo.>>local.py
echo APP_ENV = APP_ENV_LOCAL>>local.py
echo SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://tu_userdb:tu_passworddb@localhost/tu_DB'>>local.py

REM Entorno de produccion

fsutil file createnew prod.py 0

echo #Aqui tienes que colocar tus credenciales de tu base de datos>>prod.py
echo from .default import *>>prod.py
echo.>>prod.py
echo.>>prod.py
echo APP_ENV = APP_ENV_PRODUCTION>>prod.py
echo SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://tu_userdb:tu_passworddb@localhost/tu_DB'>>prod.py

REM Fin del config

cd ..

REM Carpeta source:src. Contiene: la configuracion del entry point para rutas, rutas, db, model, schemas y lo que se necesite o necesites

mkdir src
cd src

REM Carpetas del src, db, models, schemas y routes, puedes agregar mas en la variable dirForsrc si es que lo necesitas

(for %%a in (%dirForsrc%) do ( 
   mkdir %%a 
))

REM Entry point y configuracion para tu proyecto, db, models schemas, etc, lo que necesites

fsutil file createnew !initVar! 0

echo import os >> !initVar!
echo from flask import Flask>> !initVar!
echo from flask_cors import CORS, cross_origin>> !initVar!
echo from flask_sqlalchemy import SQLAlchemy>> !initVar!
echo from flask_marshmallow import Marshmallow >> !initVar!
echo db = SQLAlchemy()>>!initVar!
echo ma = Marshmallow()>>!initVar!
echo def create_app(settingsModule):>>!initVar!
echo    app = Flask(__name__, instance_relative_config=True)>>!initVar!
echo    #Config app>>!initVar!
echo    print("settings module: {}".format(settingsModule))>>!initVar!
echo    app.config.from_object(settingsModule)>>!initVar!
echo    # Cors>>!initVar!
echo    cors = CORS(app)>>!initVar!
echo    app.config['CORS_HEADERS'] = 'Content-Type'>>!initVar!
echo.
echo    # Base de datos>>!initVar!
echo    db.init_app(app)>>!initVar!
echo.
echo    #Para los schemas>>!initVar!
echo    ma.init_app(app)>>!initVar!
echo.
echo    #Aqui deben ir los Blueprints para las rutas que crees.>>!initVar!
echo    #Los Blueprints son para las rutas en este caso.>>!initVar!
echo    #Se recomienda buscar mas sobre estos>>!initVar!
echo    #Blueprints para las rutas>>!initVar!
echo    #Solo esta la ruta de home>>!initVar!
echo    from .routes.home import homeBP>>!initVar!
echo    app.register_blueprint(homeBP)>>!initVar!
echo.
echo.
echo    return app>>!initVar!

REM Creamo lo correspondiente a la bd
cd database
REM Archivo para indicar que es un paquete, en este caso vacio


fsutil file createnew !initVar! 0
REM Aqui yo cree otra carpeta dentro, pero si quieres la puedes omitir, y cambiar la ruta de los paquetes donde la ocupes

mkdir db
cd db
fsutil file createnew !initVar! 0
fsutil file createnew db.py 0

echo from flask import Flask>>db.py
echo from flask_sqlalchemy import SQLAlchemy>>db.py
echo #Este paquete no es necesario, solo es de prueba o lo puedes usar, eso ya depende de lo que requieras o lo que te requieran>>db.py
echo #Aqui puedes importar la configuracion de config para la db, si requirieras usar este paquete.>>db.py
echo.
echo class DB:>>db.py
echo    db = None>>db.py
echo    app = None>>db.py
echo    def __init__(self, app: Flask):>>db.py
echo        #Inicializamos la base de datos>>db.py
echo        self.app = app>>db.py
echo        self.app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://tu_userdb:tu_passworddb@localhost/tu_db'>>db.py
echo        self.app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False>>db.py
echo        self.db = SQLAlchemy(self.app)>>db.py
echo    def getDB(self):>>db.py
echo        return self.db>>db.py
cd ..




REM salimos de la carpeta de database
cd ..

REM entramos a models

cd models

REM indicamos que es un paquete
fsutil file createnew !initVar! 0

REM Model de prueba para codigo postal en base a los datos de sepomex
fsutil file createnew codigopostal.py 0
echo from sqlalchemy.exc import IntegrityError>>codigopostal.py
echo from src import db>>codigopostal.py
echo.
echo class CodigoPostal(db.Model):>>codigopostal.py
echo    __tablename__='codigopostal'>>codigopostal.py
echo    id = db.Column(db.Integer, primary_key=True)>>codigopostal.py
echo    colonia = db.relationship('Colonia', lazy=True, cascade='all, delete-orphan')>>codigopostal.py
echo    def __init__(self, id, nombre):>>codigopostal.py
echo        self.id = id>>codigopostal.py
echo        self.nombre = nombre>>codigopostal.py
echo.    
echo    def createCP(self):>>codigopostal.py
echo        db.session.add(self)>>codigopostal.py
echo        db.session.commit()>>codigopostal.py
echo.
echo    @staticmethod>>codigopostal.py
echo    def getAllCPs():>>codigopostal.py
echo        return CodigoPostal.query.all()>>codigopostal.py
echo.    
echo    @staticmethod>>codigopostal.py
echo    def getCPById(id):>>codigopostal.py
echo        return CodigoPostal.query.get(id)>>codigopostal.py
REM salimos de models
cd ..

REM entramos a routes

cd routes

REM indicamos que es un paquete
fsutil file createnew !initVar! 0
REM Carpeta para la ruta home "/""

mkdir home
cd home

fsutil file createnew !initVar! 0
  
echo from flask import Blueprint>>!initVar!
echo homeBP = Blueprint('homeBP', __name__)>>!initVar!
echo from . import routes>>!initVar!
echo #Blueprint para tener rutas limpias y estrucuturadas>>!initVar!

REM archivo para el blue print

fsutil file createnew !routesVar! 0

echo from flask import current_app, jsonify>>!routesVar!
echo from . import homeBP>>!routesVar!
echo.
echo.
echo @homeBP.route("/")>>!routesVar!
echo def getAllEstado():>>!routesVar!
echo    return 'hola'>>!routesVar!


cd ..



REM Creamos la carpeta de codigo postal de la ruta y su respectivo __init__.py

mkdir codigopostal
cd codigopostal

fsutil file createnew !initVar! 0

REM Blueprint neceseraio para el entry point

echo from flask import Blueprint>>!initVar!
echo codigoPostalBP = Blueprint('codigoPostalBP', __name__)>>!initVar!
echo from . import routes>>!initVar!
echo #Esta configuracion del init es para poder usarlo en el entry point y tener rutas limpias y todo organizado>>!initVar!

fsutil file createnew !routesVar! 0

echo from flask import current_app, jsonify, request>>!routesVar!
echo from . import codigoPostalBP>>!routesVar!
echo from src.models.codigopostal import CodigoPostal>>!routesVar!
echo from src.schemas.codigopostalschema import CodigoPostalSchema>>!routesVar!
echo #Esta ruta solo es para pruebas y tener una nocion del proyecto>>!routesVar!
echo.
echo @codigoPostalBP.route("/codigospostales/", methods=['Get'])>>!routesVar!
echo def getAllCodigosPostales():>>!routesVar!
echo    codigosPostalesSchema = CodigoPostalSchema(many=True)>>!routesVar!
echo    # model>>!routesVar!
echo    codigosPostales = CodigoPostal.getAllCPs()>>!routesVar!
echo    return codigosPostalesSchema.jsonify(codigosPostales)>>!routesVar!
echo.
echo @codigoPostalBP.route("/codigopostal/<int:id>", methods=['Get'])>>!routesVar!
echo def getCPById(id):>>!routesVar!
echo    codigoPostalSchema = CodigoPostalSchema()>>!routesVar!
echo    # model>>!routesVar!
echo    codigoPostal = CodigoPostal.getCPById(id)>>!routesVar!
echo    return codigoPostalSchema.jsonify(codigoPostal)>>!routesVar!
echo.
echo @codigoPostalBP.route("/codigopostal/", methods=['Post'])>>!routesVar!
echo def createCodigoPostal():>>!routesVar!
echo    id = request.json['id']>>!routesVar!
echo    nuevoCodigoPostal = CodigoPostal(id)>>!routesVar!
echo    nuevoCodigoPostal.createCP()>>!routesVar!
echo.    
echo    return jsonify({>>!routesVar!
echo        'ok' : True,>>!routesVar!
echo        'message' : 'Creado con exito'>>!routesVar!
echo    })>>!routesVar!

REM salimos de la carpeta codigopostal
cd ..

REM Salimos de routes
cd ..

REM nos movemos a schemas

cd schemas

fsutil file createnew !initVar! 0

REM schema para codigo postal

fsutil file createnew codigopostalschema.py 0

echo from src import ma>>codigopostalschema.py
echo.
echo class CodigoPostalSchema(ma.Schema):>>codigopostalschema.py
echo    class Meta:>>codigopostalschema.py
echo        fields = ('id', )>>codigopostalschema.py

pause
exit