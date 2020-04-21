function [encoded_signal] = parity_bit_encoder(signal,k)
%PARITY_BIT_ENCODER Koder bitu parzystosci
%   Bit parzystosci zostaje dodany co k bitow (na koniec kazdej czesci)
%   k - ilosc bitow w czesci
%   encoded_signal - zakodowany sygnal
    signal_length = length(signal);
    encoded_signal = [];
    one_count = 0;
    for i = 1: signal_length
        encoded_signal = [encoded_signal signal(i)];
        one_count = one_count + signal(i);
        if mod(i,k) == 0
            encoded_signal =[encoded_signal mod(one_count,2)];
            one_count = 0;
        end
    end
    if mod(signal_length,k) > 0
        encoded_signal =[encoded_signal mod(one_count,2)];
    end
end