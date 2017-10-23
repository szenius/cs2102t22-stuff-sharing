CREATE TYPE STATUS AS ENUM ('success', 'fail', 'pending');

CREATE TABLE "user" (
username VARCHAR(32) PRIMARY KEY,
password VARCHAR(32) NOT NULL,
first_name VARCHAR(16) NOT NULL,
last_name VARCHAR(16) NOT NULL,
email VARCHAR(64) NOT NULL UNIQUE,
photo VARCHAR(128) NOT NULL DEFAULT 'images/profile.jpg',
is_admin BOOLEAN DEFAULT FALSE
);

CREATE TABLE Category (
name VARCHAR(64) PRIMARY KEY
);

CREATE TABLE ItemListing (
id SERIAL PRIMARY KEY,
title VARCHAR(256) NOT NULL,
price DECIMAL(12,2) NOT NULL,
description TEXT,
pickup_location VARCHAR(128) NOT NULL,
return_location VARCHAR(128) NOT NULL,
post_date DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
is_avail BOOLEAN DEFAULT TRUE,
photo VARCHAR(128) NOT NULL DEFAULT 'images/item.jpg',
category_name VARCHAR(64) REFERENCES Category(name) ON DELETE CASCADE,
owner VARCHAR(32) REFERENCES "user"(username) ON DELETE CASCADE
CHECK(end_date >= start_date)
);

CREATE TABLE Bid (
id SERIAL PRIMARY KEY,
amount DECIMAL(12,2) NOT NULL,
date DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
bidding_status STATUS DEFAULT 'pending',
bidder VARCHAR(32) REFERENCES "user"(username) ON DELETE CASCADE,
itemlisting_id INT REFERENCES ItemListing(id) ON DELETE CASCADE
);