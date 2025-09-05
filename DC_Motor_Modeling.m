%DCX 22 L Ø22 mm, graphite brushes, sintered bearings

%Parameters from the datasheet

clc

V_an = 48; %V; nominal voltage
R_a = 7.39; %Ohm; armature resistance
L_a = 0.746*10^-3; %H; armature inductance
J_m = 8.85*10^-7; %kgm^2l rotor inertia
I_anl = 26.7*10^-3; %A; no-load current
kfi = 0.0453; %Vs/rad; "torque constant"
B_m = (kfi^2*I_anl)/(V_an-R_a*I_anl); %Nms;  Coulomb friction coefficient
T_m = 3.2*10^-3; %s; mechanical time constant
T_e = 0.1009*10^-3; %electrical time constant

%External loads for the simulink model

T_nl = 0; %Nm; no-load load
T_n = 28.9*10^-3; %Nm; nominal load
T_s = 294*10^-3; %Nm; stall torque

%Transfer function for Omega output /angular velocity/

numerator = [kfi*V_an];
denominator = [(J_m*L_a) (B_m*L_a+J_m*R_a) (kfi^2+B_m*R_a) (0)];
Omega_tf = tf(numerator, denominator)

%Partial fractions using residue command

[r, p, k] = residue(numerator, denominator)

%Transfer function for the Simulink 
% W(s) = Y(s)/U(s) = Omega(s)/V_an(s)=num_sim/den_sim

num_sim = [kfi];
den_sim = [(J_m*L_a) (J_m*R_a+B_m*L_a) (B_m*R_a+kfi^2)];

%%In your homework you have to do the same transfer function for I output!!

%Transfer function for the Simulink 
% W(s) = Y(s)/U(s) = I(s)/V_an(s) = num_sim_current/den_sim_current
numerator_current = [J_m*V_an B_m*V_an];
denominator_current = [(J_m*L_a) (B_m*L_a+J_m*R_a) (kfi^2+B_m*R_a) (0)];
I_tf = tf(numerator_current, denominator_current)

%Partial fractions using residue command

[r, p, k] = residue(numerator_current, denominator_current)

num_sim_current = [J_m B_m] %Jm*s+Bm
den_sim_current = [(J_m*L_a) (J_m*R_a+B_m*L_a) (B_m*R_a+kfi^2)]

