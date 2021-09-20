clear;
clc;

N = 500;
t_1 = linspace(-pi,pi,N);


syms x y v_x v_y a_x a_y t;

x = 8*(sin(t)).^3;
y = 8*(sin(2*t)).^3;

v_x = diff(x,t);
v_y = diff(y,t);

a_x = diff(v_x,t);
a_y = diff(v_y,t);

v_t = sqrt((v_x)^2 + (v_y)^2);
omega_t = (v_x*a_y - v_y*a_x)/(v_x^2 + v_y^2);

%Plotting velocities
hold on;
subplot(211),fplot(v_t,[-pi pi],'linewidth',2)
title('Linear Velocities'),
xlabel("time"),ylabel("v_t");

subplot(212),fplot(omega_t,[-pi pi],'linewidth',2)
title('Angular Velocities')
xlabel("time"),ylabel("\omega_t");

% Creating Animated gif
T_s = 2*pi/N;


h = figure;
axis tight manual % this ensures that getframe() returns a consistent size
filename = 'anim.gif';
for n = 1:5:N
    fplot(x,y,'k');
    hold on;
    fplot(x,y,[-pi -pi+T_s*n],'b','linewidth',2),title("Trajectory");
    drawnow 
      % Capture the plot as an image 
      frame = getframe(h); 
      im = frame2im(frame); 
      [imind,cm] = rgb2ind(im,256); 
      % Write to the GIF File 
      if n == 1 
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
      else 
          imwrite(imind,cm,filename,'gif','WriteMode','append'); 
      end
end