function [encoded_signal] = control_sum_coder(signal,k)
%CONTROL_SUM_CODER koder sygnalu dodajacy sume kontrolna o zadanej dlugosci
%                   na koniec sygnalu
%   signal - sygnal do zakodowania
%   k - ilosc bitow sumy kontrolnej
%   encoded_signal - zakodowany sygnal
    signal_length = length(signal);
    sum = 0;
    % obliczanie sumy
    for i=1:signal_length
        sum = sum + signal(i);
    end
    % zamiana sumy na system dwojkowy
    sum_binary = zeros(1, k);
    for i=k:-1:1
        x = mod(sum, 2);
        sum_binary(i) = x;
        sum = (sum - x) / 2;
    end
    encoded_signal = [signal sum_binary];
end

