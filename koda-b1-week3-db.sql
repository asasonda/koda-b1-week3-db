CREATE DATABASE ewallet

SELECT current_database()
-- drop table users
-- drop table account
-- drop TABLE transactions


create table users(
    id int generated ALWAYS as IDENTITY PRIMARY KEY,
    username VARCHAR(50) not null,
    email VARCHAR(100) UNIQUE NOT NULL,
    password varchar(255) not null,
    created_at TIMESTAMP DEFAULT NOW()
)

create Table account(
    users_id int PRIMARY KEY REFERENCES users(id),
    fullname VARCHAR(100) not NULL,
    phone VARCHAR(20) NOT NULL,
    photo VARCHAR(255),
    pin VARCHAR(10) not NULL,
    balance BIGINT not NULL DEFAULT 0
)

create Table transactions(
    id int generated ALWAYS as IDENTITY PRIMARY KEY,
    sender_id int NOT NULL REFERENCES users(id),
    receiver_id int not NULL REFERENCES users(id),
    nominal BIGINT NOT NULL check(nominal > 0),
    type VARCHAR(10) not null DEFAULT 'transfer',
    status VARCHAR(20) DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT NOW()
)

-- register user
insert into users(username, email, password) VALUES
('asta_5@','asta@gmail.com', 'asta12345'),
('yno5','yunogmail.com', 'yuno12345'),
('noeSilva28','noellesilva@gmail.com', 'noelle12345'),
('ymiLL&','yami@gmail.com', 'yami12345'),
('js_juli','julius@gmail.com', 'julius12345'),
('vanes','vanessa@gmail.com', 'aVanessa12345'),
('lck55','luck@gmail.com', 'luck12345'),
('fnll09','finral@gmail.com', 'finral12345'),
('chrmmyy@','charmy@gmail.com', 'charmy12345'),
('gyrel:@','grey@gmail.com', 'grey12345')

select * from users

insert into account(users_id, fullname, phone, photo, pin, balance) VALUES
(1, 'Asta', '081345678900', 'asta.png', '349099', 345000),
(2, 'Yuno Grinberryall', '082312340099','yuno.png','301212', 567000 ),
(3, 'Noelle Silva', '081364559900','noelle.png','280934', 1250000),
(4, 'Yami Sukehiro', '081200994566','yami.png', '109523', 689500),
(5, 'Julius Novachrono', '081366009913','julius.jpg', '773801', 943000),
(6, 'Vanessa Enoteca', '084455160012','vanesa.png', '134511', 983000),
(7, 'Luck Voltia', '081210203040','luck.png','008943', 420000),
(8, 'Finral Roulacase', '081320670900','finral.jpg','102365', 670500),
(9, 'Charmy Pappitson', '081921820518','charmy.jpg','156631', 860000),
(10, 'Grey', '081309876543','grey.jpg','189900', 1050000)

select * from account

insert into transactions(sender_id, receiver_id, nominal, status) VALUES
(1,8,30000,'Success'),
(2,6,15000,'Success'),
(3,10,42500,'Success'),
(7,1, 100000, 'Success'),
(10,2, 10000, 'Success'),
(4,3,5000,'Success')

select * from transactions




-- register
insert into users(username, email, password) VALUES
('hbbibrzk29','habib@gmail.com', 'habib12345')

-- login
SELECT u.email, u.password 
from users u
WHERE u.email = 'habib@gmail.com' AND u.password = 'habib12345'

-- isi data profil akun
insert into account(users_id, fullname, phone, photo, pin)
select 
    u.id, 
    'Habib Rizki',
    '081500120001',
    'habib.jpg',
    '290102'
from users u
WHERE u.email = 'habib@gmail.com' AND u.password = 'habib12345'

-- Get user login information (username, email, photo)
SELECT 
    u.username, 
    u.email, 
    a.photo
FROM users u
join account a on a.users_id = u.id
WHERE u.email = 'habib@gmail.com' AND u.password = 'habib12345'

-- Get/Check user PIN
SELECT u.password
from users u
WHERE u.email = 'habib@gmail.com' AND u.password = 'habib12345'

-- Create transaction
-- income habib
insert into transactions(sender_id, receiver_id, nominal, status) VALUES
(5,12,30000,'Success')

update account
set balance = 30000
WHERE users_id = 12

-- expanse habib
insert into transactions(sender_id, receiver_id, nominal, status) VALUES
(12,9,7000,'Success'),
(12,1,1000,'Success')


update account
set balance = 30000 - 7000
WHERE users_id = 12

update account
set balance = 23000 - 1000
WHERE users_id = 12

-- transaction history (PR KERJAKAN BESOKKK!!)
SELECT
    a.fullname as name,
    a.phone as phone,
    'Sender' as category,
    t.type as metode,
    t.nominal
from transactions t
join users u on u.id = t.sender_id
join account a on a.users_id = u.id
WHERE u.email = 'habib@gmail.com' AND u.password = 'habib12345'

UNION ALL

SELECT
    a.fullname as name,
    a.phone as phone,
    'Receiver' as category,
    t.type as metode,
    t.nominal
from transactions t
join users u on u.id = t.receiver_id
join account a on a.users_id = u.id
WHERE u.email = 'habib@gmail.com' AND u.password = 'habib12345'


-- Get user history with option (income/expense, date range)
WITH income_expanse as (
    SELECT
        a.fullname as name,
        a.phone as phone,
        'Sender' as category,
        t.type as metode,
        t.nominal as nominal,
        t.created_at as date
    from transactions t
    join users u on u.id = t.sender_id
    join account a on a.users_id = u.id
    WHERE u.email = 'habib@gmail.com' AND u.password = 'habib12345'

    UNION ALL

    SELECT
        a.fullname as name,
        a.phone as phone,
        'Receiver' as category,
        t.type as metode,
        t.nominal as nominal,
        t.created_at as date
    from transactions t
    join users u on u.id = t.receiver_id
    join account a on a.users_id = u.id
    WHERE u.email = 'habib@gmail.com' AND u.password = 'habib12345'
)
select 
    name,
    phone,
    category,
    metode,
    nominal,
    date
from income_expanse
where category = 'Sender' and date between '2026-10-24 20:26:14.016099' and '2026-10-25 21:39:04.783059'


-- Get user account information (balance, income, expense)



-- Find receiver with pagination (misalnya: habib)
select
    a.fullname,
    a.phone
from transactions t
join users u on u.id = t.receiver_id
join account a on a.users_id = u.id
limit 5
offset 0


-- Get user profile (photo, full name, phone, email)
select 
    a.photo,
    a.fullname,
    a.phone,
    u.email
from account a 
join users u on u.id = a.users_id

-- Change PIN
update account
set pin = '367700'
WHERE users_id = 3

-- Change password
update users
set password = 'asta12345678'
WHERE id = 1

