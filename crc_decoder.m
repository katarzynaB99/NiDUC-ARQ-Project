function [decoded_signal, error] = crc_decoder(signal)
%CRC_DECODER Summary of this function goes here
%   Detailed explanation goes here
    signal_length = length(signal);
    decoded_signal = signal(1:signal_length-32);
    sum_copy = signal(signal_length-31:signal_length);
    signal = crc_coder(signal(1:signal_length-32));
    if sum_copy == signal(signal_length-31:signal_length)
        error = 0;
    else
        error = 1;
    end
end