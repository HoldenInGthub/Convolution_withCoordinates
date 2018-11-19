function [output_coordinates,output]=offset_withzero(input_coordinates,input,LorH,Amount)
offset_Matrix=zeros(1,Amount);
offset_coordinates_Matrix=zeros(1,Amount);
if LorH=='L'
    input_coordinates_LSB=input_coordinates(1);
    output=[offset_Matrix input];
    for i=1:1:Amount
        offset_coordinates_Matrix(Amount-i+1)=input_coordinates_LSB-i;
    end
    output_coordinates=[offset_coordinates_Matrix input_coordinates];
elseif LorH=='H'
    input_coordinates_HSB=input_coordinates(length(input_coordinates));
    output=[input offset_Matrix];
    for i=1:1:Amount
        offset_coordinates_Matrix(i)=input_coordinates_HSB+i;
    end
    output_coordinates=[input_coordinates offset_coordinates_Matrix];
else
    msg='Using offset_withzero function in a wrong way, Check the input!!!';
    error(msg);
end