# AdventureWorks – Försäljningsanalys

Detta repo innehåller en försäljningsanalys av AdventureWorks2025 (SQL Server) där data hämtas med SQL och analyseras/visualiseras i Python i en Jupyter Notebook.

## Innehåll
- `notebooks/analys.ipynb` – Notebook med 7 obligatoriska visualiseringar + djupanalys (Alternativ A)
- `data/` – SQL-filer (vis1–vis7 + vis_alt_a.sql) som använts för att testa queries i SSMS

## Projektstruktur
```txt
adventureworks-analys/
├─ data/
│  ├─ vis_alt_a.sql
│  ├─ vis1.sql
│  ├─ vis2.sql
│  ├─ vis3.sql
│  ├─ vis4.sql
│  ├─ vis5.sql
│  ├─ vis6.sql
│  └─ vis7.sql
├─ notebooks/
│  └─ analys.ipynb
├─ .gitignore
├─ README.md
└─ requirements.txt
```


## Förutsättningar

- SQL Server (lokalt) med databasen AdventureWorks2025 importerad från .bak
- ODBC Driver 18 for SQL Server
- Python 3.13.1

## Installation

Skapa och aktivera en virtuell miljö (valfritt men rekommenderas) och installera dependencies:
```bash
pip install -r requirements.txt
```

## Köra notebooken

Se till att SQL Server kör och att databasen AdventureWorks2025 finns lokalt.

Öppna `notebooks/analys.ipynb` i VS Code eller Jupyter.

Kör cellerna uppifrån och ned.

## Anslutning

Notebooken använder SQLAlchemy + pyodbc med Windows Trusted Connection.

Du kan behöva justera dessa värden i notebooken:
- `server = "localhost"`
- `database = "AdventureWorks2025"`


## SQL-filer

SQL-filerna i `data/` innehåller de queries som används för respektive visualisering samt djupanalysen (Alternativ A).

