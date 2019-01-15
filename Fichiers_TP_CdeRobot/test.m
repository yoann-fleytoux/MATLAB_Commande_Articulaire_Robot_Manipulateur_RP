sys = [0;0];
Km_R = 0.3;
Beff = 1/80;
Jm = 1/100;
R = [1/200 1/30 1];
m = 15;
wn = 4;

%Définition Jefficaces, K et KD
Jeff200 = Jm+(R(1)^2)*m;
Jeff30 = Jm+R(2)^2*m;
Jeff1 = Jm+R(3)^2*m;

K200 =(wn^2)*Jeff200/Km_R
K30 =(wn^2)*Jeff30/Km_R
K1 =(wn^2)*Jeff1/Km_R

KD200 = ((K200/2)-(Beff/Km_R))
KD30 = ((K30/2)-(Beff/Km_R))
KD1 = ((K1/2)-(Beff/Km_R))

r = R(1)
Jeff = Jeff200
K = K200
KD = KD200

Ti = 0.8
