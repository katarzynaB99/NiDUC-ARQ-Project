function [ decoded_signal, is_correct ] = control_sum_decoder( signal, k )
%CONTROL_SUM_DECODER dekoder sygnalu z suma kontrolna o dlugosci k
%   signal - zadany sygnal
%   k - dlugosc sumy kontrolnej
%   decoded_signal - odkodowany sygnal (bez sumy kontrolnej)
%   is_correcr - 1, jesli sygnal jest poprawny; 0, jesli sygnal jest
%                niepoprawny
    encoded_length = length(signal);
    decoded_length = encoded_length - k;
    decoded_signal = zeros(1, decoded_length);
    
    checksum = 0;
    
    for i = 1 : decoded_length
        decoded_signal(i) = signal(i);
        checksum = checksum + signal(i);
    end
    
    current_checksum = zeros(1, k);
    for i = k : -1 : 1
        x = mod(checksum, 2);
        current_checksum(i) = x;
        checksum = (checksum - x) / 2;
    end
    
    %porownanie sum
    is_correct = 1;
    for i = 1 : k
        if current_checksum(i) ~= signal(i + decoded_length)
            is_correct = 0;
            break;
        end
    end
end

