%Constant
R=2.00; 
Kb=0.1;
Kt=0.2;
Ts=1.8;

%%Constraints
V = 5.00 + (8.00-6.00).*rand(1);
I= 3.00 + (5.00-3.00).*rand(1);
t= 0.0001 + (5.90-0.00).*rand(1);

a = Ts;
b=V+(Kb*Kt/R);
c=(V^2)/R;

qm=((b*c)-(b^2*c^2-(a^2*b*c))^0.5)/(a*b); %max açısal hız

verim=(t*qm)/(V*I);

disp(['Gerilim: ' num2str(V) 'Volt'])
disp(['Akim:' num2str(I) 'Amper'])
disp(['Tork:' num2str(t) 'Nm/Amps'])
disp(['Max. Verim:' num2str(verim) ''])
