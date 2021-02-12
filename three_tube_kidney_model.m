clear all; 
clc; close all;

% The  exchange  of  solute  and  water  in  a  3-tube  model  of
% the  human  kidney  is  described  by  the following system of non-linear ordinary differential equations:

% y′1=a(y3−y1)y1/y2
% y′2=−a(y3−y1)
% y′3={b−c(y3−y5)−ay3(y3−y1)}/y4
% y′4=a(y3−y1)
% y′5=−c(y5−y3)/d,

% a= 100,  b= 0.9,  c= 1000,  d= 10.


% Here,y1,y5 and y3 denote concentrations of the solute in the three tubes, 
% respectively.   
% y2 and y4 denote the flow rates in tubes 1 and 3.
% The initial values variables are as follows:
% y1(0) =y2(0) =y3(0) = 1.0,  y4(0) =−10,  y5(0) = 0.99

%This shows three different initial conditions used and their impact on the
%trajectories - Dynamical system.

y01=[1.0 1.0 1.0 -10 0.99]; 
y02=[1.0 1.0 1.0 -10 0.99026];
y03=[1.0 1.0 1.0 -10 0.9904];

% Time span for integration
t_span = linspace(0,1,1000);


%Using ode23, adavptive time stepping
[t,y1] = ode23s(@(t,y) kidney_model_solver(y), t_span, y01);
[t,y2] = ode23s(@(t,y) kidney_model_solver(y), t_span, y02);
[t,y3] = ode23s(@(t,y) kidney_model_solver(y), t_span, y03);

%post processing
figure(1)
plot(t,y1,'LineWidth',2)
xlabel('$t$','fontsize',14,'interpreter','latex');
ylabel('$y(y5 = 0.99)$','fontsize',14,'interpreter','latex');
legend('y1','y2','y3','y4','y5')


figure(2)
plot(t,y2,'LineWidth',2)
xlabel('$t$','fontsize',14,'interpreter','latex');
ylabel('$y(y5 = 0.99026)$','fontsize',14,'interpreter','latex');
legend('y1','y2','y3','y4','y5')


figure(3)
plot(t,y3,'LineWidth',2)
xlabel('$t$','fontsize',14,'interpreter','latex');
ylabel('$y(y5 = 0.9904)$','fontsize',14,'interpreter','latex');
legend('y1','y2','y3','y4','y5')

%Kidney model solver

 function y_prime = kidney_model_solver(y)
y_prime = zeros(5,1);
a=100;
b=0.9;
c=1000;
d=10;

y_prime(1)= a*(y(3)-y(1))*y(1)/y(2);
y_prime(2)= -a*(y(3)-y(1));
y_prime(3)= (b - c*(y(3)-y(5))- a*y(3)*(y(3)-y(1)))/y(4);
y_prime(4)= a*(y(3)-y(1));
y_prime(5)= -c*(y(5)-y(3))/d;
end



