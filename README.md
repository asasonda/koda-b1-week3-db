# Database ERD

``` mermaid
erDiagram
    USERS ||--|| PROFILE : has
    USERS ||--o{ TRANSACTIONS : has
    TRANSACTIONS ||--|| TRANSACTION_HISTORY : has
    USERS{
        int ID PK
        varchar(UQ) email
        varchar password
        varchar pin
        varchar balance
    }
    PROFILE{
        int ID PK
        int users_id FK
        varchar fullname
        varchar phone
        varchar address
        varchar photo
    }
    TRANSACTIONS{
        int ID PK
        int users_id FK
        varchar contact_pengirim
        varchar contact_penerima
        varchar nominal
        timestamp created_at
        varchar status
    }
    TRANSACTION_HISTORY{
        int ID PK
        int transactions_id FK
        timestamp created_at
    }

```