# Projekt NiDUC 2 - Symulator systemu ARQ
Aplikacja służąca do symulacji działania systemu ARQ.
Szczegółowa dokumentacja, opis projektu i analiza wyniku znajduje się w pliku ***Raport_z_projektu_NiDUC***
## Uruchomienie
Do otwarcia programu wymagane jest środowisko MATLAB z zainstalowanym pakietem Communications Toolbox.
Aby go uruchomić, należy wybrać plik arq_gui.mlapp i wcisnąć przycisk Run lub F5.
## Działanie
Aplikacja umożliwia symulację przy użyciu dwóch modeli kanału transmisyjnego: kanału KBS (BSC) i kanału Gilberta.
Rodzaje kodowania do wyboru to: bit parzystości, suma kontrolna i CRC32.
Symulator generuje sygnał o zadanej długości, koduje go w wybrany sposób, a następnie generuje zakłócenia przy użyciu odpowiedniego kanału. Jeżeli w sygnale odnalezione zostaną błędy, przesyłany jest on ponownie (maksymalna liczba prób jest wstępnie ustawiona na 100).
Na wyjściu programu pokazywane są trzy wartości: czas wykonania, Bit Error Rate (BER) oraz całkowita nadmiarowość wybranego sposobu kodowania.
### Model kanału KBS (BSC)
W modelu KBS występuje parametr P0, który określa prawdopodobieństwo przekazania błędnej wartości danego bitu. Prawdopodobieństwo to jest takie samo dla każdego bitu sygnału.
W programie losowana jest liczba z przedziału 0..100. Jeżeli wylosowana wartość jest mniejsza lub równa zadanemu P0, następuje przekłamanie bitu. W przeciwnym razie przesłana zostaje poprawna wartość.
### Model kanału Gilberta
W modelu Gilberta kanał ma dwa stany: dobry (D) i zły (Z). 
Prawdopodobieństwo przejścia ze stanu D do Z to PDZ, a prawdopodobieństwo przejścia ze stanu Z do D to PZD.
Prawdopodobieństwo pozostania w stanie D lub Z to odpowiednio 1-PDZ lub 1-PZD.
Prawdopodobieństwo przekłamania w stanie dobrym to PD, natomiast w stanie złym - PZ.
### Bit parzystości
Bit parzystości to reszta z dzielenia sumy bitów w danej części sygnału przez 2. Dodawany jest na koniec każdej z części.
### Suma kontrolna
Jest to suma wszystkich bitów sygnału przycięta do zadanej długości. Suma kontrolna jest dodawana na koniec sygnału. 
### CRC32
CRC, czyli cykliczny kod nadmiarowy, to rodzaj sumy kontrolnej o stałej długości 32 bitów. Kod obliczany jest poprzez dzielenie przez (n+1)-bitowy dzielnik CRC, zwany również wielomianem CRC.
## Parametry wejściowe
Aplikacja udostępnia interfejs graficzny, w którym można uzupełnić parametry, według których sygnał ma być wygenerowany i przesłany.
- **Długość sygnału** - dodatnia liczba całkowita;
- **Maksymalna ilość prób przesłania** - dodatnia liczba całkowita. W przypadku wystąpienia błędu, tyle razy będzie podejmowana próba przesłania sygnału (ograniczenie wprowadzone, aby proces nie trwał w nieskończoność, szczególnie w przypadku wysokiego prawdopodobieństwa wystąpienia błędu)
- **Rodzaj kodowania** - do wyboru: "Bit parzystości", "Suma kontrolna" oraz "CRC32"
- **Parametr kodowania** - w przypadku wyboru bitu parzystości jako rodzaj kodowania, oznacza długość części, na jakie zostanie podzielony sygnał. Jeżeli wybrano sumę kontrolną, wartość pola będzie odpowiadała długości sumy kontrolnej dołączonej na koniec sygnału. Dla wyboru kodowania CRC32 parametr nie jest brany pod uwagę i nie musi być uzupełniony
- **Rodzaj kanału** - do wyboru: "Kanał KBS" oraz "Kanał Gilberta"
- **Prawdopodobieństwo 1** - Jeżeli wybrany rodzaj kanału to kanał KBS, wartość parametru oznacza prawdopodobieństwo wystąpienia błędu dla danego bitu. Dla kanału Gilberta będzie to parametr odpowiadający prawdopodobieństwu przejścia ze stanu D do Z (PDZ). Wartość wpisana w to pole musi być należeć do przedziału [0, 100000].
- **Prawdopodobieństwo 2** - Dla kanału Gilberta parametr odpowiada prawdopodobieństwu przejścia ze stanu Z do D (PZD). W przypadku kanału KBS pole nie jest brane pod uwagę i nie musi być uzupełnione. Wartość wpisana w to pole musi być należeć do przedziału [0, 100000].
- **Prawdopodobieństwo 3** - Dla kanału Gilberta parametr odpowiada prawdopodobieństwu nie wystąpienia błędu w stanie dobrym (PD). W przypadku kanału KBS pole nie jest brane pod uwagę i nie musi być uzupełnione. Wartość wpisana w to pole musi być należeć do przedziału [0, 100000].
- **Prawdopodobieństwo 4** - Dla kanału Gilberta parametr odpowiada prawdopodobieństwu wystąpienia błędu w stanie złym (PZ). W przypadku kanału KBS pole nie jest brane pod uwagę i nie musi być uzupełnione. Wartość wpisana w to pole musi być należeć do przedziału [0, 100000].
## Parametry wyjściowe
W wyniku działania programu zwracane są 4 wartości:
- **Czas transmisji (s)** - łączny czas trwania transmisji sygnału o zadanych parametrach
- **Całkowita nadmiarowość** - całkowita nadmiarowość sygnału o zadanych parametrach
- **Bit Error Rate (BER)** - stosunek ilości przekłamań do liczby przesłanych bitów.
- **Ilość prób przesłania** - ilość podjętych prób przesłania sygnału, równoznaczna z ilością prób, w których przesłany sygnał zawierał błędy
