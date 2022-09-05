function z= my_objfun(x)
% x(1)-->V(volt)
% x(2)-->I(akim)
% x(3)-->t(tork)
%%%%%%%%%%%%%%%%%%%%%%%%
% V,I,t de�erleri belirlenen k�s�tlar aral���nda random olarak �retilip fonksiyon parametreleri olarak yerine yaz�l�r
%%%%%%%%%%%%%%%%%%%%%%%
% sabit kabul edilen de�erler
% R=2.00;
% Ts = 1.8;
% Kb=0.1;
% Kt=0.2;
%%%%
%z =verim 
%objective function:
z=(x(3)*(((x(1)+0.15)*((x(1)^2)/2.00))-((x(1)+0.15)^2*((x(1)^2)/2.00)^2-(1.8^2*(x(1)+0.15)*((x(1)^2)/2.00)))^0.5)/(1.8*(x(1)+0.15)))/(x(1)*x(2));

end