function [output]=summing_withcoordinates(input,system,start_position)
len=length(input);
output=0;
for i=1:1:len
    if start_position<0
        
    end
    system_position=start_position+i-1;
    output=output+input(i)*system(system_position);
end