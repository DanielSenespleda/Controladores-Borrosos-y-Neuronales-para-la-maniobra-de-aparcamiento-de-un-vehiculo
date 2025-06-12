rosshutdown
clear all
close all

rosinit('http://172.20.10.13:11311', 'Nodehost', '172.20.10.2');

global steering_wheel_angle;
global vel_lineal_ackerman_kmh;

%%DECLARACIÓN DE SUBSCRIBERS

%Odometria
sub_odom=rossubscriber('/robot0/odom');

%Sonars

sonar_0 = rossubscriber('/robot0/sonar_0', rostype.sensor_msgs_Range);
sonar_1 = rossubscriber('/robot0/sonar_1', rostype.sensor_msgs_Range);
sonar_2 = rossubscriber('/robot0/sonar_2', rostype.sensor_msgs_Range);
sonar_3 = rossubscriber('/robot0/sonar_3', rostype.sensor_msgs_Range);
sonar_4 = rossubscriber('/robot0/sonar_4', rostype.sensor_msgs_Range);
sonar_5 = rossubscriber('/robot0/sonar_5', rostype.sensor_msgs_Range);
sonar_6 = rossubscriber('/robot0/sonar_6', rostype.sensor_msgs_Range);
sonar_7 = rossubscriber('/robot0/sonar_7', rostype.sensor_msgs_Range);
sonar_8 = rossubscriber('/robot0/sonar_8', rostype.sensor_msgs_Range);
sonar_9 = rossubscriber('/robot0/sonar_9', rostype.sensor_msgs_Range);
sonar_10 = rossubscriber('/robot0/sonar_10', rostype.sensor_msgs_Range);
sonar_11 = rossubscriber('/robot0/sonar_11', rostype.sensor_msgs_Range);


%DECLARACIÓN DE PUBLISHERS

%Velocidad
pub_vel=rospublisher('/robot0/cmd_vel','geometry_msgs/Twist');

%GENERACION DE MENSAJES
msg_vel=rosmessage(pub_vel);

%Definimos la periodicidad del bucle
r=robotics.Rate(10);

disp('Inicialización ACKERMAN finalizada correctamente');

%% Cargar datos previos si existen
if isfile("datosEntrenamiento.mat")
    load("datosEntrenamiento.mat", "training_data");
else
    training_data = [];
end

%% RECORRIDO 1

distancia=5.8

vel_lineal_ackerman_kmh = -5     
steering_wheel_angle =  0       
avanzar_ackerman

distancia= 5.5

vel_lineal_ackerman_kmh = -3.8     
steering_wheel_angle =  85       
avanzar_ackerman

distancia=2.9

vel_lineal_ackerman_kmh = -2.5     
steering_wheel_angle =  0      
avanzar_ackerman


%% RECORRIDO 2
%Comentado por defecto, descomentar y comentar el recorrido 1 para obtener
%mas datos de entrenamiento
%{
distancia = 6.3;
vel_lineal_ackerman_kmh = -5.2;
steering_wheel_angle = 0;
avanzar_ackerman;

distancia = 1.0;
vel_lineal_ackerman_kmh = -3.7;
steering_wheel_angle = 90;
avanzar_ackerman;

distancia = 1.0;
vel_lineal_ackerman_kmh = -3.7;
steering_wheel_angle = 0;
avanzar_ackerman;

distancia = 2.0;
vel_lineal_ackerman_kmh = -3.7;
steering_wheel_angle = 90;
avanzar_ackerman;

distancia = 2.8;
vel_lineal_ackerman_kmh = -2.6;
steering_wheel_angle = 0;
avanzar_ackerman;
%}

%% Guardar entrenamiento acumulado
save("datosEntrenamiento.mat", "training_data");
disp('Datos añadidos correctamente al conjunto de entrenamiento.');