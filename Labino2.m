%calibrazione microfoni
clear all
clc
close all

%legge e importa i dati sperimentali per ogni microfono 
%per far funzionare il codice dovete inserire il percoso delle tabelle nel vostro pc

mic1 = readtable('/Users/marco/Documents/POLIMI/Veichle Acoustics/Lab2/Dati per studenti/Cal_Mic1_94dB_1kHz.txt');
mic2 = readtable('/Users/marco/Documents/POLIMI/Veichle Acoustics/Lab2/Dati per studenti/Cal_Mic2_94dB_1kHz.txt');
mic3 = readtable('/Users/marco/Documents/POLIMI/Veichle Acoustics/Lab2/Dati per studenti/Cal_Mic3_94dB_1kHz.txt');
mic4 = readtable('/Users/marco/Documents/POLIMI/Veichle Acoustics/Lab2/Dati per studenti/Cal_Mic4_94dB_1kHz.txt');
manichinoL = readtable('/Users/marco/Documents/POLIMI/Veichle Acoustics/Lab2/Dati per studenti/Cal_MicML_945dB_1kHz.txt');
manichinoR = readtable('/Users/marco/Documents/POLIMI/Veichle Acoustics/Lab2/Dati per studenti/Cal_MicMR_945dB_1kHz.txt');

%calibrazione
%variabili
Pref = 2*10^(-5); %Pa
Pref_dB = 94; %dB
Pref_dB_manichino = 94.5;

Prms = Pref * 10^(Pref_dB/20);
Prms_manichino = Pref * 10^(Pref_dB_manichino/20);


%root mean squared di V per confrontarlo con Prms:

%estraggo i valori dei vari V
V(1,:) = table2array(mic1(:,"Var1"));
V(2,:) = table2array(mic2(:,"Var2"));
V(3,:) = table2array(mic3(:,"Var5"));
V(4,:) = table2array(mic4(:,"Var6"));
V(5,:) = table2array(manichinoL(:,"Var3"));
V(6,:) = table2array(manichinoR(:,"Var4"));

%root mean square
V_rms = rms(V,2);

K= zeros(size(V_rms));

%calcoliamo la sensitività
K(1:4) = V_rms(1:4)/Prms;
K(5:6) = V_rms(5:6)/Prms_manichino;

%%

empty = readtable('Dati per studenti/Test_Imp_EmptyCabin.txt');
full = readtable('Dati per studenti/Test_Imp_Cabin&passengers.txt');
ramp = readtable('Dati per studenti/Test_Ramp.txt');

%%


%%

% Parametri del filtro PASSA-ALTO
fs = 12500; % Frequenza di campionamento
order = 4; % Ordine del filtro
cutoff_freq = 10; % Frequenza di taglio in Hz

% Design del filtro passa-alto
[b, a] = butter(order, cutoff_freq / (fs / 2), 'high');

% Filtra i segnali
Hamm = filtfilt(b, a, Hamm); % Segnale del martello filtrato
Mic1 = filtfilt(b, a, Mic1); % Microfono 1 filtrato

% Verifica dei segnali filtrati (opzionale)
figure;
subplot(2,1,1);
plot(Hamm); hold on; title('Hammer Original Signal');
legend('Original');

subplot(2,1,2);
plot(Mic1); hold on;  title('Mic1 Signal Filtered');
legend('Filtered');