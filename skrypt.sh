#!/bin/bash

if [ $# -eq 0 ]
then
	echo "Nie wybrano zadnej opcji"
	echo "(Wpisz $0 -h aby uzyskac pomoc)"
	echo ""
	exit 0
	#Instrukcja warunkowa ktora wyswietla komunikat jezeli zaden parametr nie zostal wywolany
fi

while getopts "fieshbc" option;
do
	case ${option}
	in
		i)
			getent group # wypisuje nazwy uzytkownikow ich UID oraz grupy do ktorych naleza
			last # wypisuje ostatnia aktywnosc uzytkownikow
			;;
		s)
			ls -a /bin > tekst1.txt # tworzy plik tekst1.txt oraz zapisuje do niego wynik polecenia ls -a
			chmod a+x tekst1.txt # nadaje prawa do pliku tekst1.txt aby mozna bylo go wyslac
			mail -s "Mail na projekt" mistick0406@gmail.com < tekst1.txt # wysyla plik tekst1.txt na mojego maila
			;;
		e)	
			ls -a /etc/[a]* # wyswietla na ekranie zawartosc wszystkich plikow zaczynajacych sie na "a"
			ls -a /etc/[a]* /bin > efekt 2>/dev/null # skierowywuje wynik do pliku efekt a bledy do /dev/null

			;;
		b)
			find /etc -type f -size +100c > rezultat 2>>rezultat # wyszukuje pliki wieksze niz 100 bajtow i skierowywuje wynik do pliku rezultat razem z bledami
			;;
		c)
			find /etc -type f -size -100c | more # wyszukuje pliki mniejsze niz 100 bajtow oraz wyswietla wynik w czesciach od gory
			find /etc -type f -size -100c >> efekt # wyszukuje pliki mniejsze niz 100 bajtow oraz dodaje wynik do pliku efekt
			;;
		f)
			echo "Wprowadz nazwe folderu ktorego szukasz" 
			read LOOKFOR # wyczytuje podana przez uzytkownika nazwe katalogu
			if [ -z "$LOOKFOR" ]; then # instrukcja sprawdzajaca czy zostala podana nazwa katalogu
				echo -e "Nie wprowadzono nazwy folderu do wyszukania!"
				exit 0
			else
				find / -type d -name $LOOKFOR -print 2>/dev/null # wypisuje sciezke do katalogu (katalogow)
				FOLDER=`find / -type d -name $LOOKFOR -print 2>/dev/null` # przypisuje zmiennej FOLDER sciezke katalogu (katalogow) aby wykonac nastepne zadania
				if [ -z "$FOLDER" ]; then # instrukcja sprawdzajaca czy znaleziono folder o nazwie podanej przez uzytkownka
					echo -e "Nie znaleziono folderu o nazwie $RED $LOOKFOR"
					exit 0
				else
					echo "Liczba podfolderow:"
					find $FOLDER/* -maxdepth 1 -mindepth 0 -type d \( ! -iname ".*" \) | wc -l # wyszukuje sciezke katalogu oraz wypisuje liczbe podkatalogow tego katalogu
					echo "Liczba plikow zwyklych:" 
					find $FOLDER -maxdepth 1 -mindepth 0 -type f \( ! -iname ".*" \) | wc -l # wyszukuje sciezke katalogu oraz wypisuje liczbe plikow zwyklych
					echo "pliki zerowej dlugosci:"
					find $FOLDER -maxdepth 1 -size 0 -type f \( ! -iname ".*" \) | wc -l # wyszukuje sciezke katalogu oraz wypisuje pliki o rozmiarze 0
					echo "Calkowita objetosc tego katalogu (katalogow) wynosi:"
					du -bsh --bytes $FOLDER 2>/dev/null # wypisuje objetosc katalogu (katalogow) razem ze sciezka w bajtach a bledy wprowadza do urzadzenia pustego
				fi
			fi
			;;
		h)
			echo "Wpisz -i aby wypisac wszystkich uzytkownikow oraz informacje o ostatnio aktywnych uzytkownikach"
			echo "Wpisz -s aby wprowadzic wynik polecania ls -a do pliku tekst1.txt oraz wyslac wynik na poczte e-mail"
			echo "Wpisz -e aby wyswietlic zawartosc wszystkich plikow o nazwach zaczynajacych sie na a z katalogu /etc oraz wprowadzic wynik do pliku efekta"
			echo "Wpisz -b aby wprowadzic do pliku rezultat nazwy plikow wiekszych niz 100 bajtow z katalogu /etc"
			echo "Wpisz -c aby wyswietlic oraz dodac do pliku efekt nazwy plikow mniejszych niz 100 bajtow z katalogu /etc"
			echo "Wpisz -f aby wyszukac katalog o nazwie podanej przez uzytkownika oraz podac ilosc jego podfolderow, plikow zwyklych, plikow zwyklych o zerowej dlugosci oraz rozmiar tego folderu w bajtach"
			echo "Wpisz -h aby uzyskac pomoc (Opcja ktorej wlasnie uzyles)"
			exit 0
			;;
	esac
done