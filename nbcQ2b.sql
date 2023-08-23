use nbchw2q2;

SET FOREIGN_KEY_CHECKS=0;

-- Employees
truncate Employees;

INSERT INTO Employees VALUES (123, '123 Sesame Street', 'Cookie', 'Monster', 1234567890);
INSERT INTO Employees VALUES (456, '456 Sesame Street', 'Elmo', 'Omle', 4567890123);
INSERT INTO Employees VALUES (789, '789 Sesame Street', 'Big', 'Bird', 7890123456);
INSERT INTO Employees VALUES (512, '012 Sesame Street', 'Oscar', 'Grouch', 5123456789);

INSERT INTO Employees VALUES (678, '678 Sesame Street', 'bill', 'nye', 6758952546);
INSERT INTO Employees VALUES (901, '901 Sesame Street', 'oliver', 'queen', 8974531235);
INSERT INTO Employees VALUES (234, '234 Sesame Street', 'jim', 'jam', 5537897653);
INSERT INTO Employees VALUES (567, '567 Sesame Street', 'tiki', 'tiki', 8908765432);

INSERT INTO Employees VALUES (890, '890 Sesame Street', 'ghost', 'most', 1543268907);
INSERT INTO Employees VALUES (321, '321 Sesame Street', 'phil', 'collins', 6678986532);
INSERT INTO Employees VALUES (632, '632 Sesame Street', 'red', 'green', 3467876543);
INSERT INTO Employees VALUES (876, '876 Sesame Street', 'doctor', 'strange', 6783464327);

-- Managers
truncate Managers;

INSERT INTO Managers VALUES (678, 678, 72000, 5);
INSERT INTO Managers VALUES (901, 901, 92000, 1);
INSERT INTO Managers VALUES (234, 234, 1000000, 6);
INSERT INTO Managers VALUES (567, 567, 1200, 7);

-- FullTime_Workers
truncate Ftime_workers;

INSERT INTO Ftime_workers VALUES (123, 123, 'cookie liaison', 5000000);
INSERT INTO Ftime_workers VALUES (789, 789, 'bird watcher', 50);
INSERT INTO Ftime_workers VALUES (890, 890, 'fire starter stopper', 0.62);
INSERT INTO Ftime_workers VALUES (321, 321, 'number 1', 1);

-- ProductTypes
truncate ProductTypes;

INSERT INTO ProductTypes VALUES ('cookie');
INSERT INTO ProductTypes VALUES ('can');
INSERT INTO ProductTypes VALUES ('sign');
INSERT INTO ProductTypes VALUES ('bubble');

-- Products
truncate Products;

INSERT INTO Products VALUES (42, 'choc chip cookie', 3000, 90, 'cookie');
INSERT INTO Products VALUES (52, 'garbage can', 420, 37, 'can');
INSERT INTO Products VALUES (88, 'street sign', 100, 1000, 'sign');
INSERT INTO Products VALUES (74, 'half a bubble', .01, 1000000, 'bubble');

-- Hourly Workers
truncate Hourly_workers;

INSERT INTO Hourly_workers VALUES (512, 512, 52, 'metal', 60, 15);
INSERT INTO Hourly_workers VALUES (632, 632, 88, 'metal', 60, 15);
INSERT INTO Hourly_workers VALUES (876, 876, 74, 'chemicals', 60, 15);
INSERT INTO Hourly_workers VALUES (456, 456, 42, 'baking', 60, 15);

-- Customers
truncate Customers;

INSERT INTO Customers VALUES (123, 'Cookie', 'Monster', '123 Sesame Street');
INSERT INTO Customers VALUES (999, 'Peter', 'Parker', '212 New York Lane');
INSERT INTO Customers VALUES (888, 'Tim', 'Tom', '479 Time Road');
INSERT INTO Customers VALUES (777, 'Rufus', 'Rooster', '31 Farm Square');

-- Purchase
truncate Purchase;

INSERT INTO Purchase VALUES (90, 123, 42);
INSERT INTO Purchase VALUES (7000, 999, 74);
INSERT INTO Purchase VALUES (80, 888, 52);
INSERT INTO Purchase VALUES (2, 777, 88);

-- Suppliers
truncate Suppliers;

INSERT INTO Suppliers VALUES ('Count Chocula', '62 Vampire Castle Way');
INSERT INTO Suppliers VALUES ('Frankenstein', '100 Scary Road');
INSERT INTO Suppliers VALUES ('Tesla', '123 Elon Drive');
INSERT INTO Suppliers VALUES ('Spongebob Bubble Company', 'Bikini Bottom');

-- Ingredients
truncate Ingredients;

INSERT INTO Ingredients VALUES(33, 'Dark Chocolate from a spooky forest cocoa bean');
INSERT INTO Ingredients VALUES(44, 'Iron forged in the heart of a dying star');
INSERT INTO Ingredients VALUES(55, 'Synthetic metal and plastic compounds');
INSERT INTO Ingredients VALUES(66, 'Experimental chemicals');

-- BoughtFrom
truncate BoughtFrom;
 
INSERT INTO BoughtFrom VALUES(90, 3000, '2022-11-10', 42, 33, 'Count Chocula');
INSERT INTO BoughtFrom VALUES(7000, 420, '2022-10-7', 74, 44, 'Frankenstein');
INSERT INTO BoughtFrom VALUES(80, 100, '2022-9-5', 52, 55, 'Tesla');
INSERT INTO BoughtFrom VALUES(2, 0.01, '1980-11-10', 88, 66, 'Spongebob Bubble Company');