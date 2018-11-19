clc 
clear all
close all

% Use this function only for discrete-time signal processing


%% This is your input signal
input_coordinates=[-3 -2 -1 0 1 2 3];
input_x=[1 1 1 1 1 1 1];

%% This is your system response
system_coordinates=[0 1 2 3];
system_x=[1 1 1 1];

%% calculate the convolution
[output_coordinates,output_x]=convolution_withcoordinates(input_coordinates,input_x,system_coordinates,system_x);

%% plot pic
figure(1);
subplot(311);
stem(input_coordinates,input_x);
grid on;
grid minor;
xlim([-4 8]);
ylim([-.2 1.2]);
title('input signal');


figure(1);
subplot(312);
stem(system_coordinates,system_x);
grid on;
grid minor;
xlim([-4 8]);
ylim([-.2 1.2]);
title('system response');


figure(1);
subplot(313);
stem(output_coordinates,output_x);
grid on;
grid minor;
xlim([-4 8]);
ylim([-.2 4.2]);
title('output signal');