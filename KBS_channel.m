function [output_signal, generated_errors] = KBS_channel(input_signal, error_probability)
%KBS_CHANNEL Funkcja generujaca zaklocenia w sygnale z zadanym
%            prawdopodobienstwem
%   input_signal - sygnal wejsciowy
%   error_probability - prawdopodobienstwo wystapienia bledu (liczba
%                       calkowita z przedzialu 0..100)
%   output_signal - sygnal koncowy z losowymi zakloceniami

    signal_length = length(input_signal);
    output_signal = zeros(1, signal_length);
    generated_errors = 0;
    
    % generowanie zaklocen
    for i=1:signal_length
        x = randi(100000);
        if le(x, error_probability)
            %przeklamanie bitu
            generated_errors = generated_errors + 1;
            if input_signal == 1
                output_signal(i) = 0;
            else
                output_signal(i) = 1;
            end
        else
            %prawdziwa wartosc bitu
            output_signal(i) = input_signal(i);
        end
    end
end

