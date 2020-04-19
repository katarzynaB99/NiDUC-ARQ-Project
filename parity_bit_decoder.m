function [ decoded_signal, error_count ] = parity_bit_decoder( signal, k )
%PARITY_BIT_DECODER Summary of this function goes here
%   Detailed explanation goes here
    signal_length = length(signal);
    decoded_signal = [];
    error_count = 0;
    control_sum = 0;
    
    for i=1:signal_length-1
        if mod(i, k+1) == 0
           if mod(control_sum, 2) ~= signal(i)
               error_count = error_count + 1;
           end
           control_sum = 0;
        else
           decoded_signal = [decoded_signal signal(i)];
           control_sum = control_sum + signal(i);
        end
    end
    if mod(control_sum, 2) ~= signal(signal_length)
        error_count = error_count + 1;
    end
end

