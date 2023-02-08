% Intelektualiosios sistemos
% Laboratorinis darbas Nr.2
% Tadas Vasiliauskas DISfm-22

% Pasirinkime DNT struktūra
% Vienas įėjimas x
% Vienas paslėptasis sluoksnis su 5 neuronais
% Vienas išėjimas y1

clc
clear all

% 1. Surinkti/paruošti mokymo duomenų rinkinį
X = 0.1:1/22:1;
y1 = ((1 + 0.6*sin(2*pi*X/0.7)) + 0.3*sin(2*pi*X))/2;

% 2. Sugeneruoti pradines ryšių svorių reikšmes
% sluoksnio parametrai
w11_1 = randn(1); b1_1 = randn(1);
w21_1 = randn(1); b2_1 = randn(1);
w31_1 = randn(1); b3_1 = randn(1);
w41_1 = randn(1); b4_1 = randn(1);
w51_1 = randn(1); b5_1 = randn(1);

w11_2 = randn(1); b1_2 = rand(1);
w12_2 = randn(1); 
w13_2 = randn(1); 
w14_2 = randn(1); 
w15_2 = randn(1); 

% 3. Apskaičiuoti tinklo atsaką(momentinį)
% pasverta suma 1 sluoksnyje
mok_zing = 0.15;
for indx = 1:20000
    for n = 1:20

        v1_1 = X(n)*w11_1 + b1_1;
        v2_1 = X(n)*w21_1 + b2_1;
        v3_1 = X(n)*w31_1 + b3_1;
        v4_1 = X(n)*w41_1 + b4_1;
        v5_1 = X(n)*w51_1 + b5_1;
        
        % aktyvavimo f-ja 1 sluoknyje
        y1_1 = 1/(1+exp(-v1_1));
        y2_1 = 1/(1+exp(-v2_1));
        y3_1 = 1/(1+exp(-v3_1));
        y4_1 = 1/(1+exp(-v4_1));
        y5_1 = 1/(1+exp(-v5_1));
        
        % pasverta suma išėjimo sluoksnyje
        v1_2 = y1_1 * w11_2 + y2_1 * w12_2 + y3_1 * w13_2 + y4_1 * w14_2 + y5_1 * w15_2 + b1_2;
        
        % skaičiuojame išėjimą/tinklo atsaką pritaikydami aktyvavimo f-jas
        y1_apskaiciuota = v1_2;
        
        % 4. Palyginti su norimu atsaku ir apskaičiuoti klaidą
        e1 = y1(n) - y1_apskaiciuota;
        
        % 5. Atnaujinti ryšių svorius taip, kad klaida mažėtų (atlikti tinklo
        % mokymą)
        delta_out_1 = e1;
        
        delta_1_1 = y1_1*(1-y1_1)*(delta_out_1*w11_2);
        delta_2_1 = y2_1*(1-y2_1)*(delta_out_1*w12_2);
        delta_3_1 = y3_1*(1-y3_1)*(delta_out_1*w13_2);
        delta_4_1 = y4_1*(1-y4_1)*(delta_out_1*w14_2);
        delta_5_1 = y5_1*(1-y5_1)*(delta_out_1*w15_2);
        
        % atnaujinti svorius
        w11_2 = w11_2 + mok_zing*delta_out_1*y1_1;
        w12_2 = w12_2 + mok_zing*delta_out_1*y2_1;
        w13_2 = w13_2 + mok_zing*delta_out_1*y3_1;
        w14_2 = w14_2 + mok_zing*delta_out_1*y4_1;
        w15_2 = w15_2 + mok_zing*delta_out_1*y5_1;
        b1_2 = b1_2 + mok_zing*delta_out_1;
        
        % atnaujinti svorius paslėptame sluoksnyje
        w11_1 = w11_1 + mok_zing*delta_1_1*X(n);
        w21_1 = w21_1 + mok_zing*delta_2_1*X(n);
        w31_1 = w31_1 + mok_zing*delta_3_1*X(n);
        w41_1 = w41_1 + mok_zing*delta_4_1*X(n);
        w51_1 = w51_1 + mok_zing*delta_5_1*X(n);
        
        b1_1 = b1_1 + mok_zing*delta_1_1;
        b2_1 = b2_1 + mok_zing*delta_2_1;
        b3_1 = b3_1 + mok_zing*delta_3_1;
        b4_1 = b4_1 + mok_zing*delta_4_1;
        b5_1 = b5_1 + mok_zing*delta_5_1;
            end
        end

% Apskaičiuoti tinklo atsaką(momentinį)
for m = 1:20

    v1_1 = X(m)*w11_1 + b1_1;
    v2_1 = X(m)*w21_1 + b2_1;
    v3_1 = X(m)*w31_1 + b3_1;
    v4_1 = X(m)*w41_1 + b4_1;
    v5_1 = X(m)*w51_1 + b5_1;

    % aktyvavimo f-ja
    y1_1 = 1/(1+exp(-v1_1));
    y2_1 = 1/(1+exp(-v2_1));
    y3_1 = 1/(1+exp(-v3_1));
    y4_1 = 1/(1+exp(-v4_1));
    y5_1 = 1/(1+exp(-v5_1));

    % pasverta suma išėjimo sluoksnyje
    v1_2 = y1_1 * w11_2 + y2_1 * w12_2 + y3_1 * w13_2 + y4_1 * w14_2 + y5_1 * w15_2 + b1_2;

    % skaičiuojame išėjimą/tinklo atsaką pritaikydami aktyvavimo f-jas
    y1_apskaiciuota(m) = v1_2;
end

plot(X, y1, 'kx',X,y1_apskaiciuota,'gx')