# Electronics Analytics

Projekt analityczny, w którym przeanalizowałem dane sprzedażowe międzynarodowego sprzedawcy elektroniki. Wykorzystałem zbiór danych **Global Electronics Retailer** z platformy Maven Analytics.

Chciałem sprawdzić, jak wygląda sprzedaż, które produkty generują największe przychody i zyski, jak zmieniają się wyniki w czasie oraz jakie informacje można wyciągnąć z danych o klientach i sklepach. Do analizy wykorzystałem SQL Server i Power BI.

## Cel projektu

Moim celem było przejście przez cały proces analizy danych — od pracy z danymi w SQL Server, przez przygotowanie zapytań analitycznych, aż po stworzenie interaktywnego dashboardu w Power BI.

Podczas pracy skupiłem się na:
- analizie przychodów, kosztów, zysku brutto i marży,
- badaniu trendów sprzedażowych w czasie,
- porównywaniu wyników kategorii i poszczególnych produktów,
- identyfikacji produktów generujących najwyższe przychody i zyski,
- porównaniu sprzedaży online ze sprzedażą w sklepach stacjonarnych,
- analizie klientów i wyników sklepów,
- tworzeniu rankingów produktów i klientów,
- analizie ABC produktów,
- analizie kohortowej klientów,
- wykorzystaniu przychodów kroczących do badania zmian w sprzedaży,
- analizie trendów sprzedażowych i przygotowaniu prognoz.

## Wykorzystane technologie

- **SQL Server** — do pracy z bazą danych i przeprowadzania analiz.
- **SQL** — do łączenia tabel, agregowania danych, tworzenia rankingów i analizowania trendów.
- **Power BI** — do stworzenia interaktywnego dashboardu.
- **DAX** — do tworzenia miar, takich jak przychód, zysk brutto i marża, które reagują na filtry raportu.
- **Power Query** — do przygotowania i transformacji danych na potrzeby analizy.

## Analiza SQL

Przygotowałem zestaw zapytań SQL obejmujących różne obszary analizy sprzedaży:

1. Executive Overview — najważniejsze wskaźniki biznesowe.
2. Revenue Trend — zmiany przychodów w czasie.
3. Category Performance — wyniki kategorii produktów.
4. Product Performance — analiza wyników produktów.
5. Store Performance — porównanie sklepów.
6. Customer Performance — analiza klientów.
7. Product Ranking — ranking produktów.
8. Monthly Product Performance — miesięczne wyniki produktów.
9. Online vs Store — porównanie kanałów sprzedaży.
10. Customer Revenue Ranking — ranking klientów według przychodów.
11. Monthly Rolling Revenue — analiza kroczących przychodów.
12. ABC Product Analysis — klasyfikacja produktów metodą ABC.
13. Customer Cohort Analysis — analiza kohortowa klientów.
14. Sales Trend Forecast — analiza trendów i prognozowanie sprzedaży.
15. Executive Business Summary — podsumowanie najważniejszych wyników.

Podczas pracy wykorzystywałem między innymi JOIN, GROUP BY, podzapytania, CTE oraz funkcje okna. Dzięki temu mogłem przeprowadzać bardziej zaawansowane analizy niż samo obliczanie podstawowych wskaźników.

## Dashboard Power BI

Na podstawie danych i przeprowadzonych analiz stworzyłem interaktywny dashboard składający się z trzech stron:

- **Executive Overview** — podsumowanie wyników sprzedaży, kluczowe wskaźniki i trendy przychodów.
- **Product Performance** — rankingi produktów według przychodów i zysku brutto oraz porównanie wyników poszczególnych produktów.
- **Customers & Stores** — analiza klientów i wyników sklepów.

Zależało mi na tym, żeby raport nie ograniczał się do prezentowania liczb. Dodałem interaktywne filtry i miary DAX, dzięki którym mogę analizować wyniki z różnych perspektyw i sprawdzać, jak zmieniają się poszczególne wskaźniki.

## Struktura projektu

```text
ElectronicsAnalytics/
├── SQL/
│   ├── Executive_Overview.sql
│   ├── Revenue_Trend.sql
│   ├── Category_Performance.sql
│   ├── Product_Performance.sql
│   ├── Store_Performance.sql
│   ├── Customer_Performance.sql
│   └── ...
├── PowerBI/
│   └── ElectronicsAnalytics.pbix
├── Images/
│   ├── executive-overview.png
│   ├── product-performance.png
│   └── customers-stores.png
└── README.md
```


## Czego nauczyłem się podczas projektu?

Podczas realizacji projektu rozwinąłem umiejętności pracy z SQL Server, tworzenia zapytań analitycznych oraz wykorzystywania Power BI do prezentowania wyników. Przećwiczyłem również pracę z funkcjami okna, CTE, rankingami, analizą ABC i kohortami klientów.

Najważniejsze było dla mnie połączenie analizy SQL z interaktywnym raportem Power BI, tak aby na podstawie danych można było nie tylko obliczyć wyniki, ale też łatwiej je interpretować i wyciągać wnioski biznesowe.

