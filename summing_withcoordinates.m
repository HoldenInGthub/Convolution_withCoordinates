function [output]=summing_withcoordinates(input,system,start_position)
len=length(input);
output=0;
for i=1:1:len
    output=output+input(i)*system(start_position+i-1);
end