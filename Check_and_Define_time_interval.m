%return the step interval and a flag
%flag==1 represents the step interval of the two input signals is not
%equal.
%flag=2 represents the input signl wrong.


function [time_interval,chek_flag]=Check_and_Define_time_interval...
    (input_coordinates,system_coordinates)
len_input_coordinates=length(input_coordinates);
len_system_coordinates=length(system_coordinates);

if len_input_coordinates~=1 && len_system_coordinates~=1

    % due to the mechanism of float matlab, we can not use '==' to judge if
    % the difference is zero. So to judge if the unit time intervals of the 
    % two signals are equal. We use a special mechanism. That is if the
    % difference of the two unit time intervals is less than the minimum of
    % the two unit time interval, we think the unit time intevals of the
    % two signals are equal
    time_interval_input=input_coordinates(2)-input_coordinates(1);
    time_interval_system=system_coordinates(2)-system_coordinates(1);
    
    min_time_interval=abs(min(time_interval_input,time_interval_system));
    difference_time_interval=abs((input_coordinates(2)-input_coordinates(1))...
            -(system_coordinates(2)-system_coordinates(1)));
    
    if  difference_time_interval<min_time_interval
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