function [output_signal] = gilbert_channel(input_signal,p_dz,p_zd)
%GILBERT_CHANNEL Funkcja generujaca zaklocenia w sygnale z zadanym
%                prawdopodobienstwem zmiany stanu
%   input_signal - sygnal wejsciowy
%   p_dz - prawdopodobienstwo przejscia ze stanu dobrego do zlego
%   p_zd - prawdopodobienstwo przejscia ze stanu zlego do dobrego
%   output_signal - sygnal koncowy z losowymi zakloceniami
%   state - stan, w ktorym jest uklad; 0 -> stan dobry, 1 -> stan zly

    signal_length = length(input_signal);
    output_signal = zeros(1, signal_length);
    state = 0;
    for i = 1:signal_length
        if state
            if input_signal == 1
                output_signal(i) = 0;
            else
                output_signal(i) = 1;
            end
            x = randi(100);
            if x>p_zd
                state = 0;
            end
        else
            output_signal(i) = input_signal(i);
            x = randi(100);
            if x>p_dz
                state = 1;
            end
        end
    end
end

