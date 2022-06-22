%%%%%%%%%%%%%%%%%%%%%  Taking Input From The User  %%%%%%%%%%%%%%%%%%%%%%%%

R=input("Enter Reflux Ratio : ");
Xw=input("Enter bottom product composition : ");
Xf=input("Enter Feed composition : ");
Xd=input("Enter Top product composition : ");
q=input("Enter The value of q : ");

%%%%%%%%%%%%%%%%  Actual Number Of Stages (With Graph)  %%%%%%%%%%%%%%%%%%%

Xint=((Xd*(q-1)/(R+1)+Xf)/(q-R*(q-1)/(R+1)));  % Point Of Intersection Of
Yint=(R/(R+1))*Xint+(Xd/(R+1));                % q-line and enriching
Xint=round(Xint,3);                            % section line
mn1=min([Xint Xd]);
mx1=max([Xint Xd]);
mn2=min([Xint Xf]);
mx2=max([Xint Xf]);
mn3=min([Xint Xw]);
mx3=max([Xint Xw]);
m=(Yint-Xw)/(Xint-Xw);
i1=1000*mn1;i2=1000*mn2;i3=1000*mn3;
x=zeros([1 1000]);
x(1)=0.001;
for i=2:1000
    x(i)=x(i-1)+0.001;
end
y=zeros([1 1000]);                             % Equilibrium Curve
for i=1:1000
    y(i)=x(i)*exp(1.6798/(1+(1.6798*x(i))/(0.9227*(1-x(i)))^2));
    y(i)=round(y(i),3);
end
y1=zeros([1 1000]);                            % Y=X line
for i=1:1000
    y1(i)=x(i);
end
y2=zeros([1 1000]);                            % Enriching Section Line
while x(i1)<=mx1
    y2(i1)=(R/(R+1))*x(i1)+(Xd/(R+1));
    i1=i1+1;
end
y3=zeros([1 1000]);                            % q-line 
while x(i2)<=mx2
    y3(i2)=(q/(q-1))*x(i2)-Xf/(q-1);
    i2=i2+1;
end
y4=zeros([1 1000]);                            %Stripping Section Line
while x(i3)<=mx3
    y4(i3)=m*(x(i3)-Xw)+Xw;
    i3=i3+1;
end
l1=zeros([1 1000]);                            % Y-coordinate of stages
l2=zeros([1 1000]);                            % X-coordinate of stages
l1(1)=Xd;l2(1)=Xd;i=1;
while l2(i)>Xint
    [~,num]=(min(abs(y-l1(i))));
    l2(i+1)=num/1000;
    l1(i+1)=(R/(R+1))*(num/1000)+(Xd/(R+1));
    i=i+1;
end
if l2(i)<Xint
    l1(i)=m*((l2(i))-Xw)+Xw;
end
while l2(i)>Xw
    [~,num]=(min(abs(y-l1(i))));
    l2(i+1)=num/1000;
    l1(i+1)=m*((num/1000)-Xw)+Xw;
    i=i+1;
end
if l2(i)<Xw
    l1(i)=l2(i);
end
i=1;
figure(1)
grid on
plot(x,y,"black",'DisplayName','equilibrium');
xlabel("x");
ylabel("y");
title(" Actual Number Of Stages (With Graph)");
xlim([0 1]);
ylim([0 1]);
hold on
plot(x,y1,'DisplayName','y=x');
hold on
plot(x,y2,'DisplayName','enriching section');
hold on
plot(x,y3,'DisplayName','q-line');
hold on
plot(x,y4,'DisplayName','stripping  section');
hold on
lg=legend;
lg.NumColumns=2;
hold off 
legend('AutoUpdate','off');


while l2(i)>Xw
    line([l2(i+1),l2(i)],[l1(i),l1(i)]);
    line([l2(i+1) l2(i+1)],[l1(i),l1(i+1)]);
    i=i+1;
end
hold off
disp("Actual Number Of Stages(Trays) : ")
disp(i-1);

%%%%%%%%%%%%%%%%%  Minimum Number Of Stages (With Graph)  %%%%%%%%%%%%%%%%%

q1=zeros([1 1000]);                            % Y-coordinate of stages
q2=zeros([1 1000]);                            % X-coordinate of stages
q1(1)=Xd;q2(1)=Xd;i=1;
legend('AutoUpdate','off');
while q2(i)>Xw
    [~,num]=(min(abs(y-q1(i))));
    q2(i+1)=num/1000;
    q1(i+1)=num/1000;
    i=i+1;
end
i=1;
figure(2)
plot(x,y,'black','DisplayName','Equilibrium curve');
xlabel("x");
ylabel("y");
title(" Minimum Number Of Stages (With Graph)");
xlim([0 1]);
ylim([0 1]);
hold on
plot(x,y1,'DisplayName','y=x');
hold on
line([Xw,Xw],[0,Xw],'DisplayName','Stripping line','Color','green');
line([Xf,Xf],[0,Xf],'DisplayName','q-line','Color','cyan');
line([Xd,Xd],[0,Xd],'DisplayName','Enriching section','Color','yellow');
lgd=legend;
lgd.NumColumns=2;
hold off
legend('AutoUpdate','off');
while q2(i)>Xw
    line([q2(i+1),q2(i)],[q1(i),q1(i)]);
    line([q2(i+1) q2(i+1)],[q1(i),q1(i+1)]);
    i=i+1;
end

disp("Minimum Number Of Stages(Trays) : ")
disp(i-1);

%%%%%%%%%%%%%%%%%%%%%%  Minimum Reflux Ratio  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

syms f1(x)
f1(x)=x*exp(1.6798/(1+(1.6798*x)/(0.9227*(1-x)))^2);
syms f2(x)
f2(x)=(q/(q-1))*x-Xf/(q-1);
nump=vpasolve(f1(x)-f2(x)==0,x);
numx=max(nump);
numx=round(numx,3);
numy=f1(numx);
Rm=(numy-Xd)/(numx-numy);
Rm=round(Rm,3);
Rm=abs(Rm);
disp("Minimum Reflux Ratio : ")
disp(Rm);