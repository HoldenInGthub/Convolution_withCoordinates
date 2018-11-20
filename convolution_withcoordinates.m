function [n_output,summing_output]=convolution_withcoordinates(input_coordinates,input_x,system_coordinates,system_x)

%% fix input signal & revesal system signal
system_x_reverse=fliplr(system_x);
system_coordinates_reverse=-fliplr(system_coordinates);

%% label the LSB&HSB of both input and system_reverse
input_coordinates_LSB=input_coordinates(1);
input_coordinates_HSB=input_coordinates(length(input_coordinates));

system_coordinates_reverse_LSB=system_coordinates_reverse(1);
system_coordinates_reverse_HSB=system_coordinates_reverse(length(system_coordinates));

%% Different points for discussion and Matrix Offseting
% set a flag for different situation,it can be helpful when you shift the
% system signal in the next step
case_flag=0;

if      system_coordinates_reverse_LSB >= input_coordinates_HSB
    case_flag=1;
    % offset amount setting
    offset_Amount_L=system_coordinates_reverse_LSB-input_coordinates_LSB;
    offset_Amount_H=length(input_coordinates);
    
    % offset operation
    % Low position offset
    [system_L_offset_coordinates,system_L_offset]=offset_withzero...
        (system_coordinates_reverse,system_x_reverse,'L',offset_Amount_L);
    % High position offset
    [system_after_offset_coordinates,system_after_offset]=offset_withzero...
        (system_L_offset_coordinates,system_L_offset,'H',offset_Amount_H);

elseif  system_coordinates_reverse_HSB <= input_coordinates_LSB
    case_flag=2;
    % offset amount setting
    offset_Amount_L=length(input_coordinates);
    offset_Amount_H=input_coordinates_HSB-system_coordinates_reverse_HSB;
    
    % offset operation
    % Low position offset
    [system_L_offset_coordinates,system_L_offset]=offset_withzero...
        (system_coordinates_reverse,system_x_reverse,'L',offset_Amount_L);
    % High position offset
    [system_after_offset_coordinates,system_after_offset]=offset_withzero...
        (system_L_offset_coordinates,system_L_offset,'H',offset_Amount_H);

elseif  (system_coordinates_reverse_LSB >= input_coordinates_LSB) ...
            && (system_coordinates_reverse_LSB < input_coordinates_HSB)...
            && (system_coordinates_reverse_HSB >= input_coordinates_HSB )
    
    case_flag=3;
    % offset amount setting
    offset_Amount_L=length(input_coordinates);
    offset_Amount_H=length(input_coordinates);
    
    % offset operation
    % Low position offset
    [system_L_offset_coordinates,system_L_offset]=offset_withzero...
        (system_coordinates_reverse,system_x_reverse,'L',offset_Amount_L);
    % High position offset
    [system_after_offset_coordinates,system_after_offset]=offset_withzero...
        (system_L_offset_coordinates,system_L_offset,'H',offset_Amount_H);        
    
elseif  (system_coordinates_reverse_HSB > input_coordinates_LSB) ...
          && (system_coordinates_reverse_HSB <= input_coordinates_HSB)...
          && (system_coordinates_reverse_LSB <= input_coordinates_LSB )
    
    case_flag=4;
    % offset amount setting
    offset_Amount_L=length(input_coordinates);
    offset_Amount_H=length(input_coordinates);
    
    % offset operation
    % Low position offset
    [system_L_offset_coordinates,system_L_offset]=offset_withzero...
        (system_coordinates_reverse,system_x_reverse,'L',offset_Amount_L);
    % High position offset
    [system_after_offset_coordinates,system_after_offset]=offset_withzero...
        (system_L_offset_coordinates,system_L_offset,'H',offset_Amount_H);
      
elseif  (system_coordinates_reverse_LSB > input_coordinates_LSB) ...
          && (system_coordinates_reverse_HSB < input_coordinates_HSB)
    
    case_flag=5;
    % offset amount setting
    offset_Amount_L=length(input_coordinates);
    offset_Amount_H=length(input_coordinates);
    
    % offset operation
    % Low position offset
    [system_L_offset_coordinates,system_L_offset]=offset_withzero...
        (system_coordinates_reverse,system_x_reverse,'L',offset_Amount_L);
    % High position offset
    [system_after_offset_coordinates,system_after_offset]=offset_withzero...
        (system_L_offset_coordinates,system_L_offset,'H',offset_Amount_H);
      
elseif  (system_coordinates_reverse_LSB < input_coordinates_LSB) ...
        && (system_coordinates_reverse_HSB > input_coordinates_HSB)

    case_flag=6;
    % offset amount setting
    offset_Amount_L=length(input_coordinates);
    offset_Amount_H=length(input_coordinates);
    
    % offset operation
    % Low position offset
    [system_L_offset_coordinates,system_L_offset]=offset_withzero...
        (system_coordinates_reverse,system_x_reverse,'L',offset_Amount_L);
    % High position offset
    [system_after_offset_coordinates,system_after_offset]=offset_withzero...
        (system_L_offset_coordinates,system_L_offset,'H',offset_Amount_H);
end

%% shifting and summing
system_after_offset_HSB=system_after_offset_coordinates(length(system_after_offset));
system_after_offset_LSB=system_after_offset_coordinates(1);
if      case_flag==1
    % set amount of the whole shifting
    shifting_amount=system_after_offset_HSB-input_coordinates_HSB;
    summing_output=zeros(1,shifting_amount);
    n_output=zeros(1,shifting_amount);
    for shifting_n=0:1:shifting_amount
        [~, system_after_shifting]...
            =shift_withcoordinates...
            (system_after_offset_coordinates,system_after_offset,'L',shifting_n);
        summing_output(1,shifting_n+1)=summing_withcoordinates...
            (input_x,system_after_shifting,shifting_n+1);
        n_output(1,shifting_n+1)=-shifting_n;
    end
    n_output=fliplr(n_output);
    summing_output=fliplr(summing_output);
elseif  case_flag==2
    % set amount of the whole shifting
    shifting_amount=input_coordinates_LSB-system_after_offset_LSB;
    summing_output=zeros(1,shifting_amount);
    n_output=zeros(1,shifting_amount);
    for shifting_n=0:1:shifting_amount
        [~, system_after_shifting]...
            =shift_withcoordinates...
            (system_after_offset_coordinates,system_after_offset,'H',shifting_n);
        summing_output(1,shifting_n+1)=summing_withcoordinates...
            (input_x,system_after_shifting,...
            length(system_after_offset)-length(input_x)+1-shifting_n);
        n_output(1,shifting_n+1)=shifting_n;
    end
    
elseif  case_flag==3 || case_flag==4 ....
    ||  case_flag==5 || case_flag==6
    % set amount of the whole shifting
    shifting_amount_advance=system_after_offset_HSB-input_coordinates_HSB;
    shifting_amount_delay=input_coordinates_LSB-system_after_offset_LSB;
    shifting_amount=shifting_amount_delay+shifting_amount_advance;
    summing_output=zeros(1,shifting_amount);
    n_output=zeros(1,shifting_amount);
    aid_i=1;
    for shifting_n=shifting_amount_delay:-1:-shifting_amount_advance
        [~, system_after_shifting]...
            =shift_withcoordinates...
            (system_after_offset_coordinates,system_after_offset,'H',shifting_n);
        summing_output(1,aid_i)=summing_withcoordinates...
            (input_x,system_after_shifting,aid_i);
        n_output(1,aid_i)=shifting_n;
        aid_i=aid_i+1;
    end
    n_output=fliplr(n_output);
    summing_output=fliplr(summing_output);
end