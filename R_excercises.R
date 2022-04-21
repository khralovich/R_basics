---
  title: "Praca zaliczeniowa"
author: "Anastasiya Khralovich"
date: "1/25/2022"
output: html_document
---
  
  ### Zadanie 1 
  
  **Treść:**
  
  Stworzyc ramke danych o nazwie osoby, ktora sklada sie z siedmiu obserwacji i dwoch zmiennych: wzrost i waga. Uzupelnic ja danymi wg wlasnego uznania (ale racjonalnie!). 

* Nastepnie, z wykorzystaniem funkcji: str(), ktora pozwala na poznanie struktury obiektu, head(), ktora pozwala na poznanie kilku pierwszych obiektow w zbiorze, tail(), ktora pozwala na poznanie kilku ostatnich obiektow w zbiorze, dim(), ktora pozwala na poznanie wymiaru rozwazanego obiektu, oraz summary() ktora pozwala na wyznaczenie statystyk opisowych w obiekcie, przeprowadzic podstawowa inspekcje danych.

*BTW. Pamietaj, ze za pomoca komendy head(osoby,3) mozesz spowodowac, ze wyswietli sie mniejsza liczba obiektow (tj. 3). Analogicznie jest dla funkcji tail().*
  
  **Rozwiązanie:**
  
  ```{r}


# Tworzymy ramke danych (waga w kg, wzrost w cm) przy pomocy wektorow:

wzrost = c(1.67, 1.76, 1.81, 1.85, 1.52, 1.88, 1.74)
waga =  c(56, 77, 93, 110,  42, 78, 67)

osoby <- data.frame(wzrost, waga)

# Dodajemy numeracje zeby zwiekszyc czytelnosc:
rownames(osoby) <- c(1, 2, 3, 4, 5, 6, 7)

# Tak wyglada ramka:
osoby

#Struktura ramki: sklada sie z 7 obserwacji i 2 zmiennych
str(osoby)


# Pierwsze 3 objekty:
head(osoby, 3)

# Try ostatnie objekty:
tail(osoby, 3)

# 7 wierszy, 2 kolumny:
dim(osoby)


# Statystyki poszczegolnych zmiennych ( median, mean, max, 3rd Qu):
summary(osoby)
```


### Zadanie 2

**Treść:**
  
  Na zajeciach uzywalismy funkcji sample(). Sluzy ona do losowania danych z pewnej proby. Argumenty tej funkcji to: x - mozliwe wyniki losowania, size - liczba wylosowanych liczb, replace - informacja, czy losujemy ze zwracaniem.

* Wygeneruj 20 wynikow rzutu kostka do gry. Nazwij te zmienna proba. Ile wynosi srednia i odchylenie standardowe?
  
  * Wygeneruj 100 wynikow rzutu moneta. Nazwij te zmienna rzut (uwaga: jako 1 mozesz oznaczyc orla, jako 0 reszke). Ile wypadlo orlow?
  
  * Wylosuj (bez zwracania) 10 liczb ze zbioru liczb naturalnych od 0 do 100.

* Poznaj funkcje rnorm, rt oraz rpoisson. Na wymyslonym przez siebie przykladzie, zastosuj jedna z w/w funkcji.


**Rozwiązanie:**
  
  ```{r}

# Generujemy 20 rzutow, te wartosci będą przechowywane w zmiennej:
proba = sample(1:6, 20, replace=T)

# Tak wyglada wynik losowania:
proba

# Srednia i odchylenie standardowe:
mean(proba)
sd(proba)


# 100 rzutow moneta (1 - orzel, 0 - reszka):
rzut <- sample(0:1, 100, replace=T)

# Tak wyglada wynik losowania:
rzut

# Liczymy, ile wypadlo orlow:
ilosc_orlow = length(rzut[rzut<1])

ilosc_orlow

# 10 liczb losowych:
liczby_losowe = sample(0:100, 10, replace=F)


# rnorm generuje n losowych parametrow rozkladu normalnego:
rnorm(liczby_losowe,  mean=0, sd=1) 


# Generowanie liczb pseudolosowych z rozkładu t:
rt(liczby_losowe , 2)


# Wyglada na to, że biblioteka, w ktorej sie znajdowała funkcja rpoisson, została zarchiwizowana: https://cran.r-project.org/src/contrib/Archive/rpgm/
# Ja probowalam zainstalowac stara wersje w taki sposob:
# library(remotes)
# install_version("rpgm", "1.0.1")
# Ale nadal RStudio rzuca blędem: could not find function "rpoisson" mimo tego, ze jest ona w tej wersji "1.0.1", ktora probowałam zainstalowac: https://github.com/cran/rpgm/blob/master/R/rpoisson.R
# Znalazlam troche o tej funkcji w dokumentacji, więc mniej-więcej rozumiem, o co chodzi: https://www.rdocumentation.org/packages/rpgm/versions/1.1.2/topics/rpoisson
```



### Zadanie 3

**Treść:**
  
  Uzyj instrukcji if-else oraz funkcji ifesle() do sprawdzenia, czy dowolna liczba jest podzielna przez 5.

**Rozwiązanie:**
  
  ```{r}

dowolna_liczba = sample(1:100, 1)

dowolna_liczba

if(dowolna_liczba %% 5 == 0) {
  paste(c(dowolna_liczba, "jest podzielna przez 5"), collapse = " ")
} else {
  paste(c(dowolna_liczba, "nie jest podzielna przez 5"), collapse = " ")
}

```



### Zadanie 4

**Treść:**
  
  Stworz zmienna ksiazki mowiaca o tym, ile dana osoba przeczytala ksiazek w ostatnim kwartale. Zrob to wg instrukcji ponizej:
  
  ```{r}
ksiazki <- sample(0:4, size = 25, replace = TRUE)
```

* Ile wynosi srednia liczby przeczytanych ksiazek?
  
  * Ile osob przeczytalo przynajmniej trzy ksiazki?
  
  * Ile osob nie przeczytalo zadnej ksiazki?
  
  * Stworz zmienna ksiazki2, ktora bedzie mowila o tym, czy ktos czyta ksiazki (przeczytal min. jedna). Uzyj do tego petli for.

**Rozwiązanie:**
  
  ```{r}

library(dplyr)


ksiazki

# Srednia:
mean(ksiazki)


# Policzymy,ile osob przeczytalo >3 ksiazki:
trzy_ksiazki <- c(ksiazki[ksiazki >= 3])


# Tyle osób przeczytało >3 książki:
length(trzy_ksiazki)


# Policzymy,ile osob nie przeczytalo zadnej ksiazki:
zero_ksiazek <- c(ksiazki[ksiazki %in% 0])

# Tyle osob nie przeczytalo zadnej ksiazki:
length(zero_ksiazek)


# Tworzymy nowa zmienna, ktora pokazuje, ile jedna osoba czyta ksiazek

ksiazki2 <- sample(0:25, size=1)

ksiazki2


# Sprawdzamy, czy ta osoba jest molem ksiazkowym! 

if (ksiazki2 == 0) {
  print("Ta osoba nie czyta książek!")
} else if ( ksiazki2 > 1 && ksiazki2 < 6) {
  print("Ta osoba czyta książki")
} else {
  print("Ta osoba jest prawdziwym molem książkowym! ")
}


```




### Zadanie 5

**Treść:**
  
  Zbudowac funkcje, ktora biorac wektor, wyznacza roznice miedzy srednia arytmetyczna i mediana. Upewnij sie, ze funkcja bedzie ignorowala ew. braki w danych.

**Rozwiązanie:**
  
  ```{r}

# Tworzymy wektor z randomowymi liczbami, zeby wykorzystac jako przyklad:
randomowy_wektor <- sample(1:100, 10, replace=F)

# Tak wyglada ten wektor:
randomowy_wektor

# Tworzymy wektor z brakiem danych:
wektor_braki <-c(1, 5, 8, 9, NA)

# Tak wygląda ten wektor:
wektor_braki 


#Tworzymy funkcje, ktora usuwa brakujace wartości i oblicza roznice pomiedzy mediana i srednia arytmetyczna:
roznica <- function(wektor){
  wektor<-wektor[complete.cases(wektor)]
  mean(wektor) - median(wektor)
}


# Testujemy:

roznica(randomowy_wektor)
roznica(wektor_braki)



```



### Zadanie 6

**Treść:**
  
  Swietnym narzedziem statystycznym dla psychologow jest pakiet psych, ktory miesci wiele potrzebnych i waznych dla nich funkcji.

* Zainstaluj ten pakiet, a nastepnie wczytaj go do pamieci (funkcja library()).

* W pakiecie psych istnieje funkcja describe. Postaraj sie, za jej pomoca, wyswietlic statytyski opisowe dla danych mtcars. Czym sie ona rozni od funkcji summary().


**Rozwiązanie:**
  
  ```{r}

# Wlaczamy pakiet psych po poprzedniej instalacji:

library(psych)

# Ramka danych mtcars po uzyciu funkcji summary() - pokazuje podstawowe wyniki (min, max, median, mean i kwartyle)
summary(mtcars)

# Ramka danych mtcars po uzyciu funkcji describe() - tworzy kolumne dla każdej obserwacji, ma więcej argumentow, niz summary(), co pozwala wybrac rozne opcje dla skosu i kurtozy, specyficzne kwantyle, sprawdzic, czy ramka zawiera zmienne numeryczne etc.

describe(mtcars, skew = T, ranges = T, interp=F)
```


### Zadanie 7

**Treść:**
  
  Stworz zestaw danych lista wg instrukcji ponizej:
  
  ```{r}
lista <- list(palenie <- c(F,T,T,F,F,T,F),
              cyfry <- 0:9,
              macierz <- matrix(sample(1:5,16,replace = T),4,4),
              tekst <- c("Litwo", "ojczyzno", "moja", "ty",
                         "jestes", "jak", "zdrowie"))
```


* Odwolaj sie do obiektu tekst.
* Odwolaj sie do trzeciego elementu wektora cyfry.
* Odwolaj sie do trzeciej kolumny obiektu macierz.
* Zrob to na kilka sposobow.

**Rozwiązanie:**
  
  ```{r}

# To sa nazwy kolumn i wierszy dla macierzy
wiersz  <- c("znamię", "pręcik", "szczypułka")
kolumna <- c("duze", "srednie", "małe")


#Tworzymy nowa liste (żeby pocwiczyc tworzenie list):
kwiaty <- list(rodzaje  =c("lejkowate", "wargowate", "dzwonkowate", "trąbkowate"),
               miodniki = c(T, T, F, F, F, T),
               owoce = 1:3,
               macierz = matrix(4:15, nrow = 3, 3, dimnames = list(wiersz, kolumna)))

#To jest nasza lista:
kwiaty


# Odwolujemy sie do objektu z tekstem ("rodzaje"):
kwiaty[1]
kwiaty[[1]]
kwiaty[["rodzaje"]]
kwiaty$rodzaje


# Odwolujemy się do 3 elementu wektora 'owoce':
kwiaty[[3]][3]
kwiaty$owoce[3]


# Odwolujemy sie do 3 kolumny macierzy:
kwiaty[[4]][, 3]
kwiaty[[4]][, "małe"]


```


### Zadanie 8

**Treść:**
  
  Wykorzystujac funkcje mean() oraz sd() wyznaczyc dwie podstawowe statystyki opisowe, tj. srednia arytmetyczna i odchylenie standardowe.

**Rozwiązanie:**
  
  ```{r}

oceny_monika<- c(3, 4, 4, 5, 5, 3)

#Srednia:
mean(oceny_monika)

# Odchylenie standardowe:
sd(oceny_monika)


```



### Zadanie 9

**Treść:**
  
  Stworzyc obiekt BMI, ktory bedzie przechowywal informacje o wartosciach BMI (ang. body mass index) Wyswietl tylko te osoby, ktorych BMI przyjmuje wartosc wieksza niz 30. Ile jest osob o BMI≤25?
  
  *Uwaga: Wzor, w jaki wyznacza sie BMI, znajdziesz w sieci. Pomysl, jak do rozwiazania zadania wykorzystac funkcje sum() oraz instrukcje warunkowe?*
  
  **Rozwiązanie:**
  
  ```{r}


# Tworzymy zmienne dla danych:
wzrost <- c(1.22, 1.53, 1.88, 1.91, 1.61, 1.68, 1.72, 1.75)
waga <- c(38, 86, 82, 110, 61, 59, 78, 79)
nr <- c(1, 2,3,4,5,6,7,8)
bmi <- c(waga / (wzrost^2))

# Dodajemy nazwy kolumn:
BMI_data <- data.frame(nr, wzrost, waga, bmi)

# Tworzymy ramke  danych dla 8 osób:
colnames(BMI_data ) <- c("osoba", "wzrost, m", "waga, kg", "BMI")

# Tak wyglada ramka danych:
BMI_data 


# Wykorzystujemy funkcje filter() zeby wyswietlic osoby z BMI>30:
BMI_30plus <- BMI_data %>%
  filter (BMI > 30)

BMI_30plus


# Tworzymy objekt, ktora bedzie przechowywał ilosc osob z BMI<=25
counter <-c(0)


# Przy pomocy petli for iterujemy po zmiennej 'BMI':
for (i in BMI_data[,4]) {
  if (i <= 25) {
    counter = counter + 1
  }
}


# Objekt "counter" pokazuje ilosc osób z BMI<=25
counter

```


### Zadanie 10

**Treść:**
  
  Stworz instrukcje warunkowa, ktora majac date (miesiac i rok) odpowie na pytanie o liczbe dni w tym miesiacu.

*Uwaga: Rozsadnie jest przyswoic sobie relacje %in%, pozniej pojdzie z gorki…*
  
  
  **Rozwiązanie:**
  
  ```{r}

# Instalujemy biblioteke, która pozwala generować randomowe daty: 
library("ds4psy")

# Generujemy randomowa date:
random_date <- sample_date(from = "1970-01-01", to = Sys.Date(), size = 1)


# Tak wlasnie ona wyglada:
random_date 

# Prygotowyjemy daty dla roku przystepnego i nieprzystepnego, zeby przetestować nasz kod:
luty_leap_year <- c(as.Date("2000-02-02"))
luty_non_leap_year <- c(as.Date("1900-02-02"))

# To jest objekt pomocniczy, bedziemy przy jego pomocy sprawdzali, ile miesiac ma dni, ponieważ wiemy, ktore miesiace maja 31 dni:
trzydziesci_jeden <- c("stycznia", "marca", "maja", "lipca", "sierpnia", "października", "grudnia") 


# To jest funkcja dla lutego, poniewaz ten miesiac moze mieć 28 lub 29 dni w zalezności od roku.
luty_ile_dni <- function(luty_rok) {
  luty_rok <- as.numeric(format(luty_rok,'%Y'))
  if((luty_rok%%4 == 0) & (luty_rok%%100 == 0) & (luty_rok%%400 == 0)) {
    print("Ten miesiąc ma 29 dni")
  } else if ((luty_rok%%4 == 0) & (luty_rok%%100 == 0) & (luty_rok%%400 != 0)) {
    print("Ten miesiąc ma 28 dni")
  } else if ((luty_rok%%4 == 0) & (luty_rok%%100 != 0)){
    print("Ten miesiąc ma 29 dni")
  }
}


# Tworzymy dunkcje warunkowa zeby sie dowiedziec, ile dni ma miesiac (w przypadku lutego odpalamy funkcję luty_ile_dni):
ile_dni <- function(date) {
  if (months(date) == "lutego") {
    luty_ile_dni(date)
  } else if (months(date) %in% trzydziesci_jeden ) {
    print("Ten miesiąc ma 31 dni")
  } else {
    print("Ten miesiąc ma 30 dni")
  }
}


# Sprawdzamy dla randomowej daty:
ile_dni(random_date)

# Sprawdzamy dla lutego (rok przestępny)
ile_dni(luty_leap_year )

# Sprawdzamy dla lutego (rok nieprzestępny)
ile_dni(luty_non_leap_year)






```
