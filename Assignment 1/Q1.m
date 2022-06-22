%% Assignemnt Q1
x = zeros(100,1);  % mole fraction in Liquid Phase
y = zeros(100,1);  % mole fraction in Vapor Phase
x(1) = 0.01;
for i = 2:100
    x(i) = x(i-1)+0.01;
end
p=760;
T = zeros(100,1);  % temperature 
T1sat = Tsat(4.9231,1432.526,-61.819,760); %Calculating Saturated temperature using Antoine Equations
T2sat = Tsat(3.55959,643.748,-198.043,760);
for i = 1:100
    x1 = x(i);
    x2 = 1-x(i);
    T(i) = x(i)*T1sat + (x2)*T2sat;                        
    P1sat = Antoine(4.9231,1432.526,-61.819,T(i));
    P2sat = Antoine(3.55959,643.748,-198.043,T(i));
    P = x1*P1sat + x2*P2sat;  %Using Rault's Law yP=x*Psat
    
    y1 = (x1*P1sat)/P;  % Calculating mole fraction in Vapor Phase
    y(i) = y1; 
end
%% Plotting y Vs x
figure
plot(x,y,'.');
xlim([0,1]);
xlabel('x');
ylabel('y');
title('y Vs x Plot');
%% function to calculate Psat using Antoine equation
function [psat] = Antoine(a,b,c,T)                
    psat = 10.^((a-(b/(c+(T)))));
end

%% function to Calculate Tsat 
function [T] = Tsat(a,b,c,p)  
    T=(b/(a-log10(p)))-c;
end

