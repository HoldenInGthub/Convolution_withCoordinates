%2018.10.31
%input 
%       lim1 is a number represents time t1
%       lim2 is a number represents time t2
%       to plot the signal, the signal will be ploted in the time varitioin[lim1,lim2]
%
%       N is the time interval,the more is the number of n,the preciser is the
%       pic you plot.
%       
%       shift is the time shift, for transformation

function [t,x] = unit_step_signal(lim1,lim2,N,shift,ifreverse)
t=lim1:1/N:lim2;

if ifreverse==0
x=zeros(size(t));
x(t>=-shift)=1;
else
x=zeros(size(t));
x(-t>=-shift)=1;    
end 
return;