%Task 2
clear;
clc;
Task_1;

%Evaluating ICR

r = 0.25;
L = 0.5;
a = 0.25;

t_num = linspace(-pi,pi,N);
%Finding phi_n
v_y = eval(subs(v_y,t,t_num));
v_x = eval(subs(v_x,t,t_num));
phi_n = atan2(v_y,v_x);

%Finding mu
x = eval(subs(x,t,t_num));
y = eval(subs(y,t,t_num));

y1 = [0 y(1:499)];
x1 = [0 x(1:499)];

y_np1 = [y(2:500) 0];
x_np1 = [x(2:500) 0];

x_m = 0.5*(x1+x);
y_m = 0.5*(y1+y);

mu = (sin(phi_n).*(y_m-y)-cos(phi_n).*(x-x_m))./(cos(phi_n).*(y_np1-y)-sin(phi_n).*(x_np1-x));

x_star = x_m - mu.*(y_np1-y);
y_star = y_m - mu.*(x_np1-x);

radii = sqrt((x-x_star).^2+(y-y_star).^2);

theta_1 = atan2(y-y_star,x-x_star);
theta_2 = atan2(y_np1 - y_star,x_np1 - x_star);

delta_phi = theta_1 - theta_2;
delta_phi = wrapToPi(delta_phi);

T = 2*pi/N;
omega_t = delta_phi./(T);
% omega_t = eval(subs(omega_t,t,t_num));

v_R = (radii + a).*omega_t;
v_L = (radii - a).*(omega_t);

omega_L = v_L./r;
omega_R = v_R./r;

figure;

subplot(211),plot(t_num(2:end),omega_L(2:end),'linewidth',2),
title("\omega_L"),xlabel("time"),ylabel("\omega");

subplot(212),plot(t_num(2:end),omega_R(2:end),'linewidth',2),
title("\omega_R"),xlabel("time"),ylabel("\omega");