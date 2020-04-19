function [ signal ] = signal_generator( n )
%SIGNAL_GENERATOR Summary of this function goes here
%   Detailed explanation goes here
    signal = randi([0,1], 1, n);
    disp(signal);
end

