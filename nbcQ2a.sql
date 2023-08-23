DROP DATABASE IF EXISTS `nbchw2q2`;
CREATE DATABASE IF NOT EXISTS `nbchw2q2`;
use nbchw2q2;

-- Employees
DROP table if exists Employees;
CREATE table Employees(
	employeeID int,
    addr varchar(50),
    Firstname varchar(10),
    Lastname varchar(20),
    phone_num varchar(10),
    primary key(employeeID)
);

-- Managers
DROP table if exists Managers;
CREATE table Managers(
	employeeID int not null,
    mgrID int,
	salary float,
    maxSupCap int,
	primary key(mgrID),
    foreign key(employeeID) references Employees(employeeID),
    unique(employeeID)
);

-- FullTime_Workers
DROP table if exists Ftime_workers;
CREATE table Ftime_workers(
	employeeID int not null,
    ftID int,
	title varchar(20),
    salary float,
    primary key(ftID),
    foreign key(employeeID) references Employees(employeeID)
);

-- ProductTypes
DROP table if exists ProductTypes;
CREATE table ProductTypes(
	typeName varchar(20),
    primary key(typeName)
);

-- Products
DROP table if exists Products;
CREATE table Products(
	itemID int,
    pname varchar(30),
    price float,
    remainingQTY int,
    ptype varchar(20) not null,
    primary key(itemID),
    foreign key(ptype) references ProductTypes(typeName)
);

-- Hourly Workers
DROP table if exists Hourly_workers;
CREATE table Hourly_workers(
	hID int,
    employeeID int not null,
    make int not null,
	speciality varchar(30),
    hpw int,
    wage int,
    primary key(hID),
    foreign key(employeeID) references Employees(employeeID),
    foreign key(make) references Products(itemID)
);

-- Customers
DROP table if exists Customers;
CREATE table Customers(
	custID int(11),
    Firstname varchar(10),
    Lastname varchar(20),
    addr varchar(50),
    primary key(custID)
);

-- Purchase
DROP table if exists Purchase;
CREATE table Purchase(
	qty int,
    custID int,
    itemID int,
    primary key(custID, itemID),
    foreign key(custID) references Customers(custID),
    foreign key(itemID) references Products(itemID)
);

-- Suppliers
DROP table if exists Suppliers;
CREATE table Suppliers(
	sname varchar(30),
    addr varchar(50),
    primary key(sname)
);

-- Ingredients
DROP table if exists Ingredients;
CREATE table Ingredients(
	itemID int(11),
    descript varchar(50),
    primary key(itemID)
);

-- BoughtFrom
DROP table if exists BoughtFrom;
CREATE table BoughtFrom(
	quty int,
    price float,
    dop date,
    pID int,
    iID int,
    sname varchar(30),
    primary key(pID, iID, sname),
    foreign key(pID) references Products(itemID),
    foreign key(iID) references Ingredients(itemID),
    foreign key(sname) references Suppliers(sname)
);

