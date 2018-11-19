function [output_coordinates, output]=shift_withcoordinates(input_coordinates,input,LorH,amount)
if LorH=='L'
    output_coordinates=input_coordinates-amount;
    output=input;
elseif LorH=='H'
    output_coordinates=input_coordinates+amount;
    output=input;
else
    msg='Using the function shift_withcoordinates worong,check the input!!!';
    error(msg);
end