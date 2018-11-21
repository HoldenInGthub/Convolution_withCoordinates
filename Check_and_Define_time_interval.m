%return the step interval and a flag
%flag==1 represents the step interval of the two input signals is not
%equal.
%flag=2 represents the input signl wrong.


function [time_interval,chek_flag]=Check_and_Define_time_interval...
    (input_coordinates,system_coordinates)
len_input_coordinates=length(input_coordinates);
len_system_coordinates=length(system_coordinates);

if len_input_coordinates~=1 && len_system_coordinates~=1

    if abs((input_coordinates(2)-input_coordinates(1))...
            -(system_coordinates(2)-system_coordinates(1)))<1e-15
        time_interval=input_coordinates(2)-input_coordinates(1);
        chek_flag=0;
    else
        msg_check_step='Using the function convolution_withcoordinates WRONG! The step interval of the two input signals must be equal';
        chek_flag=1;
        error(msg_check_step);
    end
elseif len_input_coordinates==1 && len_system_coordinates~=1
        time_interval=len_system_coordinates(2)-len_system_coordinates(1);
elseif len_input_coordinates~=1 && len_system_coordinates==1
        time_interval=len_input_coordinates(2)-len_input_coordinates(1);
else
    msg_check_input='Using the function convolution_withcoordinates WRONG! The input signl wrong';
    chek_flag=2;
    error(msg_check_input);
end