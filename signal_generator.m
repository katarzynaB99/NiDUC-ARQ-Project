function [ signal ] = signal_generator( n )
%SIGNAL_GENERATOR generator losowego sygnalu o zadanej dlugosci
%   n - dlugosc sygnalu
%   signal - wygenerowany sygnal

    signal = randi([0,1], 1, n);
    
end

