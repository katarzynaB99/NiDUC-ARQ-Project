function [output_signal, error_number] = gilbert_channel(input_signal,p_dz,p_zd,p_d,p_z)
%GILBERT_CHANNEL Funkcja generujaca zaklocenia w sygnale z zadanymi
%                prawdopodobienstwami zmiany stanu
%   input_signal - sygnal wejsciowy
%   p_dz - prawdopodobienstwo przejscia ze stanu dobrego do zlego
%   p_zd - prawdopodobienstwo przejscia ze stanu zlego do dobrego
%   output_signal - sygnal koncowy z losowymi zakloceniami
%   state - stan, w ktorym jest uklad; 0 -> stan dobry, 1 -> stan zly

    error_number = 0;
    signal_length = length(input_signal);
    output_signal = zeros(1, signal_length);
    state = 0;
    for i = 1:signal_length
        %określanie czy nastąpiła zmiana stanu
        x = randi(100000);
        if state
            if le(x, p_zd)
                state = 0;
            end
        else
            if le(x, p_dz)
                state = 1;
            end
        end
        x = randi(100000);
        if state
            %określanie przekłamania w stanie złym
            if le(x, p_z)
                output_signal(i) = input_signal(i);
            else
                error_number = error_number + 1;
                if input_signal == 1
                    output_signal(i) = 0;
                else
                    output_signal(i) = 1;
                end
            end
        else
            %określanie przekłamania w stanie dobrym
            if le(x, p_d)
                output_signal(i) = input_signal(i);
            else
                error_number = error_number + 1;
                if input_signal == 1
                    output_signal(i) = 0;
                else
                    output_signal(i) = 1;
                end
            end
        end
    end
end
